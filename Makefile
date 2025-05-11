
PROJECT     := dpi_sv_systemc_tb
TOP_MODULE  := tb_top

SV_SOURCES  := tb_top.sv
CPP_SOURCES := dpi_interface.c systemc_model.cpp
HEADERS     := dpi_interface.h systemc_model.h

OBJ_DIR     := obj
BIN_DIR     := bin
VLT_OUT     := $(OBJ_DIR)/V$(TOP_MODULE)

CXX         := g++
CXXFLAGS    := -std=c++17 -I. -I$(SYSTEMC_HOME)/include -I$(OBJ_DIR)
LDFLAGS     := -L$(SYSTEMC_HOME)/lib -lsystemc -lm -pthread

VERILATOR         := verilator
VERILATOR_FLAGS   := -Wall --cc --exe --sv --build                      --top-module $(TOP_MODULE)                      --Mdir $(OBJ_DIR)                      -CFLAGS "$(CXXFLAGS)"                      -LDFLAGS "$(LDFLAGS)"                      $(SV_SOURCES) $(CPP_SOURCES)

all: $(BIN_DIR)/simv

$(BIN_DIR)/simv:
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(VERILATOR) $(VERILATOR_FLAGS)
	mv $(OBJ_DIR)/V$(TOP_MODULE) $@

run: all
	./$(BIN_DIR)/simv

systemc_test:
	$(CXX) -std=c++17 -I. -I$(SYSTEMC_HOME)/include systemc_testbench.cpp systemc_model.cpp -L$(SYSTEMC_HOME)/lib -lsystemc -o $(BIN_DIR)/systemc_test
	./$(BIN_DIR)/systemc_test

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all run clean systemc_test
