.ONESHELL:
.RECIPEPREFIX=>

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SOURCES=$(call rwildcard,.,*.cpp)
OBJECTS=$(SOURCES:.cpp=.o)

TARGET=dagr.exe

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

LDLIBS+=-Ilib/curl -Llib/curl -lcurl

all: $(TARGET) deps

clean:
>$(RM) $(OBJECTS)
>$(RM) $(TARGET)
>$(RM) libcurl-x64.dll

deps:
ifeq ($(OS),Windows_NT)
>@xcopy .\lib\curl\libcurl-x64.dll . /Q /Y
else
>@cp lib/curl/libcurl-x64.dll .
endif

run:
>./$(TARGET)

$(TARGET): $(OBJECTS)
>$(LINK.cpp) $^ -o $@ $(LDLIBS)