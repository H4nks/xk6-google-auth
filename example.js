import gcp from 'k6/x/google';
import http from 'k6/http';
import { check, sleep } from 'k6';

// if your cloud run instance is running behind a loadbalancer, baseurl and audience will be different
const baseurl = "https://my-cloud-run-domain-xxxxx-yy.a.run.app";
const audience = "https://my-cloud-run-domain-xxxxx-yy.a.run.app";

const params = {
    headers: { 'Authorization': 'Bearer ' + gcp.getIdToken(audience) }
}

export default function () {
    const res = http.get(baseurl + "/api/v1/ping", params);
    check(res, {
        'response code was 200': (res) => res.status == 200,
    });
    sleep(1);
}