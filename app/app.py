import os
from flask import Flask, jsonify
app = Flask(__name__)

@app.get("/health")
def health():
    app.logger.error("health check failed: database unreachable")
    return jsonify(status="error"), 500

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
# commentaire
