
#include "systemc_model.h"
#include <iostream>

MySystemCModel::MySystemCModel(sc_core::sc_module_name name, int param)
    : sc_module(name), state(param)
{
    std::cout << "SystemC model initialized with param = " << param << std::endl;
    SC_METHOD(process);
    sensitive << clk.pos();
}

void MySystemCModel::input(int val) {
    state += val;
    std::cout << "SystemC received input: " << val << std::endl;
}

int MySystemCModel::output() const {
    std::cout << "SystemC returning state: " << state << std::endl;
    return state;
}

void MySystemCModel::process() {
    // Optional for simulation timing
}
