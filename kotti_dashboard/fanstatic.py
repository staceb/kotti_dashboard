# -*- coding: utf-8 -*-

"""
Created on 2015-10-26
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from __future__ import absolute_import

import os
import json

from fanstatic import Group
from fanstatic import Library
from fanstatic import Resource

package_dirname = os.path.dirname(__file__)
manifest_filename = os.path.join(package_dirname, 'static', 'manifest.json')

manifest = json.load(file(manifest_filename))

library = Library("kotti_dashboard", "static")

vendor = Resource(
    library,
    manifest['vendor.js'],)

dashboard = Resource(
    library,
    manifest['app.js'],
    depends=[vendor])

#css_and_js = Group([css, js])

