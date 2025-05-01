.ONESHELL:
.RECIPEPREFIX=>

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SOURCES=$(call rwildcard,.,*.cpp)
OBJECTS=$(SOURCES:.cpp=.o)

ifeq ($(OS),Windows_NT)
TARGET=dagr.exe
else
TARGET=dagr
endif

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

LDLIBS+=-Ilib/curl -Llib/curl -lcurl -lssl
LDFLAGS+=-Wl,--copy-dt-needed-entries

all: $(TARGET) deps

clean:
>$(RM) $(OBJECTS)
>$(RM) $(TARGET)
ifeq ($(OS),Windows_NT)
>$(RM) libcurl-x64.dll
endif

deps:
ifeq ($(OS),Windows_NT)
>@xcopy .\lib\curl\libcurl-x64.dll . /Q /Y
endif

run:
>./$(TARGET)

$(TARGET): $(OBJECTS)
>$(LINK.cpp) $^ -o $@ $(LDLIBS)
