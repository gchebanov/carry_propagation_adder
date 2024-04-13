module rtl_cnt_bk #(
    parameter N = 64
) (
    input wire clk,
    input wire nrst,
    input wire cin,
    output reg [N-1: 0] counter,
    output reg cout
);

wire [N: 0] g = {counter & cin, 1'b0};
wire [N-1: 0] p = counter | cin;
wire [N: 0] c;

brent_kung #(N) impl(g, p, c);

always @(posedge clk) begin
    {cout, counter} <= {counter ^ c ^ cin};
    if (!nrst) begin
        {cout, counter} <= '0;
    end
end

endmodule
