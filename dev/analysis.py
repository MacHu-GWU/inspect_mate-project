#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import inspect
import pandas as pd
from pathlib_mate import Path


class Base(object):
    attribute = "attribute"

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


class MyClass(Base):
    pass


def export_true_table():
    """Export value, checker function output true table.
    Help to organize thought.
    
    klass.__dict__ 指的是在类定义中定义的, 从父类继承而来的不在此中。
    """
    tester_list = [
        ("inspect.isroutine", lambda v: inspect.isroutine(v)),
        ("inspect.isfunction", lambda v: inspect.isfunction(v)),
        ("inspect.ismethod", lambda v: inspect.ismethod(v)),
        ("isinstance.property", lambda v: isinstance(v, property)),
        ("isinstance.staticmethod", lambda v: isinstance(v, staticmethod)),
        ("isinstance.classmethod", lambda v: isinstance(v, classmethod)),
    ]

    class_attr_value_paris = [
        ("attribute", MyClass.attribute),
        ("property_method", MyClass.property_method),
        ("regular_method", MyClass.regular_method),
        ("static_method", MyClass.static_method),
        ("class_method", MyClass.class_method),
        ("__dict__['static_method']", Base.__dict__["static_method"]),
        ("__dict__['class_method']", Base.__dict__["class_method"]),
    ]

    myclass = MyClass()
    instance_attr_value_paris = [
        ("attribute", myclass.attribute),
        ("property_method", myclass.property_method),
        ("regular_method", myclass.regular_method),
        ("static_method", myclass.static_method),
        ("class_method", MyClass.class_method),
        #         ("__dict__['static_method']", myclass.__dict__["static_method"]),
        #         ("__dict__['class_method']", myclass.__dict__["class_method"]),
    ]

    print(inspect.getargspec(MyClass.regular_method))
    print(inspect.getargspec(MyClass.static_method))
    print(inspect.getargspec(MyClass.class_method))

    print(inspect.getargspec(myclass.regular_method))
    print(inspect.getargspec(myclass.static_method))
    print(inspect.getargspec(myclass.class_method))

    # index是方法名, column是属性名
    def create_true_table_dataframe(index_tester, column_attr):
        df = pd.DataFrame()
        for attr, value in column_attr:
            col = list()
            for name, tester in index_tester:
                try:
                    if tester(value):
                        flag = 1
                    else:
                        flag = 0
                except:
                    flag = -99
                col.append(flag)
            df[attr] = col
        df.index = [name for name, _ in index_tester]
        return df

    version = "%s.%s" % (sys.version_info.major, sys.version_info.minor)

    df = create_true_table_dataframe(tester_list, class_attr_value_paris)
    df.to_csv("%s_class.csv" % version, index=True)

    df = create_true_table_dataframe(tester_list, instance_attr_value_paris)
    df.to_csv("%s_instance.csv" % version, index=True)


export_true_table()


def merge_true_table():
    """Merge all true table into single excel file.
    """
    writer = pd.ExcelWriter("True Table.xlsx")
    for p in Path(__file__).parent.select_by_ext(".csv"):
        df = pd.read_csv(p.abspath, index_col=0)
        df.to_excel(writer, p.fname, index=True)
    writer.save()

# merge_true_table()
