import http from 'k6/http';
import { sleep } from 'k6';
import { expect } from "https://jslib.k6.io/k6-testing/0.5.0/index.js";

// Utility function for URL construction
const buildUrl = (base, path) => {
    return base.concat(path);
};

const systemUnderTest = {
    baseUrl: __ENV.TARGET_URL || 'http://system-under-test:8080',
    endpoints: [
        "/owners/1",
        "/owners/2",
        "/owners/3"
    ],
};

export const options = {
    scenarios: {
        constant: {
            executor: 'constant-vus',
            vus: 40, // virtual users
            duration: '300s',
            startTime: '0s',
        },
        rampUp: {
            executor: 'ramping-vus',
            startVUs: 10,
            stages: [
                { duration: '75s', target: 20 },
                { duration: '75s', target: 40 },
                { duration: '75s', target: 60 },
                { duration: '75s', target: 80 },
            ],
            startTime: '360s',
            gracefulRampDown: '30s',
        },
    },
};

// The default exported function is gonna be picked up by k6 as the entry point for the test script.
// It will be executed repeatedly in "iterations" for the whole duration of the test.
export default function() {
    systemUnderTest.endpoints.forEach(endpoint => {
        let result = http.get(buildUrl(systemUnderTest.baseUrl, endpoint));
        expect.soft(result.status).toBe(200);
    });
    sleep(1);
}
