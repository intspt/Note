#!/usr/bin/env python2.7
# -*- coding:utf-8 -*-

from sae import const

SQLALCHEMY_DATABASE_URI = 'mysql://' + const.MYSQL_USER + ':' + \
                            const.MYSQL_PASS + '@' + const.MYSQL_HOST + \
                            ':' + const.MYSQL_PORT  + '/' + const.MYSQL_DB

SQLALCHEMY_POOL_RECYCLE = 10

NID_LEN = 14
TITLE_LEN = 99

INDEX_NOTE_NUM = 5
CATALOG_NOTE_NUM = 22

ERROR = '<h1> Error ! </h1>'

SECRET_KEY = 'dark flame master'

NAME_LEN = 22
PASSWORD_LEN = 22
REMINDER_LEN = 99

EMPTY_ERROR = u'标题或内容不能为空！'
LOGIN_INFO_ERROR = u'用户名或密码错误！'