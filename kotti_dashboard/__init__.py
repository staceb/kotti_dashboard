# -*- coding: utf-8 -*-

"""
Created on 2015-10-26
:author: Joseph Rawson (joseph.rawson.works@gmail.com)
"""

from kotti.resources import File
from pyramid.i18n import TranslationStringFactory

_ = TranslationStringFactory('kotti_dashboard')


def kotti_configure(settings):
    """ Add a line like this to you .ini file::

            kotti.configurators =
                kotti_dashboard.kotti_configure

        to enable the ``kotti_dashboard`` add-on.

    :param settings: Kotti configuration dictionary.
    :type settings: dict
    """

    settings['pyramid.includes'] += ' kotti_dashboard'
    settings['kotti.alembic_dirs'] += ' kotti_dashboard:alembic'
    settings['kotti.available_types'] += ' kotti_dashboard.resources.CustomContent'
    settings['kotti.fanstatic.view_needed'] += ' kotti_dashboard.fanstatic.css_and_js'
    File.type_info.addable_to.append('CustomContent')


def includeme(config):
    """ Don't add this to your ``pyramid_includes``, but add the
    ``kotti_configure`` above to your ``kotti.configurators`` instead.

    :param config: Pyramid configurator object.
    :type config: :class:`pyramid.config.Configurator`
    """

    config.add_translation_dirs('kotti_dashboard:locale')
    config.add_static_view('static-kotti_dashboard', 'kotti_dashboard:static')

    config.scan(__name__)
