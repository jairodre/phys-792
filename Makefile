.PHONY: all info clean install

CXXFLAGS = -Wall -O2
CXXFLAGS+= $(shell root-config --cflags)

LIBS = $(shell root-config --libs)

SRC = $(wildcard *.cc)
EXE = $(SRC:.cc=)

all: $(EXE)

%: %.cc 
	$(CXX) $(CXXFLAGS) $(LIBS) $< -o $@

info:
	@echo -n $(SRC) 
	@echo -n $(EXE) 
	@echo -n $(LIBS) 
	@echo -n $(CXXFLAGS) 

clean:
	$(RM) *.exe

install:
	mv *.exe ~/bin


