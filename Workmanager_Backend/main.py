import requests
import time
import datetime
from flask import Flask, request, jsonify, session, Response, stream_with_context
from flask_cors import CORS
import json
from DB_Interactions.db_init import DB_Init
import firebase_admin
from firebase_admin import credentials, firestore, storage, auth




def increment_counter(db):
    doc_ref = db.collection(u"Test").document(u"TD_1")
    try:
        old_count = doc_ref.get().to_dict()[u"Testcounter"]
        doc_ref.update({
            u"Testcounter": old_count+1,
        })
    except Exception as e:
        doc_ref.update({
            u"Testcounter": 1,
        })


#request.headers <- header
#json.loads(request.data) <- body

if __name__ == "__main__":
    app = Flask(__name__)
    CORS(app, supports_credentials=True) # used to test the application locally in connection with a web browser
    db_init = DB_Init()
    db = firestore.client()
    #bucket = db_init.get_bucket()


    #increment_counter(db)


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

    @app.route('/increment_counter', methods=["GET", "POST"])
    def increment_counter():
        doc_ref = db.collection(u"Test").document(u"TD_1")
        try:
            old_count = doc_ref.get().to_dict()[u"Testcounter"]
            doc_ref.update({
                u"Testcounter": old_count+1,
            })
            return jsonify(True)
        except Exception as e:
            doc_ref.update({
                u"Testcounter": 1,
            })
        return jsonify(False)


    @app.route('/create_user', methods=["GET", "POST"])
    def create_user():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            doc_ref.set({
                "Creation_Time": datetime.datetime.now(),
                "Monday_Time": [],
                "Tuesday_Time": [],
                "Wednesday_Time": [],
                "Thursday_Time": [],
                "Friday_Time": [],
                "Saturday_Time": [],
                "Sunday_Time": [],
                "Tasks_Open": [],
                "Tasks_Done": [],
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)





    app.run() # for development
    #app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080))) # for production