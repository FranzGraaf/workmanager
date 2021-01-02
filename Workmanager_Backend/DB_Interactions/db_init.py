import firebase_admin
from firebase_admin import credentials, firestore, storage





class DB_Init:
    def __init__(self):
        super().__init__()
        self.init_firestore_app()
        self.db = firestore.client()

    def init_firestore_app(self):
        cred = credentials.Certificate("workmanager-org-dev-5460a8d1680e.json")
        self.default_app = firebase_admin.initialize_app(cred, {
        'storageBucket': u'workmanager-org-dev.appspot.com' 
        })
        self.default_bucket = storage.bucket()

    def get_bucket(self):
        return self.default_bucket