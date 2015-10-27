# -*- coding: utf-8 -*-

"""
Created on 2015-10-26
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

pytest_plugins = "kotti"

from pytest import fixture


@fixture(scope='session')
def custom_settings():
    import kotti_dashboard.resources
    kotti_dashboard.resources  # make pyflakes happy
    return {
        'kotti.configurators': 'kotti_tinymce.kotti_configure '
                               'kotti_dashboard.kotti_configure'}
