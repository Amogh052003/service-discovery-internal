from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route("/info")
def info():
    return {
        "service": "A",
        "time": str(datetime.now())
    }

app.run(host="0.0.0.0", port=5001)