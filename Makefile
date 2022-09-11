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

.PHONY: all
all: pygmentalion.t3 pygmentalion-web.t3

.PHONY: cli
cli: pygmentalion.t3

.PHONY: web
web: pygmentalion-web.t3

.PHONY: play-curses
play-curses: pygmentalion.t3
	frob -p -i curses $<

.PHONY: play-plain
play-plain: pygmentalion.t3
	frob -p -k UTF-8 -i plain $<

.PHONY: play-qtads
play-qtads: pygmentalion.t3
	open -a QTads $<

.PHONY: play-web
play-web: pygmentalion-web.t3
	frob -i plain -p -N 44 $< | { read -r line; read -r line; "$(OPEN)" "$$(printf %s "$$line" | cut -f 2- -d :)"; }

.PHONY: play-xtads
play-xtads: pygmentalion.t3
	open -a XTads -n --args "$$(pwd)"/$<

%.t3: pygmentalion.t.pygm pygmentalion.t %.t3m obj
	t3make -a -f $* -res GameInfo.txt englishWords.txt $<

obj:
	mkdir $@

%.pygm: %
	pygmentize -l tads3 $< -f html -O nobackground,nowrap \
	| ./html2ascii.py \
	| sed 's/<span class="\([^"]*\)">/<\1>/g; s:</span>:<>:g' \
	>$@

.PHONY: clean
clean:
	$(RM) -r pygmentalion.t3 pygmentalion-web.t3 pygmentalion.t.pygm obj
