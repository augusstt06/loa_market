# Loa Market

An app that allows you to easily check the prices of items from the Lost Ark auction through the app

Fisrt of All, this project plan to give priority to searching for goods needed for character development.
ㄴ
Below are examples of items that meet the conditions.

- 파괴/수호석
- 명예/운명의 파편
- 오레하/아비도스 융화재료
- 에스더의 기운
- 태양의 은총/축복/가호
- 용암/빙하의 숨결

## Screens

### 1. Home

The first screen displayed when entering the app.

- **Notice Widget(공지사항)**

  - Notice from Lost Ark public homepage.

  - Show the 3 most recent notice tabs, moves to the public homepage when clicked.

- Development Announcement Widget(개발 공지)

  - Announcements that occur while developing the app.

  - Display briefly in the center of the screen.

- **Search Widget(검색창)**

  - Search Widget to search for items.

  - When searching, move to a screen that shows items matching the search term.

- **Crystal Price Widget (크리스탈 가격)**

  - Shows the current crystal price.

  - The price is updated through API once an hour.

### 2. Search Result

When searching, a screen that lists items that match the search term.

- **Item List Widget(아이템 목록)**

  - List items that match the search term.

  - **Include the nickname by which users call the item.**

    > e.g "숨결" 검색시 용암/빙하의 숨결 이외, 태양의 축복,은총,가호 리스트업.

  - When clicked on item, go ro item detail screen.

- **Item Detail Widget(아이템 상세)**

  - Shows the details of the item.

  - When clicked, move to a screen that shows the details of the item.

### 3. Item Detail

When clicked on item, a screen that shows the details of the item.

- **Info Widget(정보)**

  - Shows the details of the item.

    - Item name, current price.

  - Show a graph fo the item price for the most recent month.

## API

This is the API used in the project.

### [Lostark API](https://developer-lostark.game.onstove.com/)

- **POST /markets/items**

  ```json
   // Endpoint: https://developer-lostark.game.onstove.com/markets/items
   // parmateter
   {
        sort: "GRADE",
        categoryCode: int,
        itemName: string,
        PageNo: 0,
        SortCondition: "ASC"
   }

   // response
   {
        "PageNo": int
        "PageSize": int
        "TotalCount": int
        "Items": [
            {
                "Id": int
                "Name": string
                "Grade": string
                "Icon": string
                "BundleCount": int
                "TradeRemainCount": int(default: null)
                "YDayAvgPrice": int
                "RecentPrice": int
                "CurrentMinPrice": int
            }
        ]
   }
  ```

- **GET /markets/items/price-trends**

  ```json
  // Endpoint : https://developer-lostark.game.onstove.com/news/notices
  // response
  {
    "Title": string
    "Date": string
    "Link": string
    "Type": string
  },
  ```

### [Externel API](https://lostarkapi.info/docs#/)

- **GET /crystal/**

  ```json
  // Endpoint : https://lostarkapi.info/crystal/
  // response
  {
    "Buy": string
    "Sell": string
    "Date": string
    "Result": string
  }
  ```
