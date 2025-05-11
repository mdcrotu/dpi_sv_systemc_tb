
# dpi_sv_systemc_tb

A project that demonstrates how to use SystemVerilog and Verilator with DPI-C to call into a SystemC model.

## Features

- SystemVerilog testbench using DPI
- SystemC `sc_module` model with `sc_main`
- Unit testbench for SystemC model
- Verilator-compatible Makefile

## Requirements

- Verilator
- SystemC library (`SYSTEMC_HOME` environment variable must be set)

## Build & Run

```bash
export SYSTEMC_HOME=/path/to/systemc
make run          # Run Verilator + SystemC simulation
make systemc_test # Run standalone SystemC unit test
```
