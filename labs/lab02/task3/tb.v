module tb;
    reg [1:0] t_a;
    reg [1:0] t_b;
    wire t_gt, t_lt, t_eq;
    reg exp_gt, exp_lt, exp_eq;
    integer errors, i;
    comp2 DUT(
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );  

    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
        $dumpfile(vcd_file);
        $dumpvars(0, DUT);
        end
    end
    initial begin
        t_a=0; t_b=0; exp_gt=0; exp_lt=0; exp_eq=1;
        #5 t_a=0; t_b=1; exp_gt=0; exp_lt=1; exp_eq=0;
        #5 t_a=0; t_b=2; exp_gt=0; exp_lt=1; exp_eq=0;
        #5 t_a=0; t_b=3; exp_gt=0; exp_lt=1; exp_eq=0;

        #5 t_a=1; t_b=0; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=1; t_b=1; exp_gt=0; exp_lt=0; exp_eq=1;
        #5 t_a=1; t_b=2; exp_gt=0; exp_lt=1; exp_eq=0;
        #5 t_a=1; t_b=3; exp_gt=0; exp_lt=1; exp_eq=0;

        #5 t_a=2; t_b=0; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=2; t_b=1; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=2; t_b=2; exp_gt=0; exp_lt=0; exp_eq=1; 
        #5 t_a=2; t_b=3; exp_gt=0; exp_lt=1; exp_eq=0;

        #5 t_a=3; t_b=0; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=3; t_b=1; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=3; t_b=2; exp_gt=1; exp_lt=0; exp_eq=0;
        #5 t_a=3; t_b=3; exp_gt=0; exp_lt=0; exp_eq=1;
        #5 $finish;
    end
    initial begin
    errors = 0;
    #1;
    for (i = 0; i < 16; i = i + 1) begin
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
            $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                     $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
            errors = errors + 1;
        end
        if(i<15)
            #5;
    end

    $display("Test completed: %0d/16 passed, %0d errors", 16 - errors, errors);
end
endmodule