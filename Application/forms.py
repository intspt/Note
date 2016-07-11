#!/usr/bin/env python2.7



from flask.ext.wtf import Form
from wtforms import TextField, PasswordField, TextAreaField, HiddenField, SelectField



class LoginForm(Form):
    name = TextField()
    password = PasswordField()

class NoteForm(Form):
    nid = HiddenField()
    title = TextField()
    content = TextAreaField()

    def validate_title(self):
        return self.title.data != '' and self.title.data.strip() != ''

    def validate_content(self):
        return self.content.data != '' and self.content.data.strip != ''