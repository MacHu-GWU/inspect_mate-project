#!/usr/bin/env python
# -*- coding: utf-8 -*-

__version__ = "0.0.1"
__short_description__ = "Extend the ``inspect`` standard library."
__license__ = "MIT"
__author__ = "Sanhe Hu"

try:
    from .getter import *
    from .tester import *
except:
    pass
