from flask import Flask, jsonify
import requests
import socket
import time

app = Flask(__name__)

CONSUL_URL = "http://consul:8500"
SERVICE_NAME = "service-a"
SERVICE_PORT = 5001


def register_service():
    service_id = f"{SERVICE_NAME}-{socket.gethostname()}"

    payload = {
        "ID": service_id,
        "Name": SERVICE_NAME,
        "Address": SERVICE_NAME,
        "Port": SERVICE_PORT,
        "Check": {   
            "HTTP": f"http://{SERVICE_NAME}:{SERVICE_PORT}/info",
            "Interval": "10s"
        }
    }

    for i in range(5):  # retry mechanism
        try:
            res = requests.put(
                f"{CONSUL_URL}/v1/agent/service/register",
                json=payload
            )

            if res.status_code == 200:
                print(f"{SERVICE_NAME} registered with Consul")
                return
            else:
                print("Consul returned error:", res.text)

        except Exception as e:
            print(f"Retry {i+1}: Consul not ready, retrying...")

        time.sleep(2)

    print("Failed to register service with Consul")


@app.route("/info")
def info():
    return jsonify({
        "service": "A",
        "time": str(time.time()),
        "host": socket.gethostname()   # useful for load balancing later
    })


if __name__ == "__main__":
    time.sleep(5)  # wait for consul container
    register_service()
    app.run(host="0.0.0.0", port=SERVICE_PORT)