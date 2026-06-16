import os

from flask import Flask

app = Flask(__name__)

FILE = "/data/message.txt"

@app.route("/")
def hello():
    greet = os.getenv("GREETING", "Hello, world!")

    os.makedirs(os.path.dirname(FILE), exist_ok=True)
    
    if not os.path.exists(FILE):
        with open(FILE, "w") as f:
            f.write("Hello from Persistent Volume!")

    with open(FILE) as f:
        return f.read()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
