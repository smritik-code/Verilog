`include "grey.v"
`timescale 1ns/1ps

module binary_to_grey_test;

reg [3:0] a;
wire [3:0] b;

binary_to_grey uut(a,b);
initial begin
    $dumpfile("bin_to_grey.vcd");  // VCD file for waveform output
    $dumpvars(0, binary_to_grey_test); // Dump all signals
    
    a = 4'b1100;
    #10;
    a= 4'b1010;
    #10;
    a= 4'b1001;
    #10;
    a= 4'b0111;
    #10; $finish;
end

endmodule