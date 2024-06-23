PLATFORM = $(shell uname)
CC = g++
CFLAGS = -Wall -std=c++11 -I./include $(shell pkg-config --cflags glfw3)

# Setting LIBS for different platforms
ifeq ($(PLATFORM),Darwin)
	LIBS = -framework OpenGL -framework GLUT $(shell pkg-config --libs glfw3)
else
	LIBS = $(shell pkg-config --libs glfw3)
endif

C_SOURCES = $(wildcard src/*.c) $(wildcard src/**/*.c)
CPP_SOURCES = $(wildcard src/*.cpp) $(wildcard src/**/*.cpp)
OBJECTS = $(C_SOURCES:.c=.o) $(CPP_SOURCES:.cpp=.o)
EXEC = main

all: $(EXEC)

$(EXEC): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LIBS)

# Compile the source files
.cpp.o: $(CPP_SOURCES)
	echo $(CPP_SOURCES)
	$(CC) $(CFLAGS) -c $< -o $@

.c.o: $(C_SOURCES)
	echo $(C_SOURCES)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f src/glad.o $(OBJECTS) $(SB7_OBJ) $(EXEC)
