
PREFIX ?= /usr/local
INSTALL_DIR ?= $(PREFIX)

LBITS := $(shell getconf LONG_BIT)
ARCH ?= $(LBITS)

CFLAGS = -std=c11 -O3 -Wall -m$(ARCH) -fPIC
LFLAGS = -lhl

OBJ = hlinotify.o

all: inotify.hdll

inotify.hdll: ${OBJ}
	${CC} -o $@ -shared ${CFLAGS} ${LFLAGS} ${OBJ}

install:
	mkdir -p $(INSTALL_DIR)
	mkdir -p $(INSTALL_DIR)/lib
	cp inotify.hdll $(INSTALL_DIR)/lib

uninstall:
	rm -f $(INSTALL_DIR)/lib/inotify.hdll

clean:
	rm -f inotify.hdll ${OBJ}

.PHONY: all install uninstall clean
