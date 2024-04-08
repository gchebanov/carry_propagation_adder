module rtl_internal #(
    parameter N = 64
) (
    input wire clk,
    input wire [N-1: 0] wa,
    input wire [N-1: 0] wb,
    output reg [N-1: 0] y
);

reg [N-1: 0] a;
reg [N-1: 0] b;

wire [N-1: 0] c;
wire cout;

internal #(N) impl(a, b, 0, c, cout);

always @(posedge clk) begin
    a <= wa;
    b <= wb;
    y <= c;
end

endmodule
