module rtl_lf #(
    parameter N = 64
) (
    input wire clk,
    input wire [N-1: 0] wa,
    input wire [N-1: 0] wb,
    output reg [N-1: 0] y
);

reg [N-1: 0] a;
reg [N-1: 0] b;

wire [N-1: 0] g = {a & b, 1'b0};
wire [N-2: 0] p = a | b;

wire [N-1: 0] c;

lander_fischer #(N-1) impl(g, p, c);

always @(posedge clk) begin
    a <= wa;
    b <= wb;
    y <= c ^ a ^ b;
end

endmodule
