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

module conditional_sum_combine #(
    parameter N,
    parameter HI,
    parameter LO = N - HI
) (
    input wire [N - 1: 0] a,
    input wire [N - 1: 0] b,
    input wire cin,
    output wire [N - 1: 0] y,
    output wire cout,

    output wire [HI - 1: 0] hi0_a,
    output wire [HI - 1: 0] hi0_b,
    output wire hi0_cin,
    input wire [HI - 1: 0] hi0_y,
    input wire hi0_cout,

    output wire [HI - 1: 0] hi1_a,
    output wire [HI - 1: 0] hi1_b,
    output wire hi1_cin,
    input wire [HI - 1: 0] hi1_y,
    input wire hi1_cout,

    output wire [LO - 1: 0] lo_a,
    output wire [LO - 1: 0] lo_b,
    output wire lo_cin,
    input wire [LO - 1: 0] lo_y,
    input wire lo_cout
);

generate if (N != HI + LO) error_t error(); endgenerate

// init hi0, hi1, lo adders input
assign hi0_a = a[N-1: LO];
assign hi0_b = b[N-1: LO];
assign hi0_cin = 1'b0;
assign hi1_a = a[N-1: LO];
assign hi1_b = b[N-1: LO];
assign hi1_cin = 1'b1;
assign lo_a = a[LO-1: 0];
assign lo_b = b[LO-1: 0];
assign lo_cin = cin;

// combine outputs
assign {cout, y} = {lo_cout ? {hi1_cout, hi1_y} : {hi0_cout, hi0_y}, lo_y};

endmodule  // conditional_sum_combine
