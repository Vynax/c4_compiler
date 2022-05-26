CC=gcc
LEX=flex
TEST_FILE=test/add

.PHONY: test clean

prog2:	lex.yy.c
	$(CC) -o $@ $<

lex.yy.c:	src/prog2.l
	$(LEX) $<

test:	prog2
	./$< $(TEST_FILE)

clean:
	$(RM) lex.yy.c prog2
