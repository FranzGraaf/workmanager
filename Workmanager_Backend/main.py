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


    @app.route('/daily', methods=["GET", "POST"])
    def get_day(time):
        today = []
        aufgaben = {"5" : ["putzen","prio"], "2" : ["putzen","non_prio"], "3" : ["putzen","non_prio"], "6" : ["putzen","non_prio"], "7" : ["putzen","non_prio"] }
        time_aufgaben_gesamt = []
        while time > sum(time_aufgaben_gesamt):
            for time_needed,aufgabe in aufgaben.items():
                if "prio" in aufgabe and time > time_needed:
                    today.append(aufgabe)
                    time_aufgaben_gesamt.append(time)
                elif



    app.run() # for development
    #app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080))) # for production