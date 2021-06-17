#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""Template for python3 terminal scripts.
This gist allows you to quickly create a functioning
python3 terminal script using argparse and subprocess.
"""

import argparse
import os
import sys
import subprocess

from typing import List

__author__ = "Noureldin Hendy"
__copyright__ = "Copyright 2020, Noureldin Hendy"
__credits__ = ["Author Name"]
__license__ = "MIT"
__version__ = "0.0.1"
__maintainer__ = "Noureldin Hendy"
__email__ = "nhendy997@gmail.com"
__status__ = "Development"

def parse_args(argv: List[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description='Script description')
    # Positional Arguments
    parser.add_argument('argument_name',
                        help="argument description",
                        nargs='?',
                        const=0)

    # Optional Arguments
    parser.add_argument("-f", "--foo",
                        help="specify foo",
                        action='store_true')
    parser.add_argument("-b", "--bar",
                        help="specify bar",
                        metavar='BAR',
                        nargs=1)

    return parser.parse_args(argv)


def main(argv: List[str] = sys.argv[1:]) -> None:
    args = parse_args(argv)

if __name__ == '__main__':
    main()
