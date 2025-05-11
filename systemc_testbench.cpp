
#include "systemc_model.h"
#include <systemc>
using namespace sc_core;

int sc_main(int argc, char* argv[]) {
    sc_clock clk("clk", 10, SC_NS);
    MySystemCModel model("model", 100);
    model.clk(clk);

    sc_start(1, SC_NS);
    model.input(7);
    model.input(3);

    int result = model.output();
    std::cout << "Unit Test: Final state = " << result << std::endl;

    return 0;
}
