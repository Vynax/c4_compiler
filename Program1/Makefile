CC=gcc
LEX=flex
TEST_FILE=hello.c

prog1:	lex.yy.c
	$(CC) -o $@ $<

lex.yy.c:	prog1.l
	$(LEX) $<

test:	prog1
	./$< $(TEST_FILE)
