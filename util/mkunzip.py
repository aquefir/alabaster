#!/usr/bin/env python3
#

def main(args):
	if len(args) != 4:
		print('Usage: mkunzip.py <name> <file> <outdir>', file=stderr)
		return 1
	f = open('src/unzip.sh', 'rb')
	t = f.read().decode('utf-8')
	f.close()
	t = t.replace('{{1}}', args[1])
	t = t.replace('{{2}}', args[2])
	t = t.replace('{{3}}', args[3])
	from sys import stdout
	stdout.buffer.write(t.encode('utf-8'))
	return 0

if __name__ == '__main__':
	from sys import argv, exit
	exit(main(argv))
