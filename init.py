#!/usr/bin/env python2.7



from flask.ext.sqlalchemy import SQLAlchemy
from Application import app, db, models



db.drop_all()
db.create_all()
user = models.User('rikka', 'yuta')
db.session.add(user)
db.session.commit()
db.session.close()