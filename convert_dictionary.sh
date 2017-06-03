#!/bin/sh

iconv -f utf-8 -t eucjp ./word.yomi | ./yomi2voca.pl > ./word.dic
