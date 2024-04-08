module carry_select #(
    parameter N = 64,
    parameter K = 2
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    input wire cin,
    output wire [N-1: 0] y,
    output wire cout
);

generate
    if (N >= K) begin
        wire c;
        internal #(K) lo (a[K-1: 0], b[K-1: 0], cin, y[K-1: 0], c);
        wire c0, c1;
        wire [N-K-1: 0] y0, y1;
        carry_select #(N-K, K+1) hi0 (a[N-1: K], b[N-1: K], 1'b0, y0, c0);
        carry_select #(N-K, K+1) hi1 (a[N-1: K], b[N-1: K], 1'b1, y1, c1);
        assign {cout, y[N-1: K]} = c ? {c1, y1} : {c0, y0};
    end else begin
        internal #(N) impl (a, b, cin, y, cout);
    end
endgenerate

endmodule  // carry_select