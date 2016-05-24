.PHONY: test

all: lib/uchina-holidays.js lib/uchina-holidays.min.js

lib/japanese-holidays.js: src/uchina-holidays.coffee
	@/usr/local/bin/coffee -o lib -cm $<

lib/japanese-holidays.min.js: src/uchina-holidays.coffee
	@/usr/local/bin/uglifyjs lib/uchina-holidays.js -c \
		--in-source-map lib/uchina-holidays.js.map \
		--source-map lib/uchina-holidays.min.js.map \
		--source-map-url uchina-holidays.min.js.map \
		-o lib/uchina-holidays.min.js \
		--mangle all
	@# Why is this needed?
	@sed -i -E 's/"sources":\["\.\.\//"sourceRoot":"..","sources":["/' \
		lib/japanese-holidays.min.js.map

test: all
	@node test/shunbun.js
	@node test/shubun.js
	@node test/japanese.holiday.js
	@node test/holiday-jp.js
