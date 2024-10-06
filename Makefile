PREFIX = /usr
TARGET = paliforge
LUA_LIB = lua5.4

SRC_FILES := $(shell find ./src -type f | tr '\n' ' ')
LUA_FILES := $(shell find ./lua -type f | tr '\n' ' ')

install: $(TARGET) $(LUA_FILES)
	install -m 755 paliforge $(DESTDIR)$(PREFIX)/bin/$(TARGET)
	install -d $(DESTDIR)$(PREFIX)/lib/paliforge
	cp -r lua $(DESTDIR)$(PREFIX)/lib/paliforge

$(TARGET): $(SRC_FILES)
	cc $(SRC_FILES) -l${LUA_LIB} -DPALIFORGE_LIB_PATH=$(DESTDIR)$(PREFIX)/lib/paliforge/lua -o $(TARGET)

clean:
	rm -rf $(DESTDIR)$(PREFIX)/lib/paliforge
	rm -f $(DESTDIR)$(PREFIX)/bin/paliforge
