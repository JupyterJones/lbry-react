#!/usr/bin/env python
import os
import sys
from sys import argv
from sys import argv
targetdir = sys.argv[1]
term = sys.argv[2]
DIRLIST = []
def Findword(targetdir, term):
    for folder, dirs, files in os.walk(targetdir ):
        for file in files:
            if file.endswith('.html'):
                fullpath = os.path.join(folder, file)
                if "docs" not in fullpath:
                    with open(fullpath, 'r') as f:
                        for line in f:
                            if term in line:
                                DIRLIST.append(fullpath)
                                #print(fullpath)
                                break
    data = DIRLIST
    return data
