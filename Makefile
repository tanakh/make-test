.PHONY: all
all: main

.PHONY: clean
clean:
	rm -f ${OBJS} ${DEPS} foo.h main

SRCS = foo.cpp main.cpp
OBJS = ${SRCS:.cpp=.o}
DEPS = ${SRCS:.cpp=.d}

main: ${OBJS}
	g++ ${OBJS} -o $@

${OBJS}: %.o : %.cpp | gen_header
	g++ -MMD -MP -c $< -o $@

.PHONY: gen_header
.NOTPARALLEL: gen_header
gen_header:
	./header_gen.sh

-include ${DEPS}
