import { onSchedule } from "firebase-functions/v2/scheduler";
import { defineString } from "firebase-functions/params";
import * as admin from "firebase-admin";
import axios from "axios";

interface LostArkItem {
  Id: number;
  Name: string;
  Grade: string;
  YDayAvgPrice: number;
  CurrentMinPrice: number;
}

interface LostArkResponse {
  Items: LostArkItem[];
}

admin.initializeApp();

const apiKey = defineString("LOA_API_KEY");
const apiEndpoint = defineString("LOA_POST_ITEM_API_ENDPOINT");

const reinforceKeywords = ["파괴", "수호", "돌파", "파편", "융화", "에스더"];

exports.recordDailyPrices = onSchedule(
  {
    schedule: "0 18 * * *",
    timeZone: "Asia/Seoul",
    region: "asia-northeast3",
  },
  async () => {
    const db = admin.firestore();
    const batch = db.batch();

    try {
      console.log("Starting to fetch reinforce items...");
      // 재련 재료 데이터 가져오기
      const reinforceItems: LostArkItem[] = [];
      for (const keyword of reinforceKeywords) {
        const response = await axios.post<LostArkResponse>(
          apiEndpoint.value(),
          {
            CategoryCode: 50000,
            ItemName: keyword,
            SortCondition: "ASC",
          },
          {
            headers: {
              accept: "application/json",
              authorization: `bearer ${apiKey.value()}`,
              "Content-Type": "application/json",
            },
          }
        );
        console.log(`Found ${response.data.Items.length} items for ${keyword}`);
        response.data.Items.forEach((item) => {
          console.log(
            `Item: ${item.Name}, Price: ${item.CurrentMinPrice}, Grade: ${item.Grade}`
          );
        });
        reinforceItems.push(...response.data.Items);
      }
      console.log("Starting to fetch engrave items...");
      // 각인서 데이터 가져오기 (1-10 페이지)
      const engraveItems: LostArkItem[] = [];
      for (let page = 1; page <= 10; page++) {
        const response = await axios.post<LostArkResponse>(
          apiEndpoint.value(),
          {
            CategoryCode: 40000,
            ItemName: "",
            PageNo: page,
            SortCondition: "ASC",
          },
          {
            headers: {
              accept: "application/json",
              authorization: `bearer ${apiKey.value()}`,
              "Content-Type": "application/json",
            },
          }
        );
        console.log(`Found ${response.data.Items.length} items for engrave`);
        response.data.Items.forEach((item) => {
          console.log(
            `Item: ${item.Name}, Price: ${item.CurrentMinPrice}, Grade: ${item.Grade}`
          );
        });
        engraveItems.push(...response.data.Items);
      }

      const allItems = [...reinforceItems, ...engraveItems];

      // 가격 기록
      for (const item of allItems) {
        const today = new Date();
        const formattedDate = `${today.getFullYear()}.${String(
          today.getMonth() + 1
        ).padStart(2, "0")}.${String(today.getDate()).padStart(2, "0")}`;

        const itemDoc = db.collection("items").doc(item.Name);
        const existingDoc = await itemDoc.get();

        // 이미 오늘 기록이 있는지 확인
        if (
          existingDoc.exists &&
          existingDoc.data()?.priceHistory?.[formattedDate]
        ) {
          console.log(
            `There is already a price record for ${item.Name} on ${formattedDate}`
          );
          continue;
        }

        batch.set(
          itemDoc,
          {
            Id: item.Id,
            Name: item.Name,
            Grade: item.Grade,
            lastUpdated: formattedDate,
            priceHistory: {
              [formattedDate]: {
                YDayAvgPrice: item.YDayAvgPrice,
                CurrentMinPrice: item.CurrentMinPrice,
              },
            },
          },
          { merge: true }
        );
      }

      await batch.commit();
      console.log("Daily price recording completed");
    } catch (error) {
      console.error("Error recording prices:", error);
      throw error;
    }
  }
);
