module tb;
    reg [3:0] t_a, t_b;
    reg t_op;
    wire [3:0] t_r;

    alu dut (.a(t_a), .b(t_b), .op(t_op), .result(t_r));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut);
        end
    end


    integer i, j, k;
    integer expected;
    integer passed, failed;
    initial begin 
        passed = 0;
        failed = 0;
        for (i = 0; i <= 1; i = i + 1) begin
            for (j = 0; j <= 15; j = j + 1) begin
                for (k = 0; k <= 15; k = k + 1) begin

                    t_op = i;
                    t_a = j;
                    t_b = k;

                    #2;

                    if (t_op == 0)
                        expected = (t_a + t_b) & 4'hF;
                    else
                        expected = (t_a - t_b) & 4'hF;

                    if (t_r === expected[3:0]) begin
                        passed = passed + 1;
                    end
                    else begin
                        failed = failed + 1;
                        $display("FAIL: OP=%b A=%b B=%b | Got=%b Expected=%b",
                                 t_op, t_a, t_b, t_r, expected[3:0]);
                    end

                end
            end
        end

        $display("PASSED = %0d", passed);
        $display("FAILED = %0d", failed);
        $display("TOTAL  = %0d", passed + failed);

        $finish;
    end

endmodule