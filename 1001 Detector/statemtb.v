`timescale 1ns/1ps
`include "statem.v"  // Include the module file

module test_sequence_detector;
    reg clk;
    reg rst;
    reg a;
    wire op; 

    // Instantiate the sequence detector (uut: unit under test)
    sequence_detector uut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .op(op)
    );

    // Clock generation (100 MHz clock, period = 10 ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ns (100 MHz clock)
    end

    // VCD file generation for waveform visualization
    initial begin
        $dumpfile("sequence_detector.vcd");  // VCD file for waveform output
        $dumpvars(0, test_sequence_detector); // Dump all signals
    end

    // Stimulus generation (apply input sequence)
    initial begin
        rst = 1;       // Assert reset initially
        a = 0;         // Start with input 'a' = 0
        #10 rst = 0;   // Deassert reset after 10 ns

        // Apply input sequence: 1001
        #10 a = 1;
        #10 a = 0;
        #10 a = 0;
        #10 a = 1;

        // Apply another sequence: 1001
        #10 a = 1;
        #10 a = 0;
        #10 a = 0;
        #10 a = 1;

        // Apply a non-matching sequence: 1100
        #10 a = 1;
        #10 a = 1;
        #10 a = 0;
        #10 a = 0;

        #10 $finish;  // End simulation after the sequence is applied
    end
endmodule

