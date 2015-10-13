# The MIT License (MIT)
#
# Copyright (c) 2013 Jeremy Letang (letang.jeremy@gmail.com)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

all: lib test

lib:
	@ocamlbuild -use-ocamlfind httparser.cma

test:
	@ocamlbuild -use-ocamlfind httparser_test.native
.PHONY: test

clean:
	@rm -rf _build
	@rm -rf httparser_test.native

run: test
	@./httparser_test.native
.PHONY: run

deps:
	opam install ounit
	opam install ocamlfind

help:
	@echo "here is a list of available options for this makefile"
	@echo "... all - default option"
	@echo "... lib"
	@echo "... test"
	@echo "... clean"
	@echo "... run"
	@echo "... deps"
	@echo "... help"
.PHONY: help