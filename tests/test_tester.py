#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
elementary_path unittest.
"""

import pytest
from inspect_mate.tests import Klass, instance
from inspect_mate.tester import (
    is_attribute,
    is_property_method,
    is_regular_method,
    is_static_method,
    is_class_method,
)


tester_func_list = (
    is_attribute,
    is_property_method,
    is_regular_method,
    is_static_method,
    is_class_method,
)

klass_attr_value_list = (
    (Klass, "attribute"),
    (Klass, "property_method"),
    (Klass, "regular_method"),
    (Klass, "static_method"),
    (Klass, "class_method"),
)

instance_attr_value_list = (
    (instance, "attribute"),
    (instance, "property_method"),
    (instance, "regular_method"),
    (instance, "static_method"),
    (instance, "class_method"),
)


def assert_tester_func_correct(arg_list, tester_list):
    for i, arg in enumerate(arg_list):
        for j, tester_func in enumerate(tester_list):
            if i == j:
                assert tester_func(*arg) is True
            else:
                assert tester_func(*arg) is False


def test():
    assert_tester_func_correct(klass_attr_value_list, tester_func_list)
    assert_tester_func_correct(instance_attr_value_list, tester_func_list)

    assert is_attribute(instance, "initiated_attribute") is True
    assert is_property_method(instance, "initiated_attribute") is False


if __name__ == "__main__":
    import os

    basename = os.path.basename(__file__)
    pytest.main([basename, "-s", "--tb=native"])
