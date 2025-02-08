import { defineString } from "firebase-functions/params";
import * as admin from "firebase-admin";
import * as axios from "axios";
import { onSchedule } from "firebase-functions/scheduler";

admin.initializeApp();
interface LostArkItem {
  Id: number;
  Name: string;
  Grade: string;
  YDayAvgPrice: number;
}

interface LostArkResponse {
  Items: LostArkItem[];
}

const apiKey = defineString("LOA_API_KEY");
const apiEndPoint = defineString("LOA_POST_ITEM_API_ENDPOINT");

const reinforceKeywords = ["파괴", "수호", "돌파", "파편", "융화", "에스더"];

exports.recordDailyPrices = onSchedule(
  {
    schedule: "0 18 * * *",
    timeZone: "Asia/Seoul",
    region: "asia-northeast3",
  },
  async (context) => {
    const db = admin.firestore();
    const batch = db.batch();

    try {
      // 재련 재료 데이터 가져오기
      const reinforceItems: LostArkItem[] = [];
      for (const keyword of reinforceKeywords) {
        const response = await axios.post<LostArkResponse>(
          apiEndPoint.value(),
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
        reinforceItems.push(...response.data.Items);
      }

      // 각인서 데이터 가져오기
      const engraveItems: LostArkItem[] = [];
      for (let page = 1; page <= 10; page++) {
        const response = await axios.post<LostArkResponse>(
          apiEndPoint.value(),
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
        engraveItems.push(...response.data.Items);
      }

      const allItems = [...reinforceItems, ...engraveItems];

      // 가격 기록
      for (const item of allItems) {
        const doc = db.collection("price_history").doc();
        batch.set(doc, {
          Id: item.Id,
          Name: item.Name,
          Grade: item.Grade,
          YDayAvgPrice: item.YDayAvgPrice,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      console.log("Daily price recording completed");
    } catch (error) {
      console.error("Error recording prices:", error);
      throw error;
    }
  }
);
