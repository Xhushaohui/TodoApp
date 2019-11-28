from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    username = db.Column(db.String(), unique=True)
    firstname = db.Column(db.String())
    lastname = db.Column(db.String())
    password = db.Column(db.String())
    email = db.Column(db.String())
    api_key = db.Column(db.String())

    def __init__(self, api_key, username, firstname, lastname, email, password):
        self.api_key = api_key
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'api_key' : self.api_key,
            'id': self.id,
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'password': self.password,
            'email': self.email,

        }

class Task(db.Model):
    __tablename__ = 'tasks'

    id = db.Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    title = db.Column(db.String())
    note = db.Column(db.String())
    completed = db.Column(db.Boolean(), default=False, nullable=False)
    repeats = db.Column(db.String())
    deadline = db.Column(db.String())
    reminder = db.Column(db.String())

    def __init__(self, user_id, title, note, completed, repeats, deadline, reminder):
        self.user_id = user_id
        self.title = title
        self.note = note
        self.completed = completed
        self.repeats = repeats
        self.deadline = deadline
        self.reminder = reminder

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return {
            'task_id' : self.id,
            'user_id' : self.user_id,
            'title': self.title,
            'note': self.note,
            'completed': self.completed,
            'repeats': self.repeats,
            'deadline': self.deadline,
            'reminder': self.reminder
        }
