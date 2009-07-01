#!/usr/bin/env python

"""
wrapper for JSLint
requires Spidermonkey

Usage:
  $ wrapper_spidermonkey.py <filepath>

TODO:
* reformat output (<filepath>:<line>:<column>:<message>)
* read settings from config file or command-line arguments
"""

import sys

import spidermonkey


lint_path = "/home/fnd/Scripts/JSLint/fulljslint.js"


def main(args=None):
	filepath = args[1]
	status, report = lint(filepath)
	print report
	return status


def lint(filepath):
	rt = spidermonkey.Runtime()
	ctx = rt.new_context()

	options = {} # TODO: read from argument
	ctx.add_global("options", options)
	ctx.add_global("getFileContents", get_file_contents)

	# load JavaScript code
	ctx.execute('eval(getFileContents("%s"));' % lint_path)
	ctx.execute('var code = getFileContents("%s");' % filepath)
	# lint code
	status = ctx.execute("JSLINT(code, options);") # True if clean, False otherwise
	errors = ctx.execute("JSLINT.errors;"); # TODO: return as JSON

	return status, errors


def get_file_contents(filepath):
	return open(filepath).read()


if __name__ == "__main__":
	status = not main(sys.argv)
	sys.exit(status)
