
PROJECT     := dpi_sv_systemc_tb
TOP_MODULE  := tb_top

SV_SOURCES  := tb_top.sv
CPP_SOURCES := dpi_interface.c systemc_model.cpp
HEADERS     := dpi_interface.h systemc_model.h

OBJ_DIR     := obj
BIN_DIR     := bin
VLT_OUT     := $(OBJ_DIR)/V$(TOP_MODULE)

TARGET_ARCH      ?= linux64
ifneq (,$(strip $(TARGET_ARCH)))
ARCH_SUFFIX      ?= -$(TARGET_ARCH)
endif
LDFLAG_RPATH     ?= -Wl,-rpath=

SYSTEMC_INC_DIR  ?= $(SYSTEMC_HOME)/include
SYSTEMC_LIB_DIR  ?= $(SYSTEMC_HOME)/lib$(ARCH_SUFFIX)

SYSTEMC_DEFINES  ?=
SYSTEMC_CXXFLAGS ?= $(FLAGS_COMMON) $(FLAGS_STRICT) $(FLAGS_WERROR)
SYSTEMC_LDFLAGS  ?= -L$(SYSTEMC_LIB_DIR) \
                    $(LDFLAG_RPATH)$(SYSTEMC_LIB_DIR)
SYSTEMC_LIBS     ?= -lsystemc -lm

INCDIR   += -I. -I$(SYSTEMC_INC_DIR)
LIBDIR   += -L. 

CXX         := g++
CXXFLAGS    := -std=c++17 -I. $(INCDIR) -I$(OBJ_DIR)
LDFLAGS     := $(LIBDIR) $(SYSTEMC_LDFLAGS) $(SYSTEMC_LIBS)

VERILATOR         := verilator
#VERILATOR_FLAGS   := -Wall --cc --exe --sv --build --top-module $(TOP_MODULE) --Mdir $(OBJ_DIR) -CFLAGS "$(CXXFLAGS)" -LDFLAGS "$(LDFLAGS)" $(SV_SOURCES) $(CPP_SOURCES) systemc_testbench.cpp
VERILATOR_FLAGS   := -sc --exe --build -j 0 $(SV_SOURCES) $(CPP_SOURCES)

all: $(BIN_DIR)/simv

create_dirs: 
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)

$(BIN_DIR)/simv: create_dirs
	$(VERILATOR) $(VERILATOR_FLAGS)
	mv $(OBJ_DIR)/V$(TOP_MODULE) $@

run: all
	./$(BIN_DIR)/simv

systemc_test: create_dirs
	$(CXX) -std=c++17 -I. -I$(SYSTEMC_HOME)/include systemc_testbench.cpp systemc_model.cpp -L$(SYSTEMC_HOME)/lib$(ARCH_SUFFIX) -lsystemc -o $(BIN_DIR)/systemc_test
	./$(BIN_DIR)/systemc_test

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all run clean create_dirs systemc_test
