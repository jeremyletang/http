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
	@ocamlbuild -use-ocamlfind http.cma

test:
	@ocamlbuild -use-ocamlfind parser_test.native
	@ocamlbuild -use-ocamlfind header_test.native
	@ocamlbuild -use-ocamlfind method_test.native
	@ocamlbuild -use-ocamlfind status_test.native
	@ocamlbuild -use-ocamlfind version_test.native
.PHONY: test

clean:
	@ocamlbuild -clean

run: test
	@echo "Running tests for Http.Parser"
	@./parser_test.native
	@echo "Running tests for Http.Header"
	@./header_test.native
	@echo "Running tests for Http.Method"
	@./method_test.native
	@echo "Running tests for Http.Status"
	@./status_test.native
	@echo "Running tests for Http.Version"
	@./version_test.native
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