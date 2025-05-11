
#include "dpi_interface.h"
#include "systemc_model.h"
#include <systemc>

static MySystemCModel* model = NULL;
static sc_core::sc_clock* clk = NULL;

void sc_model_init(int param) {
    if (!model) {
        static sc_core::sc_signal<bool> dummy_clk;
        model = new MySystemCModel("model", param);
        clk = new sc_core::sc_clock("clk", sc_core::sc_time(10, sc_core::SC_NS));
        model->clk(*clk);
    }
}

void sc_model_drive(int val) {
    if (model) {
        model->input(val);
        sc_core::sc_start(10, sc_core::SC_NS);
    }
}

int sc_model_get() {
    if (model) {
        return model->output();
    }
    return -1;
}
