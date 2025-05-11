
module tb_top;

  import "DPI-C" function void sc_model_init(input int param);
  import "DPI-C" function void sc_model_drive(input int val);
  import "DPI-C" function int  sc_model_get();

  int i;
  int out;

  initial begin
    $display("SystemVerilog testbench starting.");
    sc_model_init(42);

    for (i = 0; i < 10; i++) begin
      sc_model_drive(i);
      out = sc_model_get();
      $display("SV TB: Sent %0d, Received from SC: %0d", i, out);
    end

    $finish;
  end

endmodule
