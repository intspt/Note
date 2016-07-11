#!/usr/bin/env python2.7



from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import LoginManager



FLASKS_ETTINGS = 'config.py'

app = Flask(__name__)
app.config.from_pyfile(FLASKS_ETTINGS, silent=True)
db = SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = '/login'