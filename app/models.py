#!/usr/bin/env python2.7

from app import db
from config import NID_LEN, TITLE_LEN, NAME_LEN, PASSWORD_LEN, REMINDER_LEN

class User(db.Model):
    __tablename__ = 'user'
    uid = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(NAME_LEN))
    password = db.Column(db.String(PASSWORD_LEN))

    def __init__(self, name, password):
        self.name = name
        self.password = password

    def is_authenticated(self):
        return True

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def get_id(self):
        return unicode(self.uid)

class Note(db.Model):
    __tablename__ = 'notes'
    nid = db.Column(db.String(NID_LEN), primary_key=True)
    title = db.Column(db.String(TITLE_LEN))
    content = db.Column(db.Text)
    time_ = db.Column(db.DateTime)
    is_visible = db.Column(db.Boolean)

    def __init__(self, nid, title, content, time_, is_visible=True):
        self.nid = nid
        self.title = title
        self.content = content
        self.time_ = time_
        self.is_visible = is_visible

class Reminder(db.Model):
    __tablename__ = 'reminder'
    rid = db.Column(db.Integer, primary_key=True)
    time_ = db.Column(db.DateTime)
    content = db.Column(db.String(REMINDER_LEN))
    deadline = db.Column(db.Date)
    is_visible = db.Column(db.Boolean)

    def __init__(self, time_, content, deadline, is_visible=True):
        self.time_ = time_
        self.content = content
        self.deadline = deadline
        self.is_visible = is_visible