/* Figure 8 is the parallel prefix graph of a HanCarlson adder. This adder has a hybrid design
 * combining stages from the Brent-Kung and KoggeStone adder. The Han-Carlson adder is efficient and
 * suitable for VLSI implementation.
*/
module han_carlson #(
    parameter N = 32,
    parameter K = 1
) (
    input wire [N: 0] g,
    input wire [N: 1] p,
    output wire [N: 0] c
);

localparam STEPS = $clog2((N + 1 + (1 << K) - 1) >> K);

wire [K+STEPS+1: 0][N: 0] a;
wire [K+STEPS+1: 0][N: 0] b;

assign a[0] = g;
assign b[0] = {p, 1'b1};

genvar i, j;
generate
    // Brent Kung K steps (forward)
    for (i = 0; i < K; i = i + 1) begin
        localparam shift = 1 << i;
        for (j = 0; j <= N; j = j + 1) begin
            if ((j & (2 * shift - 1)) == (2 * shift - 1)) begin
                localparam source = j - shift;
                assign a[i + 1][j] = a[i][j] | (a[i][source] & b[i][j]);
                assign b[i + 1][j] = b[i][j] & b[i][source];
            end else begin
                assign a[i + 1][j] = a[i][j];
                assign b[i + 1][j] = b[i][j];
            end
        end
    end
    // Kogge stone only with (1<<K) odd bits
    for (i = 0; i < STEPS; i = i + 1) begin
        localparam shift = 1 << (i + K);
        for (j = (1<<K) - 1; j <= N; j = j + (1<<K)) begin
            localparam source = j - shift;
            if (j >= shift) begin
                assign a[i + K + 1][j] = a[i + K][j] | (a[i + K][source] & b[i + K][j]);
                assign b[i + K + 1][j] = b[i + K][j] & b[i + K][source];
            end else begin
                assign a[i + K + 1][j] = a[i + K][j];
                assign b[i + K + 1][j] = b[i + K][j];
            end
        end
    end
    // non (1<<K) odd bits bypass
    for (j = 0; j <= N; j = j + 1) begin
        if ((j & ((1 << K) - 1)) != ((1 << K) - 1)) begin
            assign a[K+STEPS][j] = a[K][j];
            assign b[K+STEPS][j] = b[K][j];
        end
    end
    // Brent Kung many-in-one steps (backward)
    for (j = 0; j <= N; j = j + 1) begin
        localparam shift = (j+1) & ~j;
        if ((shift >= j) | (shift >= (1<<K))) begin
            assign a[K+STEPS+1][j] = a[K+STEPS][j];
            assign b[K+STEPS+1][j] = b[K+STEPS][j];
        end else begin
            localparam source = j - shift;
            assign a[K+STEPS+1][j] = a[K+STEPS][j] | (a[K+STEPS+1][source] & b[K+STEPS][j]);
            assign b[K+STEPS+1][j] = b[K+STEPS][j] & b[K+STEPS+1][source];
        end
    end
endgenerate

assign c = a[K+STEPS+1];

endmodule