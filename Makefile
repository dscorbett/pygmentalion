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

.PHONY: all
all: pygmentalion.t3 pygmentalion-web.t3

.PHONY: cli
cli: pygmentalion.t3

.PHONY: web
web: pygmentalion-web.t3

.PHONY: play
play: pygmentalion.t3
	frob -p $<

.PHONY: play-web
play-web: pygmentalion-web.t3
	frob -i plain -p -N 44 $<

%.t3: %.t3m obj
	t3make -a -f $*

obj:
	mkdir $@

.PHONY: clean
clean:
	$(RM) -r *.t3 obj
