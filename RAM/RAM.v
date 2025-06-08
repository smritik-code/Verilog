module ram(

input [7:0] data_in_a, data_in_b,   
input [5:0] addr_a, addr_b,         
input re_a, re_b, we_a, we_b, cs, clk, rst,  
output reg [7:0] data_out_a, data_out_b); 

reg [7:0] data[127:0];  
integer i; 

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 128; i = i + 1) begin
            data[i] <= 8'b0;
        end
    end else if (cs) begin
        if (we_a) begin
            data[addr_a] <= data_in_a;  
        end
        if (we_b) begin
            data[addr_b] <= data_in_b; 
        end

        if (re_a) begin
            data_out_a <= data[addr_a];  
        end
        if (re_b) begin
            data_out_b <= data[addr_b]; 
        end
    end
end

endmodule
