#!/usr/bin/python

"""
Convert JSON data to human-readable form.

reads from stdin and writes to stdout
"""

import sys
import simplejson as json


def main(args):
	data = json.load(sys.stdin)
	print json.dumps(data, sort_keys=False, indent=4)
	return True


if __name__ == "__main__":
	sys.exit(not main(sys.argv))
