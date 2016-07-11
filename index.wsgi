#!/usr/bin/env python2.7

import os
import sys

root = os.path.dirname(__file__)

sys.path.insert(0, os.path.join(root, 'site-packages'))

from sae import create_wsgi_app
from app import app, views

application = create_wsgi_app(app)
