/* Figure 7 is the parallel prefix graph of a BrentKung adder. The Brent-Kung adder is the extreme
 * boundary case of maximum logic depth in PP adders
 * (implies longer calculation time) and minimum
 * number of nodes (implies minimum area).
 */
module brent_kung #(
    parameter N = 2
) (
    input wire [N: 0] g,
    input wire [N: 0] p,
    output wire [N: 0] c
);

localparam STEPS = $clog2(N + 2) - 1;

/*  16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
 *      1     1     1     1     1     1     1     1
 *      2           2           2           2  2*
 *      3                       3     3* 3*
 *      4           4*    4* 4*    4*
 *   5*       5* 5*    5*
 *         6*
 */

/*  Actual clog2 param (gate depth by last index)
 *  2 -> 3 (2)
 *  4 -> 5 (3)
 *  6 -> 9 (4)
 *  10 -> 17 (5)
 *  14 -> 33 (6)
 *  22 -> 65 (7)
 *  30 -> 129 (8)
 *  46 -> 257 (9)
 *  62 -> 513 (10)
 */


wire [STEPS+1: 0][N: 0] a;
wire [STEPS+1: 0][N: 0] b;

assign a[0] = g;
assign b[0] = {p, 1'b1};

genvar i, j;
generate
    for (i = 0; i < STEPS; i = i + 1) begin
        localparam shift = 1 << i;
        for (j = 0; j <= N; j = j + 1) begin
            if ((j & (2*shift - 1)) == 2*shift - 1) begin
                localparam source = j - shift;
                assign a[i + 1][j] = a[i][j] | (a[i][source] & b[i][j]);
                assign b[i + 1][j] = b[i][j] & b[i][source];
            end else begin
                assign a[i + 1][j] = a[i][j];
                assign b[i + 1][j] = b[i][j];
            end
        end
    end
    //  16 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00
    //   1  0  1  2  1  4  1  2  1  0  1  2  1  0  1  0  0
    for (j = 0; j <= N; j = j + 1) begin
        if ((j & (j + 1)) == '0) begin
            assign a[STEPS+1][j] = a[STEPS][j];
            assign b[STEPS+1][j] = b[STEPS][j];
        end else begin
            localparam shift = (j+1) & ~j;
            localparam source = j - shift;
            // care! reuse save array index (STEPS) with source shift.
            assign a[STEPS+1][j] = a[STEPS][j] | (a[STEPS+1][source] & b[STEPS][j]);
            assign b[STEPS+1][j] = b[STEPS][j] & b[STEPS+1][source];
        end
    end
endgenerate

assign c = a[STEPS + 1];

endmodule