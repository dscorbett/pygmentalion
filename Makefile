# Copyright 2022 David Corbett
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

OPEN := open
PARCHMENT ?= ../parchment.html

.PHONY: all
all: pygmentalion.t3 pygmentalion-web.t3

.PHONY: cli
cli: pygmentalion.t3

.PHONY: web
web: pygmentalion-web.t3

.PHONY: play-curses
play-curses: pygmentalion.t3
	frob -p -i curses $<

.PHONY: play-lectrote
play-lectrote: pygmentalion.t3
	open -a Lectrote $<

.PHONY: play-parchment
play-parchment: pygmentalion.t3
	"$(OPEN)" "$(PARCHMENT)"

.PHONY: play-plain
play-plain: pygmentalion.t3
	frob -p -k UTF-8 -i plain $<

.PHONY: play-qtads
play-qtads: pygmentalion.t3
	open -a QTads $<

.PHONY: play-spatterlight
play-spatterlight: pygmentalion.t3
	open -a Spatterlight -n $<

.PHONY: play-web
play-web: pygmentalion-web.t3
	frob -i plain -p -N 44 $< | { read -r line; read -r line; "$(OPEN)" "$$(printf %s "$$line" | cut -f 2- -d :)"; }

.PHONY: play-xtads
play-xtads: pygmentalion.t3
	open -a XTads -n --args "$$(pwd)"/$<

%.t3: pygmentalion.t.pygm pygmentalion.t %.t3m obj
	t3make -a -f $* -res GameInfo.txt arrheta.txt $<

logs obj:
	mkdir $@

%.pygm: %
	pygmentize -l tads3 $< -f html -O nobackground,nowrap \
	| ./html2ascii.py \
	| sed 's/<span class="\([^"]*\)">/<\1>/g; s:</span>:<>:g' \
	>$@

.PHONY: clean
clean:
	$(RM) -r pygmentalion.t3 pygmentalion-web.t3 pygmentalion.t.pygm logs obj

.PHONY: check
check: $(addprefix logs/,$(addsuffix .out,$(basename $(notdir $(wildcard tests/*.in))))) check-line-length

.PRECIOUS: logs/%.out
logs/%.out: tests/%.in logs pygmentalion.t3 FORCE
	tail -n 2 $< | tr '\n' ' ' | grep -qx '>q >y '
	frob -S -p -k UTF-8 -i plain -R $< pygmentalion.t3 >$@
	diff tests/$*.out $@

.PHONY: check-line-length
check-line-length:
	! grep -v '^ *\*   [^ ]*$$' pygmentalion.t | grep -q '^.\{80\}'

.PHONY: FORCE
FORCE:
