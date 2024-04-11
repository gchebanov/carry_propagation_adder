module rtl_cnt #(
    parameter N = 64
) (
    input wire clk,
    input wire nrst,
    input wire cin,
    output reg [N-1: 0] counter,
    output reg cout
);

always @(posedge clk) begin
    counter <= counter + cin;
    cout <= &{counter, cin};
    if (!nrst) begin
        counter <= '0;
        cout <= '0;
    end
end

endmodule