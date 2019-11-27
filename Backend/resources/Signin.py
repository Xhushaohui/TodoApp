from flask_restful import Resource
from flask import request
from models import db, User


class Signin(Resource):

    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
            result = self.username_and_password_signin(json_data)
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                result = User.serialize(user)
            else:
                result = self.username_and_password_signin(json_data)
        return{"message": "success", "Signin": result}, 201

    def username_and_password_signin(self, json_data):
        if not json_data:
            return {'message': 'No input data provided'}, 400
        user = User.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message': 'User not exist'}, 400
        if user.password != json_data['password']:
            return {'message': 'Pass word incorrect!'}, 400
        return User.serialize(user)
