.. image:: https://travis-ci.org/MacHu-GWU/inspect_mate-project.svg?branch=master

.. image:: https://img.shields.io/pypi/v/inspect_mate.svg

.. image:: https://img.shields.io/pypi/l/inspect_mate.svg

.. image:: https://img.shields.io/pypi/pyversions/inspect_mate.svg


Welcome to inspect_mate Documentation
=====================================
inspect_mate can easily separate:

1. ``regular attribute``.
2. ``property attribute``.
3. ``regular method``.
4. ``static method``.
5. ``class method``.
6. **all attributes,** include ``regular attribute`` and ``property attribute``.
7. **all methods**, include regular method, ``static method`` and ``class method``.


**Quick Links**
---------------
- `GitHub Homepage <https://github.com/MacHu-GWU/inspect_mate-project>`_
- `Online Documentation <https://pypi.python.org/pypi/inspect_mate>`_
- `PyPI download <https://pypi.python.org/pypi/inspect_mate>`_
- `Install <install_>`_
- `Issue submit and feature request <https://github.com/MacHu-GWU/inspect_mate-project/issues>`_
- `API reference and source code <http://pythonhosted.org/inspect_mate/py-modindex.html>`_


**Example**
-----------
import:

.. code-block:: python

    from inspect_mate import (
        is_attribute,
        is_property_method,
        is_regular_method,
        is_static_method,
        is_class_method,
        get_attributes,
        get_property_methods,
        get_regular_methods,
        get_static_methods,
        get_class_methods,
        get_all_attributes,
        get_all_methods,
    )

define a class:

.. code-block:: python

    class Base(object):
        attribute = "attribute"

        def __init__(self):
            self.initiated_attribute = "initiated_attribute"

        @property
        def property_method(self):
            return "property_method"

        def regular_method(self):
            return "regular_method"

        @staticmethod
        def static_method():
            return "static_method"

        @classmethod
        def class_method(cls):
            return "class_method"


    class Klass(Base):
        pass


    instance = Klass()

usage:

.. code-block:: python

    # tester_function(klass_or_instance, "attribute_name")
    >>> is_attribute(Klass, "attribute")
    True
    >>> is_property_method(Klass, "property_attribute")
    True
    >>> is_regular_method(Klass, "regular_method")
    True
    >>> is_static_method(Klass, "static_method")
    True
    >>> is_class_method(Klass, "class_method")
    True

    >>> is_attribute(instance, "attribute")
    True
    >>> is_attribute(instance, "initiated_attribute")
    True
    >>> is_property_method(instance, "property_attribute")
    True
    >>> is_regular_method(instance, "regular_method")
    True
    >>> is_static_method(instance, "static_method")
    True
    >>> is_class_method(instance, "class_method")
    True

    # getter_function(klass_or_instance), yield (attr, value)
    >>> get_attributes(Klass)
    [("attribute", "attribute")]

    >>> get_property_methods(Klass)
    [("property_attribute", "property_attribute")]

    >>> get_regular_methods(Klass)
    [("regular_method", Klass.regular_method)]

    >>> get_static_methods(Klass)
    [("static_method", "Klass.static_method")]

    >>> get_class_methods(Klass)
    [("class_method", "Klass.class_method")]

    >>> get_all_attributes(Klass)
    [("attribute", "attribute"), ("property_attribute", "property_attribute")]

    >>> get_all_methods(Klass)
    [("regular_method", Klass.regular_method), ("static_method", "Klass.static_method"), ("class_method", "Klass.class_method")]


.. _install:

Install
-------

``inspect_mate`` is released on PyPI, so all you need is:

.. code-block:: console

	$ pip install inspect_mate

To upgrade to latest version:

.. code-block:: console

	$ pip install --upgrade inspect_mate