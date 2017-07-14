#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pytest
from inspect_mate.tests import Klass, instance
from inspect_mate.getter import *


def keys(items):
    return set([item[0] for item in items])


def test():
    assert keys(get_attributes(Klass)) == {"attribute"}
    assert keys(get_property_methods(Klass)) == {"property_method"}
    assert keys(get_regular_methods(Klass)) == {"regular_method"}
    assert keys(get_static_methods(Klass)) == {"static_method"}
    assert keys(get_class_methods(Klass)) == {"class_method"}

    assert keys(get_all_attributes(Klass)) == {"attribute", "property_method"}
    assert keys(get_all_methods(Klass)) == {
        "regular_method", "static_method", "class_method"}

    assert keys(get_attributes(instance)) == {
        "attribute", "initiated_attribute"}
    assert keys(get_property_methods(instance)) == {"property_method"}
    assert keys(get_regular_methods(instance)) == {"regular_method"}
    assert keys(get_static_methods(instance)) == {"static_method"}
    assert keys(get_class_methods(instance)) == {"class_method"}

    assert keys(get_all_attributes(instance)) == {
        "attribute", "initiated_attribute", "property_method"}
    assert keys(get_all_methods(instance)) == {
        "regular_method", "static_method", "class_method"}


if __name__ == "__main__":
    import os
    pytest.main([os.path.basename(__file__), "--tb=native", "-s", ])
