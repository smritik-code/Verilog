module sequence_detector (
    input clk,
    input rst,
    input a,
    output reg op
);
    // State definitions
    parameter s0 = 2'b00, 
              s1 = 2'b01, 
              s2 = 2'b10, 
              s3 = 2'b11;

    reg [1:0] cs; // Current state 

    always @(posedge clk or posedge rst) begin 
        if (rst) begin
            cs <= s0;    // Reset state to s0
            op <= 0;     // Reset output
        end else begin
            case (cs)
                s0: begin
                    cs <= a ? s1 : s0;
                    op <= 0;
                end
                s1: begin
                    cs <= a ? s1 : s2;
                    op <= 0;
                end
                s2: begin
                    
                    cs <= a ? s1 : s3;
                    op <= 0;
                end
                s3: begin
                    cs <= a ? s1 : s0;
                    op <= a ? 1 : 0; // Detects "1001"
                end
                default: begin
                    cs <= s0;  
                    op <= 0;  
                end
            endcase
        end
    end
endmodule
