# -*- coding: utf-8 -*-

"""
Created on 2015-10-26
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from __future__ import absolute_import

from fanstatic import Group
from fanstatic import Library
from fanstatic import Resource


library = Library("kotti_dashboard", "static")

vendor = Resource(
    library,
    'vendor.js',)

dashboard = Resource(
    library,
    'dashboard.js',
    depends=[vendor])

#css_and_js = Group([css, js])

