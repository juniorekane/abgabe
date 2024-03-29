import http from 'k6/http';
export const options = {
  noCookiesReset: true,
}

export default function () {
  let jar = http.cookieJar();
  const res = http.get('http://127.0.0.1:3306/mariadb');
}
