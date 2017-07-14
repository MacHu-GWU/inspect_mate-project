#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
test it's either ``regular attribute``, ``property method``, ``regular method``, 
``static method`` or ``class method``. 
"""

import inspect


__all__ = [
    "is_attribute",
    "is_property_method",
    "is_regular_method",
    "is_static_method",
    "is_class_method",
]


def is_attribute(klass_or_instance, attr):
    """Test if a value of a class is attribute. (Not a @property style
    attribute)

    example::

        class MyClass(object):
            attribute1 = 1

            class __init__(self):
                self.attribute2 = 1

    :param klass_or_instance: the class
    :param attr: attribute name
    :param value: attribute value
    """
    value = getattr(klass_or_instance, attr)

    # is a function or method
    if inspect.isroutine(value):
        return False
    else:
        if is_property_method(klass_or_instance, attr):
            return False
        else:
            return True


def is_property_method(klass_or_instance, attr):
    """Test if a value of a class is @property style attribute.

    example::

        class MyClass(object):
            @property
            def value(self):
                return 0

    :param klass_or_instance: the class
    :param attr: attribute name
    :param value: attribute value
    """
    # is a class
    if inspect.isclass(klass_or_instance):
        value = getattr(klass_or_instance, attr)

        # not a function or method
        if inspect.isroutine(value):
            return False
        else:
            if isinstance(value, property):
                return True
            else:
                return False

    # is an instance
    else:
        klass = klass_or_instance.__class__
        try:
            return is_property_method(klass, attr)
        # klass doesn't have this property
        except:
            return False


def is_regular_method(klass_or_instance, attr):
    """Test if a value of a class is regular method.

    example::

        class MyClass(object):
            def execute(self, input_data):
                ...

    :param klass_or_instance: the class
    :param attr: attribute name
    :param value: attribute value
    """
    value = getattr(klass_or_instance, attr)

    if inspect.isroutine(value):
        if isinstance(value, property):
            return False

        args = inspect.getargspec(value).args
        try:
            if args[0] == "self":
                return True
        except:
            pass

    return False


def is_static_method(klass_or_instance, attr):
    """Test if a value of a class is static method.

    example::

        class MyClass(object):
            @staticmethod
            def add_two(a, b):
                return a + b

    :param klass_or_instance: the class
    :param attr: attribute name
    :param value: attribute value
    """
    value = getattr(klass_or_instance, attr)

    # is a function or method
    if inspect.isroutine(value):
        if isinstance(value, property):
            return False

        args = inspect.getargspec(value).args
        # Can't be a regular method, must be a static method
        if len(args) == 0:
            return True

        # must be a regular method
        elif args[0] == "self":
            return False

        else:
            return inspect.isfunction(value)

    return False


def is_class_method(klass_or_instance, attr):
    """Test if a value of a class is class method.

    example::

        class MyClass(object):
            @classmethod
            def add_two(cls, a, b):
                return a + b

    :param klass_or_instance: the class
    :param attr: attribute name
    :param value: attribute value
    """
    value = getattr(klass_or_instance, attr)

    # is a function or method
    if inspect.isroutine(value):
        if isinstance(value, property):
            return False

        args = inspect.getargspec(value).args
        # Can't be a regular method, must be a static method
        if len(args) == 0:
            return inspect.ismethod(value)

        # must be a regular method
        elif args[0] == "self":
            return False

        else:
            return inspect.ismethod(value)

    return False


if __name__ == "__main__":
    from inspect_mate.tests import Klass, instance
