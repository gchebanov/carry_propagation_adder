/* Figure 6 is the parallel prefix graph of a KoggeStone adder. This adder structure has minimum
 * logic depth, and full binary tree with minimum funout, resulting in a fast adder but with a large area
*/
module kogge_stone #(
    parameter N = 2,
    parameter STEPS = $clog2(N + 1)
) (
    input wire [N: 0] g,
    input wire [N: 1] p,
    output wire [N: 0] c
);

wire [STEPS: 0][N: 0] a;
wire [STEPS: 0][N: 0] b;

assign a[0] = g;
assign b[0] = {p, 1'b1};

genvar i;
generate
    for (i = 0; i < STEPS; i = i + 1) begin
        integer j = 1 << i;
        // This is fundamental carry operator
        assign a[i + 1] = a[i] | ((a[i] << j) & b[i]);
        assign b[i + 1] = b[i] & (b[i] << j);
    end
endgenerate

assign c = a[STEPS];

endmodule