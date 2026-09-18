// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  localparam integer t_depth=8,t_width=8;
  reg [$clog2(t_depth)-1:0] t_sel;
  wire [t_width-1:0] t_dout;
  // TODO: instantiate DUT here
  lut #(.DEPTH(t_depth), .WIDTH(t_width)) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    t_sel=0;
    #5 t_sel=1;
    #5 t_sel=2;
    #5 t_sel=3;
    #5 t_sel=4;
    #5 t_sel=5;
    #5 t_sel=6;
    #5 t_sel=7;
    #5 $finish;
  end

  initial
    $monitor($time, " Sel=%b | Dout=%b", t_sel, t_dout); // change as required

endmodule
