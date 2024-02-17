#!/usr/bin/env bash

gcc -c fibonacci.c
gcc -o test fibonacci-test.c fibonacci.o -lunittester
./test
