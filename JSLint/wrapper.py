import sys
import subprocess
import re

# settings -- TODO: read from configuration file
cmd = "rhino"
lint = "/home/fnd/Scripts/JSLint/jslint.js"
pattern = r"Lint at line (\d+) character (\d+): (.*)"

def main(args):
	filename = args[1]
	command = [cmd, lint, filename]
	output = subprocess.Popen(command, stdout=subprocess.PIPE).communicate()[0]
	print "\n".join(reformat(output, pattern, filename))

def reformat(text, pattern, filename):
	results = []
	regex = re.compile(pattern)
	for line in text.split("\n"):
		matches = regex.search(line)
		if matches:
			line = int(matches.groups()[0])
			char = int(matches.groups()[1])
			msg = matches.groups()[2]
			results.append("%s:%d:%d:%s" % (filename, line, char, msg))
	return results

if __name__ == "__main__":
	sys.exit(main(sys.argv))
