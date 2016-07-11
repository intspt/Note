#!/usr/bin/env python2.7
# -*- coding:utf-8 -*-



import os



PWD = os.getcwd()


SQLALCHEMY_DATABASE_URI        = 'sqlite:////%s/Application/database/database.db' % PWD
SQLALCHEMY_TRACK_MODIFICATIONS = False

NID_LEN   = 14
TITLE_LEN = 99

INDEX_NOTE_NUM   = 5
CATALOG_NOTE_NUM = 22

SECRET_KEY = 'dark flame master'

NAME_LEN     = 22
PASSWORD_LEN = 22
REMINDER_LEN = 99

EMPTY_ERROR      = u'标题或内容不能为空！'
LOGIN_INFO_ERROR = u'用户名或密码错误！'