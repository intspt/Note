#!/usr/bin/env python2.7



from datetime import datetime
from functools import wraps
from flask import request, render_template, redirect, url_for, g, flash
from flask.ext.login import login_user, logout_user, current_user, login_required
from sqlalchemy import desc
from Application import app, db, login_manager
from models import Note, User, Reminder
from forms import LoginForm, NoteForm
from config import EMPTY_ERROR, LOGIN_INFO_ERROR, INDEX_NOTE_NUM, CATALOG_NOTE_NUM



@login_manager.user_loader
def load_user(uid):
    return User.query.get(int(uid))



@app.before_request
def before_request():
    g.user = current_user



def throw_exception(f):
    @wraps(f)
    def call(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except Exception, e:
            print e
            return unicode(e)
    return call



@app.route('/')
@throw_exception
def home():
    pn = request.args.get('pn')
    if not pn:
        pn = 1
    else:
        pn = int(pn)

    if g.user.is_authenticated:
        note_list = Note.query.order_by(desc(Note.time_)).paginate(pn, INDEX_NOTE_NUM)
    else:
        note_list = Note.query.filter_by(is_visible=True).order_by(desc(Note.time_)).paginate(pn, INDEX_NOTE_NUM)

    return render_template('index.html', pn=pn, note_list=note_list)



@app.route('/about')
@throw_exception
def about():
    return render_template('about.html')



@app.route('/postNote', methods=['GET', 'POST'])
@login_required
@throw_exception
def post_note():
    if request.method == 'GET':
        return render_template('postNote.html', form=NoteForm())
    else:
        form = NoteForm(request.form)
        if not form.validate_title() or not form.validate_content():
            raise Exception(EMPTY_ERROR)

        time_ = datetime.now()
        nid = time_.strftime('%Y%m%d%H%M%S')
        note = Note(nid, form.title.data, form.content.data, time_)
        db.session.add(note)
        db.session.commit()
        db.session.close()
        return redirect(url_for('note', nid=nid))



@app.route('/note')
@throw_exception
def note():
    nid = request.args.get('nid')
    note = Note.query.get(nid)
    if not note.is_visible and not g.user.is_authenticated:
        return redirect('/login')
    else:
        return render_template('note.html', note=note)



@app.route('/editNote', methods=['GET', 'POST'])
@login_required
@throw_exception
def edit_note():
    if request.method == 'GET':
        nid = request.args.get('nid')
        note = Note.query.get(nid)
        form = NoteForm(nid=note.nid, title=note.title,content=note.content)

        return render_template('editNote.html', form=form)
    else:
        form = NoteForm(request.form)
        if not form.validate_title() or not form.validate_content():
            raise Exception(EMPTY_ERROR)

        Note.query.filter_by(nid=form.nid.data).update({'title': form.title.data, \
                                                      'content': form.content.data, \
                                                        'time_': datetime.now()})

        db.session.commit()
        db.session.close()
        return redirect(url_for('note', nid=form.nid.data))



@app.route('/displayNote')
@login_required
@throw_exception
def display_note():
    nid = request.args.get('nid')
    Note.query.filter_by(nid=nid).update({'is_visible': True})
    db.session.commit()
    db.session.close()
    return redirect('/')



@app.route('/hideNote')
@login_required
@throw_exception
def hide_note():
    nid = request.args.get('nid')
    Note.query.filter_by(nid=nid).update({'is_visible': False})
    db.session.commit()
    db.session.close()
    return redirect('/')



@app.route('/deleteNote')
@login_required
@throw_exception
def delete_note():
    nid = request.args.get('nid')
    note = Note.query.get(nid)
    db.session.delete(note)
    db.session.commit()
    db.session.close()
    return redirect('/')



@app.route('/reminder', methods=['GET', 'POST'])
@login_required
@throw_exception
def reminder():
    if request.method == 'GET':
        reminder_list = Reminder.query.filter_by(is_visible=True).all()
        print reminder_list, dir(reminder_list)
        return render_template('reminder.html', reminder_list=reminder_list)
    else:
        reminder = Reminder(datetime.now(), request.form['content'], datetime.now())
        db.session.add(reminder)
        db.session.commit()
        db.session.close()
        return redirect('/reminder')



@app.route('/login', methods=['GET', 'POST'])
@throw_exception
def login():
    if request.method == 'GET':
        return render_template('login.html', form=LoginForm())
    else:
        form = LoginForm(request.form)
        print form.name.data, form.password.data
        user = User.query.filter_by(name=form.name.data).first()
        if user is None or user.password != form.password.data:
            error = LOGIN_INFO_ERROR
        else:
            error = None

        if error:
            flash(error)
            return render_template('login.html', form=form)
        else:
            login_user(user, remember=True)
            return redirect('/')



@app.route('/logout')
@login_required
@throw_exception
def logout():
    logout_user()
    return redirect('/')



@app.route('/removeSpaceInString')
@login_required
@throw_exception
def remove_space_in_string():
    if request.args.has_key('raw_string'):
        raw_string = request.args['raw_string']
        result_string = ''.join(raw_string.split())
    else:
        result_string = ''

    return render_template('removeSpaceInString.html', result_string=result_string)
