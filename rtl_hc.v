module rtl_hc #(
    parameter N = 32
) (
    input wire clk,
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    output wire [N-1: 0] y
);

wire [N: 0] g = {a & b, 1'b0};
wire [N-1: 0] p = a | b;  // can be changed to "p = a ^ b"

han_carlson #(N) impl(g, p, c);

assign y = c ^ a ^ b;

endmodule
