import http from 'k6/http';
import { sleep } from 'k6';
import { expect } from "https://jslib.k6.io/k6-testing/0.5.0/index.js";

const config = {
    baseUrl: __ENV.TARGET_URL || 'http://system-under-test:8080',
    endpoints: [
        "/owners/1",
        "/owners/2",
        "/owners/3"
    ],
    virtualUsers: parseInt(__ENV.VUS || '10'),
    duration: __ENV.DURATION || '30s',
};

// Utility function for URL construction
const buildUrl = (base, path) => {
    //return `${base}/${path}`;
    return base.concat(path);
};

export const options = {
    vus: config.virtualUsers,
    duration: config.duration,
};

// The default exported function is gonna be picked up by k6 as the entry point for the test script.
// It will be executed repeatedly in "iterations" for the whole duration of the test.
export default function() {
    config.endpoints.forEach(endpoint => {
        let res = http.get(buildUrl(config.baseUrl, endpoint));
        expect.soft(res.status).toBe(200);
    });

    sleep(1);
}
