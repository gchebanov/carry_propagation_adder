module rtl_cnt_p #(
    parameter N = 64
) (
    input wire clk,
    input wire nrst,
    input wire cin,
    output reg [N-1: 0] counter,
    output reg cout
);

localparam B = 8;
localparam M = (N + B - 1) / B;

wire [M-1: 0] i_cin;
reg [M-1: 0][B-1: 0] i_counter;
reg [M-1: 0] i_cout;
reg [M-1: 0] last;

genvar i;
generate
    for (i = 0; i < M; i = i + 1) begin
        assign counter[(i*B+B<N?i*B+B:N)-1: i*B] = i_counter[i];
        if (i == 0) begin
            assign i_cin[i] = cin;
            always @(posedge clk) last[i] <= &(i_counter[i] + cin);
        end else begin
            assign i_cin[i] = cin & (&last[i-1:0]);
            if (i + 1 == M && N % B != 0) begin
                always @(posedge clk) last[i] <= &i_counter[i][N%B-1: 0];
            end else begin
                always @(posedge clk) last[i] <= &i_counter[i];
            end
        end
        rtl_cnt #(B) cnt (
            clk, nrst, i_cin[i], i_counter[i], i_cout[i]
        );
    end
endgenerate

always @(posedge clk) cout <= cin & (&last);

endmodule