import http from 'k6/http';
export const options = {
  noCookiesReset: true,
}

export default function () {
  let jar = http.cookieJar();
  const res = http.get('http://192.168.1.220:8080/sql');
}
