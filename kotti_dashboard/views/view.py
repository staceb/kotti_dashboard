# -*- coding: utf-8 -*-

"""
Created on 2015-10-26
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from pyramid.view import view_config
from pyramid.view import view_defaults

from kotti_dashboard import _
from kotti_dashboard.fanstatic import css_and_js
from kotti_dashboard.views import BaseView

from kotti_compass.fanstatic import mystyles, font_awesome

@view_defaults(permission="view")
class DashboardView(BaseView):
    @view_config(name='dashboard', permission='view',
                 renderer='kotti_dashboard:templates/mainview.mako')
    def default_view(self):
        font_awesome.need()
        mystyles['bootstrap-custom']['BlanchedAlmond'].need()
        return dict()
    

