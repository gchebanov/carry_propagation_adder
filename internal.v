module internal #(
    parameter N = 2
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    input wire cin,
    output wire [N-1: 0] y,
    output wire cout
);

assign {cout, y} = a + b + cin;

endmodule
