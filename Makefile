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

COVER_ART_DIMENSIONS := 960x960
OPEN := open
PARCHMENT ?= ../parchment.html

.PHONY: all
all: pygmentalion.t3 pygmentalion-web.t3

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

%.t3: .system/CoverArt.png pygmentalion.t.pygm pygmentalion.t %.t3m obj-%
	t3make -a -f $* -res .system/CoverArt.png GameInfo.txt arrheta.txt pygmentalion.t.pygm

.system logs obj-pygmentalion obj-pygmentalion-web:
	mkdir $@

%.pygm: %
	pygmentize -l tads3 $< -f html -O nobackground,nowrap \
	| ./html2ascii.py \
	| sed 's/<span class="\([^"]*\)">/<\1>/g; s:</span>:<>:g' \
	>$@

.system/CoverArt.png.unopt: .system
	convert assets/CoverArt.png \
		-define png:exclude-chunk=date,tIME \
		-background '#ece4cd' -fill '#822329' -font @assets/UnifrakturMaguntia.ttf -pointsize 240 label:Pygmentalion \
		-gravity Center -smush 24 \
		-fill '#346d9b' -font @assets/iosevka-bolditalic.ttf -pointsize 90 label:'/* David Corbett */ ' \
		-gravity East -smush -48 \
		-resize $(COVER_ART_DIMENSIONS) -extent $(COVER_ART_DIMENSIONS) \
		$@

.system/CoverArt.png: .system/CoverArt.png.unopt
	pngcrush $< $@

.PHONY: clean
clean:
	$(RM) -r .system pygmentalion.t3 pygmentalion-web.t3 pygmentalion.t.pygm logs obj-pygmentalion obj-pygmentalion-web

.PHONY: check
check: $(addprefix logs/,$(addsuffix .out,$(basename $(notdir $(wildcard tests/*.in))))) check-cover-art check-line-length

.PRECIOUS: logs/%.out
logs/%.out: tests/%.in logs pygmentalion.t3 FORCE
	tail -n 2 $< | tr '\n' ' ' | grep -qx '>q >y '
	frob -S -p -k UTF-8 -i plain -R $< pygmentalion.t3 >$@
	diff tests/$*.out $@

.PHONY: check-cover-art
check-cover-art: .system/CoverArt.png
	test "$$(identify -ping -format %wx%h $<)" = $(COVER_ART_DIMENSIONS)

.PHONY: check-line-length
check-line-length:
	! grep -v '^ *\*   [^ ]*$$' pygmentalion.t | grep -q '^.\{80\}'

.PHONY: FORCE
FORCE:
