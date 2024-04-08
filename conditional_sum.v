module conditional_sum #(
    parameter N = 64,
    parameter K = 8
) (
    input wire [N-1: 0] a,
    input wire [N-1: 0] b,
    input wire cin,
    output wire [N-1: 0] y,
    output wire cout
);

generate
    if (N >= K) begin
        localparam HI = N / 2;
        localparam LO = N - HI;
        wire [HI-1: 0] hi0_a, hi0_b, hi0_y; wire hi0_cin, hi0_cout;
        wire [HI-1: 0] hi1_a, hi1_b, hi1_y; wire hi1_cin, hi1_cout;
        wire [LO-1: 0] lo_a, lo_b, lo_y; wire lo_cin, lo_cout;
        conditional_sum #(HI) hi0 (hi0_a, hi0_b, hi0_cin, hi0_y, hi0_cout);
        conditional_sum #(HI) hi1 (hi1_a, hi1_b, hi1_cin, hi1_y, hi1_cout);
        conditional_sum #(LO) lo (lo_a, lo_b, lo_cin, lo_y, lo_cout);
        conditional_sum_combine #(N, HI, LO) combine (
            a, b, cin, y, cout,
            hi0_a, hi0_b, hi0_cin, hi0_y, hi0_cout,
            hi1_a, hi1_b, hi1_cin, hi1_y, hi1_cout,
            lo_a, lo_b, lo_cin, lo_y, lo_cout
        );
    end else begin
        internal #(N) impl (a, b, cin, y, cout);
    end
endgenerate

endmodule  // conditional_sum