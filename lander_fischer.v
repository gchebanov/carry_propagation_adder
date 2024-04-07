/* Figure 5 is the parallel prefix graph of a
 * Ladner-Fischer adder. This adder structure has
 * minimum logic depth, but has large fan-out
 * requirement up to n/2.
*/
module lander_fischer #(
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

genvar i, j;
generate
    for (i = 0; i < STEPS; i = i + 1) begin
        localparam shift = 1 << i;
        for (j = 0; j <= N; j = j + 1) begin
            if (((j >> i) & 1) == 1) begin
                localparam source = (j | (shift - 1)) - shift;
                assign a[i + 1][j] = a[i][j] | (a[i][source] & b[i][j]);
                assign b[i + 1][j] = b[i][j] & b[i][source];
            end else begin
                assign a[i + 1][j] = a[i][j];
                assign b[i + 1][j] = b[i][j];
            end
        end
    end
endgenerate

assign c = a[STEPS];

endmodule