#!/usr/bin/env python3
# coding=utf8

import sys

def bytes_to_gb(nbytes):
    assert isinstance(nbytes, int), "Input must be of type int."
    return int(nbytes / 1e+6)

if __name__ == "__main__":
    print(bytes_to_gb(int(sys.stdin.read())))

