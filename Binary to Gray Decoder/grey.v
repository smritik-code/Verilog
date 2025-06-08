module binary_to_grey (
    input [3:0] a, 
    output reg [3:0] g
);

always @(*) begin
    g[3] = a[3];
    g[2] = a[3] ^ a[2];
    g[1] = a[2] ^ a[1];
    g[0] = a[1] ^ a[0];
end

endmodule
