from flask import Flask, jsonify
import requests

app = Flask(__name__)

CONSUL_URL = "http://consul:8500"

def get_service(service_name):
    url = f"{CONSUL_URL}/v1/catalog/service/{service_name}"
    res = requests.get(url)
    data = res.json()

    if not data:
        return None

    service = data[0]
    address = service["ServiceAddress"]
    port = service["ServicePort"]

    return f"http://{address}:{port}"


@app.route("/<service>/info")
def route(service):
    service_url = get_service(service)

    if not service_url:
        return jsonify({"error": "Service not found"}), 404

    res = requests.get(f"{service_url}/info")
    return jsonify(res.json())


app.run(host="0.0.0.0", port=8000)