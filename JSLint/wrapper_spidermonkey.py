#!/usr/bin/env python

"""
wrapper for JSLint
requires Spidermonkey

Usage:
  $ wrapper_spidermonkey.py <filename>

TODO:
* reformat output (<filename>:<line>:<column>:<message>)
* support JSLINT options
* read settings from config file or command-line arguments
"""

import sys

import spidermonkey


# settings
lint_path = "/home/fnd/Scripts/JSLint/fulljslint.js"


def main(args=None):
	filepath = args[1]
	status, report = lint(filepath)
	print report
	return status


def lint(filepath):
	options = "{}" # TODO: read from argument and automate stringification

	rt = spidermonkey.Runtime()
	ctx = rt.new_context()

	jslint = open(lint_path).read()
	code = open(filepath).read()

	code = _escape(code) # required due code being passed as literal string -- TODO: read file contents from within Spidermonkey
	status = ctx.execute(r'%s JSLINT("%s", %s);' % (jslint, code, options)) # True if clean, False otherwise
	report = ctx.execute("JSLINT.report();");

	return status, report


def _escape(code):
	"""
	escape line breaks and nested double quotes
	"""
	marker = "{%escaped_quote%}"; # XXX: not 100% safe
	return (code.replace("\n", r"\n").
		replace(r'\"', marker).replace('"', r'\"').replace(marker, r'\"'))


if __name__ == "__main__":
	status = not main(sys.argv)
	sys.exit(status)
