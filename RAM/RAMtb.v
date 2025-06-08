`include "RAM.v"
module tb_ram;

  // Testbench signals
  reg [7:0] data_in_a, data_in_b;
  reg [5:0] addr_a, addr_b;
  reg re_a, re_b, we_a, we_b, cs, clk, rst;
  wire [7:0] data_out_a, data_out_b;

    // Instantiate the RAM module (uut stands for Unit Under Test)
  ram uut (
        .data_in_a(data_in_a),
        .data_in_b(data_in_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .re_a(re_a),
        .re_b(re_b),
        .we_a(we_a),
        .we_b(we_b),
        .cs(cs),
        .clk(clk),
        .rst(rst),
        .data_out_a(data_out_a),
        .data_out_b(data_out_b)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;  // 10ns clock period
  end

  // Initial block for stimulus
  initial begin
    $dumpfile("dump.vcd");   // Specifies the VCD file
    $dumpvars(0, tb_ram);     // Dumps all signals in the testbench

    // Initialize signals
    clk = 0;
    rst = 0;
    cs = 1;  // Enable chip select
    re_a = 0;
    re_b = 0;
    we_a = 0;
    we_b = 0;
    addr_a = 6'b0;
    addr_b = 6'b0;
    data_in_a = 8'b0;
    data_in_b = 8'b0;

    // Apply Reset
    #5 rst = 1; // Assert reset for 5 ns
    #10 rst = 0; // Deassert reset after 10 ns

    // Test 1: Write to address 5 on port A and read back
    #10 addr_a = 6'd5; data_in_a = 8'hAA; we_a = 1;  // Write AA to address 5 on port A
    #10 we_a = 0; re_a = 1; // Read from address 5 on port A
    #10 $display("Read from Port A: data_out_a = %h", data_out_a); // Expected: 0xAA

    // Test 2: Write to address 10 on port B and read back
    #10 addr_b = 6'd10; data_in_b = 8'h55; we_b = 1;  // Write 55 to address 10 on port B
    #10 we_b = 0; re_b = 1; // Read from address 10 on port B
    #10 $display("Read from Port B: data_out_b = %h", data_out_b); // Expected: 0x55

    // Test 3: Write to the same address (5) on both ports and check results
    #10 addr_a = 6'd5; data_in_a = 8'hBB; we_a = 1;  // Write BB to address 5 on port A
    #10 addr_b = 6'd5; data_in_b = 8'hCC; we_b = 1;  // Write CC to address 5 on port B
    #10 we_a = 0; we_b = 0; re_a = 1; re_b = 1; // Read from the same address (5) on both ports
    #10 $display("Read from Port A: data_out_a = %h", data_out_a); // Expected: 0xBB (port A wins)
    #10 $display("Read from Port B: data_out_b = %h", data_out_b); // Expected: 0xCC (port B wins)

    // Test 4: Write to different addresses and read them back
    #10 addr_a = 6'd15; data_in_a = 8'hDD; we_a = 1;  // Write DD to address 15 on port A
    #10 addr_b = 6'd20; data_in_b = 8'hEE; we_b = 1;  // Write EE to address 20 on port B
    #10 we_a = 0; we_b = 0; re_a = 1; re_b = 1; // Read from address 15 on port A and 20 on port B
    #10 $display("Read from Port A: data_out_a = %h", data_out_a); // Expected: 0xDD
    #10 $display("Read from Port B: data_out_b = %h", data_out_b); // Expected: 0xEE

    // Test 5: Apply reset and check memory content
    #10 rst = 1; // Assert reset again
    #10 rst = 0; // Deassert reset
    #10 addr_a = 6'd5; re_a = 1; // Check if address 5 has been cleared
    #10 $display("Read from Port A after Reset: data_out_a = %h", data_out_a); // Expected: 0x00
    #10 addr_b = 6'd10; re_b = 1; // Check if address 10 has been cleared
    #10 $display("Read from Port B after Reset: data_out_b = %h", data_out_b); // Expected: 0x00

    // End the simulation
    #10 $finish;
  end

endmodule
