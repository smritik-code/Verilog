`include "moore.v"
`timescale 10ns/1ps

module test_color_detector;

reg clk, rst;
wire [1:0] colour;

colour_sequence uut(clk, rst, colour);

  initial begin
        clk = 1;
        forever #5 clk = ~clk; // Toggle clock every 5 ns (100 MHz clock)
    end

  initial begin
        $dumpfile("moore.vcd");  // VCD file for waveform output
        $dumpvars(0, test_color_detector); // Dump all signals


        rst=1;
        #5 rst=0;
        #20 rst=1;
        #5 rst=0;
        #10 $finish;
    end

endmodule