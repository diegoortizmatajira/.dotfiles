#!/usr/bin/env python3
import sys

nato_alphabet = {
    'a': 'ei',
    'b': 'bi',
    'c': 'ci',
    'd': 'di',
    'e': 'i',
    'f': 'ef',
    'g': 'yi',
    'h': 'eich',
    'i': 'ai',
    'j': 'jei',
    'k': 'kei',
    'l': 'el',
    'm': 'em',
    'n': 'en',
    'o': 'ou',
    'p': 'pi',
    'q': 'kiu',
    'r': 'ar',
    's': 'es',
    't': 'ti',
    'u': 'iu',
    'v': 'uvi',
    'w': 'dabliu',
    'x': 'ex',
    'y': 'uay',
    'z': 'set'
}

try:
    sys.argv[1]
except:
    print("Usage: english-spell <word> or \"<sentence>\"")
    exit(1)

for letter in sys.argv[1]:
    lowerletter = letter.lower()
    print(f'{letter}: {nato_alphabet.get(lowerletter, lowerletter)}')
