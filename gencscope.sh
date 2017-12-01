#!/bin/sh

find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.java" > cscope.files
cscope -bkq -i cscope.files
ctags --languages=Asm,c,c++,java -R
