`include "full_adder.v"
`timescale 1ns/1ns

module full_adder_tb;

reg a,b,c;
wire sum,co;

fulladder f1(a,b,c,sum,co);

initial begin

    $dumpfile("full_adder.vcd");
    $dumpvars(0,full_adder_tb);

    a= 1; 
    b= 0;
    c= 1;
    #20;

    a= 1; 
    b= 1;
    c= 1;
    #20;


    $display("Test complete");
    
end

endmodule


