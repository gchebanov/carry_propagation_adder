module rtl_cnt_l #(
    parameter N = 64
) (
    input wire clk,
    input wire nrst,
    input wire cin,
    output reg [N-1: 0] counter,
    output reg cout
);

// N-K+1 >= (1<<K)
localparam K = $clog2(N);
wire [K: 0] lo_count;
assign lo_count = counter[K-1: 0] + cin;
// lazy_inc predict hi N-K-1 bits of counters, but calculate it in N-K ticks, and use not offten than every 2^k ticks.
reg [N: K] lazy_inc;
wire [N: K] lazy_inc_n;
assign lazy_inc_n[N: K] = {1'b0, counter[N-1: K]} ^ {(counter[N-1: K] & ~lazy_inc[N-1: K]), 1'b1};

always @(posedge clk) begin
    counter[K-1: 0] <= lo_count[K-1: 0];
    counter[N-1: K] <= lo_count[K] ? lazy_inc[N-1: K] : counter[N-1: K];
    cout <= lo_count[K] ? lazy_inc[N] : 1'b0;

    lazy_inc[N: K] <= lazy_inc_n;
    if (!nrst) begin
        counter <= '0;
        cout <= '0;
        lazy_inc <= '0;
    end
end

endmodule