#!/usr/bin/env python
import sys

nato_alphabet = {
    'a': 'alpha',
    'b': 'bravo',
    'c': 'charlie',
    'd': 'delta',
    'e': 'echo',
    'f': 'foxtrot',
    'g': 'golf',
    'h': 'hotel',
    'i': 'india',
    'j': 'juliet',
    'k': 'kilo',
    'l': 'lima',
    'm': 'mike',
    'n': 'november',
    'o': 'oscar',
    'p': 'papa',
    'q': 'quebec',
    'r': 'romeo',
    's': 'sierra',
    't': 'tango',
    'u': 'uniform',
    'v': 'victor',
    'w': 'whiskey',
    'x': 'x-ray',
    'y': 'yankee',
    'z': 'zulu'
}

try:
    sys.argv[1]
except:
    print("Usage: natoalphabet.py <word>")
    exit(1)

for letter in sys.argv[1]:
    lowerletter = letter.lower()
    if lowerletter not in nato_alphabet:
        print(lowerletter)
    else:
        print(nato_alphabet[lowerletter])
