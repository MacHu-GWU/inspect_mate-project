#!/usr/bin/env python
# -*- coding: utf-8 -*-


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


if __name__ == "__main__":
    import inspect
    from pprint import pprint

    pprint(inspect.getmembers(instance))
