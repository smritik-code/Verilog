module halfadder(a,b,s1,c1);
input a,b;
output s1,c1;


assign s1= a^b;
assign c1= a&b;

endmodule

module fulladder(a,b,c,sum,co);
input a,b,c;
output sum,co;

wire s,s1,c1,c2;

halfadder h1 (a,b,s1,c1);
halfadder h2 (s1,c,s,c2);
assign co=c1|c2;
assign sum=s;

endmodule