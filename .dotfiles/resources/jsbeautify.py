#!/usr/bin/env python

import sys
import jsbeautifier

def main():
    out_js = jsbeautifier.beautify(sys.stdin.read())
    print(out_js)


if __name__ == '__main__':
    main()
