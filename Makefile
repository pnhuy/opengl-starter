PLATFORM = $(shell uname)
CC = g++
CFLAGS = -Wall -std=c++11 -I./include $(shell pkg-config --cflags glfw3)

# Setting LIBS for different platforms
ifeq ($(PLATFORM),Darwin)
	LIBS = -framework OpenGL -framework GLUT $(shell pkg-config --libs glfw3)
else
	LIBS = $(shell pkg-config --libs glfw3)
endif

SOURCES = $(wildcard src/*.cpp)
OBJECTS = $(patsubst %.cpp,%.o,$(SOURCES))

EXEC = main

all: $(EXEC)

$(EXEC): $(OBJECTS) glad.o
	$(CC) $(CFLAGS) -o $@ $(OBJECTS) src/glad.o $(LIBS)

# Compile the source files
%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

glad.o: src/glad.c
	$(CC) $(CFLAGS) -c src/glad.c -o src/glad.o

clean:
	rm -f src/glad.o $(OBJECTS) $(EXEC)
