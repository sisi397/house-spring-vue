import { apiInstance } from "./index.js";

const api = apiInstance();

function listNews(success, fail) {
  api.get(`/crawling`).then(success).catch(fail);
}

export { listNews };
