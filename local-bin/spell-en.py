#!/usr/bin/env python3
import sys

nato_alphabet = {
    'a': '/eɪ/, /æ/ 	a',
    'b': '/biː/ 	bee',
    'c': '/siː/ 	cee',
    'd': '/diː/ 	dee',
    'e': '/iː/ 	e',
    'f': '/ɛf/ 	ef',
    'g': '/dʒiː/ 	gee',
    'h': '/(h)eɪtʃ/ 	(h)aitch',
    'i': '/aɪ/ 	i',
    'j': '/dʒeɪ/ 	jay',
    'k': '/keɪ/ 	kay',
    'l': '/ɛl/ 	el',
    'm': '/ɛm/ 	em',
    'n': '/ɛn/ 	en',
    'o': '/oʊ/ 	o',
    'p': '/piː/ 	pee',
    'q': '/kjuː/ 	cue',
    'r': '/ɑːr/ 	ar',
    's': '/ɛs/ 	ess',
    't': '/tiː/ 	tee',
    'u': '/juː/ 	u',
    'v': '/viː/ 	vee',
    'w': '/ˈdʌbəl.juː/ 	double-u',
    'x': '/ɛks/ 	ex',
    'y': '/waɪ/ 	wy',
    'z': '/zi/zɛd/ 	zee/zed'
}

try:
    sys.argv[1]
except:
    print("Usage: spell-en <word> or \"<sentence>\"")
    exit(1)

for letter in sys.argv[1]:
    lowerletter = letter.lower()
    print(f'{letter}: {nato_alphabet.get(lowerletter, lowerletter)}')
