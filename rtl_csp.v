module rtl_csp #(
    parameter N = 64
) (
    input wire clk,
    input wire [N-1: 0] wa,
    input wire [N-1: 0] wb,
    output reg [N-1: 0] y
);

reg [N-1: 0] a;
reg [N-1: 0] b;

wire [N-1: 0] c0, c1;
wire cout0, cout1;

conditional_sum_p #(N) impl (a, b, c0, cout0, c1, cout1);

always @(posedge clk) begin
    a <= wa;
    b <= wb;
    y <= c0;
end

endmodule
