module cla #(
    parameter N = 32
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    input wire cin,
    output wire [N-1: 0] y,
    output wire cout
);

wire [N: 0] g = {a & b, cin};
wire [N-1: 0] p = a | b;  // can be changed to "p = a ^ b"

wire [N: 0] c;
// cla_stupid #(N) impl (g, p, c);
// kogge_stone #(N) impl(g, p, c);
// lander_fischer #(N) impl(g, p, c);
// brent_kung #(N) impl(g, p, c);
han_carlson #(N) impl(g, p, c);

assign y = c ^ a ^ b;
assign cout = c[N];

endmodule
