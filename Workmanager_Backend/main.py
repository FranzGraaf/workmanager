import requests
import time
from flask import Flask, request, jsonify, session, Response, stream_with_context
from flask_cors import CORS
import json






if __name__ == "__main__":
    app = Flask(__name__)
    CORS(app, supports_credentials=True) # used to test the application locally in connection with a web browser



    @app.route('/addieren', methods=["GET", "POST"])
    def addieren():
        try:
            zahl_1 = json.loads(request.data)["zahl_1"]
            zahl_2 = json.loads(request.data)["zahl_2"]
            summe = zahl_1 + zahl_2
            return jsonify({"summe": summe})
        except Exception as e:
            print(e)
        return jsonify("0")




    app.run() # for development
    #app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080))) # for production