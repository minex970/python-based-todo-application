import http from "k6/http";
import { check, fail } from "k6";

export const options = {
    vus: 150,
    duration: '30s',
};

// Retrieve BASE_URL from the environment variables
const BASE_URL = __ENV.BASE_URL;

// Check if BASE_URL is provided
if (!BASE_URL) {
    fail("Error: BASE_URL environment variable is not set. Please provide it using -e BASE_URL=<value>.");
}

function demo() {
    const url = `${BASE_URL}`;

    let resp = http.get(url);

    check(resp, {
        'endpoint was successful': (resp) => {
            if (resp.status === 200) {
                console.log(`PASS! ${url}`);
                return true;
            } else {
                console.error(`FAIL! status-code: ${resp.status}`);
                return false;
            }
        }
    });
}

export default function () {
    demo();
}
