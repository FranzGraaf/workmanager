import requests
import time
import datetime
from flask import Flask, request, jsonify, session, Response, stream_with_context
from flask_cors import CORS
import json
from DB_Interactions.db_init import DB_Init
import firebase_admin
from firebase_admin import credentials, firestore, storage, auth


#request.headers <- header
#json.loads(request.data) <- body


if __name__ == "__main__":
    app = Flask(__name__)
    CORS(app, supports_credentials=True) # used to test the application locally in connection with a web browser
    db_init = DB_Init()
    db = firestore.client()
    #bucket = db_init.get_bucket()




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

    '''
    TODO: sort the users tasks_open list 
    HEADER: {"id_token": <string>}
    BODY: {} 
    RETURN: {sortierte Task_Open Liste}
    '''

    @app.route('/sort_open_tasks', methods=['POST'])
    def sort_open_tasks():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Open"]
            schedule = []
            for ind, element in enumerate(tasks):
                m = element.split(": ")
                z = m[3].split(", ")
                x = (ind, z[0])
                schedule.append(x)
            def takeSecond(elem):
                return elem[1]
            schedule.sort(key=takeSecond)
            n = [i[0] for i in schedule]
            sorted_tasks = [x for _, x in sorted(zip(n, tasks))]
            return jsonify(sorted_tasks)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    Ändern eines Elements der Task_Done Liste 
    HEADER: {"id_token": <string>} 
    BODY: [{"titel": "altes Element", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1}, {"titel": "neues Element", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1}] 
    RETURN: {sortierte Task_Open Liste} 
    '''

    @app.route('/change_task_done', methods=['POST'])
    def change_task_done():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Open"]
            tasks.remove(task[0])
            tasks.append(task[1])
            doc_ref.update({
                "Tasks_Open": tasks
            })
            sort_open_tasks()
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    Ändern eines Elements der Task_Open Liste 
    HEADER: {"id_token": <string>} 
    BODY: [{"titel": "altes Element", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1}, {"titel": "neues Element", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1}] 
    RETURN: {sortierte Task_Open Liste} 
    '''

    @app.route('/change_task_open', methods=['POST'])
    def change_open_task():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Open"]
            tasks.remove(task[0])
            tasks.append(task[1])
            #open_tasks sort function()
            doc_ref.update({
                "Tasks_Open": tasks
            })
            sort_open_tasks()
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: Remove a task map from the users tasks_done list 
    HEADER: {"id_token": <string>} 
    BODY: {"titel": "Einkaufen", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1} 
    RETURN: {True/False}
    '''

    @app.route('/delete_done_task', methods=['POST'])
    def remove_done_task():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Done"]
            tasks.remove(task)
            doc_ref.update({
                "Tasks_Done": tasks
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: Add a task map to the users tasks_done list 
    HEADER: {"id_token": <string>} 
    BODY: {"titel": "Einkaufen", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1} 
    RETURN: {True/False} 
    '''

    @app.route('/task_to_done', methods=['POST'])
    def add_done_task():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Done"]
            tasks.append(task)
            doc_ref.update({
                "Tasks_Done": tasks
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: Remove a task map from the users tasks_open list 
    HEADER: {"id_token": <string>} 
    BODY: {"titel": "Einkaufen", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1} 
    RETURN: {True/False} 
    '''

    @app.route('/delete_open_task', methods=['POST'])
    def remove_open_task():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Open"]
            tasks.remove(task)
            doc_ref.update({
                "Tasks_Open": tasks
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: Add a task map to the users tasks_open list 
    HEADER: {"id_token": <string>} 
    BODY: {"titel": "Einkaufen", "duration": 01:00, "deadline": 05.01.2021 0:00, "description": "", "priority": 1} 
    RETURN: {True/False} 
    '''

    @app.route('/task_to_open', methods=['POST'])
    def add_open_task():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            task = json.loads(request.data)
            tasks = doc_ref.get().to_dict()["Tasks_Open"]
            tasks.append(task)
            doc_ref.update({
                "Tasks_Open": tasks
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: general change users data 
    HEADER: {"id_token": <string>} 
    BODY: {"name": <string>, "value": <dynamic>}
    RETURN: {True/False} 
    '''

    @app.route('/change_user_data', methods=['POST'])
    def change_user_data():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            fieldname = json.loads(request.data)["name"]
            new_value = json.loads(request.data)["value"]
            doc_ref = db.collection(u"Users").document(user["uid"])
            doc_ref.update({
                fieldname: new_value,
            })
            return jsonify(True)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: get complete user data by login token
    HEADER: {"id_token": <string>}
    BODY: {}
    RETURN: {komplette Nutzerdaten als dict}
    '''

    @app.route('/get_user', methods=["POST"])
    def get_userdata():
        try:
            id_token = request.headers["id_token"]
            user = auth.verify_id_token(id_token)
            doc_ref = db.collection(u"Users").document(user["uid"])
            user_data = doc_ref.get().to_dict()
            return jsonify(user_data)
        except Exception as e:
            print(e)
            return jsonify(False)

    '''
    TODO: Create DB entry for a new user when registered 
    HEADER: {"id_token": <string>} 
    BODY: {} 
    RETURN: {True/False} 
    '''

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
                elif "prio" in aufgaben:
                    pass



    #app.run() # for development
    #create_user()

    #app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080))) # for production