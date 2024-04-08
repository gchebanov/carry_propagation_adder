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