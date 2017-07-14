#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
get all either ``regular attribute``, ``property method``, ``regular method``, 
``static method`` or ``class method``.
"""

import inspect
import functools
try:
    from .tester import *
except:
    from inspect_mate.tester import *

__all__ = [
    "get_attributes",
    "get_property_methods",
    "get_regular_methods",
    "get_static_methods",
    "get_class_methods",
    "get_all_attributes",
    "get_all_methods",
]


def _get_members(klass, tester_func, return_builtin=False):
    """

    :param klass: a class.
    :param tester_func: is_xxx function.
    :param return_builtin: bool, if False, built-in variable or method such as 
      ``__name__``, ``__init__`` will not be returned.
    """
    pairs = list()
    for attr, value in inspect.getmembers(klass):
        try:
            if tester_func(klass, attr):
                if return_builtin:
                    pairs.append((attr, value))
                else:
                    if not (attr.startswith("__") or attr.endswith("__")):
                        pairs.append((attr, value))
        except:
            pass

    return pairs


get_attributes = functools.partial(
    _get_members, tester_func=is_attribute, return_builtin=False)
get_attributes.__doc__ = "Get all class attributes members."

get_property_methods = functools.partial(
    _get_members, tester_func=is_property_method, return_builtin=False)
get_property_methods.__doc__ = "Get all property style attributes members."

get_regular_methods = functools.partial(
    _get_members, tester_func=is_regular_method, return_builtin=False)
get_regular_methods.__doc__ = "Get all non static and class method members"

get_static_methods = functools.partial(
    _get_members, tester_func=is_static_method, return_builtin=False)
get_static_methods.__doc__ = "Get all static method attributes members."

get_class_methods = functools.partial(
    _get_members, tester_func=is_class_method, return_builtin=False)
get_class_methods.__doc__ = "Get all class method attributes members."


def get_all_attributes(klass_or_instance):
    """Get all attribute members (attribute, property style method).
    """
    pairs = list()
    for attr, value in inspect.getmembers(
            klass_or_instance, lambda x: not inspect.isroutine(x)):
        if not (attr.startswith("__") or attr.endswith("__")):
            pairs.append((attr, value))
    return pairs


def get_all_methods(klass_or_instance):
    """Get all method members (regular, static, class method).
    """
    pairs = list()
    for attr, value in inspect.getmembers(
            klass_or_instance, lambda x: inspect.isroutine(x)):
        if not (attr.startswith("__") or attr.endswith("__")):
            pairs.append((attr, value))
    return pairs


if __name__ == "__main__":
    from inspect_mate.tests import Klass, instance
