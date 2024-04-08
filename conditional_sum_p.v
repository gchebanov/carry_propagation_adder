module conditional_sum_p #(
    parameter N = 64,
    parameter K = 8
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    output wire [N-1: 0] y0,
    output wire cout0,
    output wire [N-1: 0] y1,
    output wire cout1
);

generate
    if (N > K) begin
        localparam HI = N / 2;
        localparam LO = N - HI;

        wire lo_cout0, lo_cout1;
        conditional_sum_p #(LO) lo (a[LO-1: 0], b[LO-1: 0], y0[LO-1: 0], lo_cout0, y1[LO-1: 0], lo_cout1);
        wire [HI-1: 0] hi_y0, hi_y1;
        wire hi_cout0, hi_cout1;
        conditional_sum_p #(HI) hi (a[N-1: LO], b[N-1: LO], hi_y0, hi_cout0, hi_y1, hi_cout1);

        assign {cout0, y0[N-1: LO]} = lo_cout0 ? {hi_cout1, hi_y1} : {hi_cout0, hi_y0};
        assign {cout1, y1[N-1: LO]} = lo_cout1 ? {hi_cout1, hi_y1} : {hi_cout0, hi_y0};
    end else begin
        internal #(N) impl0 (a, b, 1'b0, y0, cout0);
        internal #(N) impl1 (a, b, 1'b1, y1, cout1);
    end
endgenerate

endmodule  // conditional_sum