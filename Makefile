.ONESHELL:
.RECIPEPREFIX=>

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SOURCEPATH=src
SOURCES=$(call rwildcard,.,*.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
TARGET=dagr

CXXFLAGS=-g0
CXXFLAGS=-m64
CXXFLAGS+=-O2
CXXFLAGS+=-pedantic
CXXFLAGS+=-pedantic-errors
CXXFLAGS+=-pipe
CXXFLAGS+=-s
CXXFLAGS+=-std=c++23
CXXFLAGS+=-Wall
CXXFLAGS+=-Werror
CXXFLAGS+=-Wextra
CXXFLAGS+=-Wpedantic

LDLIBS=-lcurl

all: clean $(TARGET)

clean:
>$(RM) $(OBJECTS)
>$(RM) $(TARGET)

run:
>./$(TARGET)

$(TARGET): $(OBJECTS)
>$(LINK.cpp) $^ -o $@ $(LDLIBS)
