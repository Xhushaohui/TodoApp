from flask_restful import Resource
from flask import request
from models import db, User, Task


class Tasks(Resource):

    def post(self):
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]
        print(header)
        if not header:
            return{"Message" : "No api Key"}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                task = Task(
                    user_id = user.id,
                    title = json_data['title'],
                    note = json_data['note'],
                    completed = json_data['completed'],
                    repeats = json_data['repeats'],
                    deadline = json_data['deadline'],
                    reminder = json_data['reminder']
                )
                db.session.add(task)
                db.session.commit()

                result = Task.serialize(task)
                return{"message": "success", "Tasks": result}, 201
            else:
                return{"message": "No user with that apiKey"}, 400


    def get(self):
        result = []
        # json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
            return{"Message" : "No api Key"}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                tasks = Task.query.filter_by(user_id = user.id).all()
                for task in tasks:
                    result.append(Task.serialize(task))
        return{"message": "success", "Tasks": result}, 201
