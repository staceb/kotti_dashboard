kotti_dashboard
***************

This is an extension to Kotti that adds a dashboard view.

This project depends on https://github.com/umeboshi2/kotti_jsonapi and https://github.com/umeboshi2/kotti_compass


|build status|_

`Find out more about Kotti`_

Development happens at https://github.com/umeboshi2/kotti_dashboard

.. |build status| image:: https://secure.travis-ci.org/umeboshi2/kotti_dashboard.png?branch=master
.. _build status: http://travis-ci.org/umeboshi2/kotti_dashboard
.. _Find out more about Kotti: http://pypi.python.org/pypi/Kotti

Setup
=====

To enable the extension in your Kotti site, activate the configurator::

    kotti.configurators =
        kotti_dashboard.kotti_configure

Database upgrade
================

If you are upgrading from a previous version you might have to migrate your
database.  The migration is performed with `alembic`_ and Kotti's console script
``kotti-migrate``. To migrate, run
``kotti-migrate upgrade --scripts=kotti_dashboard:alembic``.

For integration of alembic in your environment please refer to the
`alembic documentation`_. If you have problems with the upgrade,
please create a new issue in the `tracker`_.

Development
===========

Contributions to kotti_dashboard are highly welcome.
Just clone its `Github repository`_ and submit your contributions as pull requests.


Dashboard Components
====================

- marionette

- applets

- messages collection view

- clipboard collection


TODO
====

General
-------

#. Look at possibly using Marionette.Toolkit for applets.

#. Better setup of webpack config.

#. Use Babel for ES6 support and get rid of string functions in apputil

#. Create general viewer app.
   
#. Make a kotti resource for markdown documents

Dashboard
---------

#. Make a good hallo toolbar

   - make new plugins

   - images plugin

   - site images top node

#. Make upload widget

   - use bootstrap fileinput instead of angular

#. Change workflow states.

   - make a rest view to change workflow based on get view in kotti

#. Implement share content

#. Implement add node for any type (need rest view to make object)
   
   
 




.. _alembic: http://pypi.python.org/pypi/alembic
.. _alembic documentation: http://alembic.readthedocs.org/en/latest/index.html
.. _tracker: https://github.com/umeboshi2/kotti_dashboard/issues
.. _Github repository: https://github.com/umeboshi2/kotti_dashboard
