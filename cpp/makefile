CC=gcc
FLAGS= -DAPL -Iase -Iase/include/xplane/XPLM -Llib/xplane_mac -lcurl -flat_namespace -undefined warning -std=c++11

_SRC := $(wildcard *.cpp)
_ASE_SRC := $(wildcard ase/*.cpp)
_ASE_ASE_SRC := $(wildcard ase/ase/*.cpp)

BDIR = bin
DDIR = /Volumes/KINGSTON/X-Plane\ 10/Aircraft/Heavy\ Metal/B777-300ER/plugins/Chai112sB777/mac.xpl

$(BDIR)/mac.xpl: $(_SRC) $(_ASE_SRC) $(_ASE_ASE_SRC)
	$ mkdir -p bin 
	$(CC) -o $@ $^ $(FLAGS)

# automatically makes, self-test and clean
all:
	$(MAKE) clean
	$(MAKE) 
	@echo 
	@echo success
	@echo 
	$(MAKE) install
	$(MAKE) clean

install:
	$ cp -f $(BDIR)/mac.xpl $(DDIR)

    
clean:
	rm -f *.o

.PHONY: all install clean

