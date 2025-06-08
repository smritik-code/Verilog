module colour_sequence (input clk, rst, output reg [1:0] cs);

// State definitions
parameter RED = 2'b00, YELLOW = 2'b01, GREEN = 2'b10;

always @(posedge clk or posedge rst) begin 
if (rst) cs <= RED ; 
else begin
    case (cs)
      RED: cs<= YELLOW;
      YELLOW: cs<= GREEN;
      GREEN: cs<= RED;

    endcase
end
end
endmodule