// ripple carry adder
module rca #(
    parameter N = 2
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    input wire cin,
    output wire [N-1: 0] y,
    output wire cout
);

wire [N: 0] carry;
assign carry[0] = cin;
assign cout = carry[N];

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin
        fa fa(a[i], b[i], carry[i], y[i], carry[i + 1]);
    end
endgenerate

endmodule

module fa (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
