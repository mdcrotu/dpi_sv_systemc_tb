
#ifndef SYSTEMC_MODEL_H
#define SYSTEMC_MODEL_H

#include <systemc>

SC_MODULE(MySystemCModel) {
    sc_core::sc_in<bool> clk;
    int state;

    SC_HAS_PROCESS(MySystemCModel);
    MySystemCModel(sc_core::sc_module_name name, int param);

    void input(int val);
    int output() const;

private:
    void process();
};

#endif
