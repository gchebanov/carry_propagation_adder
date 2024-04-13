`default_nettype none
`timescale 1ns/1ns

module cnt_tb #(parameter N=17);

reg clk;
initial clk = 0;
always #1 clk = ~clk;
reg nreset;
reg cin;

reg [N-1: 0] cnt, i_cnt;
reg cout, i_cout;

rtl_cnt #(N) internal (clk, nreset, cin, cnt, cout);
//rtl_cnt_p #(N) rtl (clk, nreset, cin, i_cnt, i_cout);
//rtl_cnt_l #(N) rtl (clk, nreset, cin, i_cnt, i_cout);
//rtl_cnt_lp #(N) rtl (clk, nreset, cin, i_cnt, i_cout);
rtl_cnt_bk #(N) rtl (clk, nreset, cin, i_cnt, i_cout);

initial begin
    nreset <= 0;
    cin <= 0;
    #6
    nreset <= 1;
    #2
    for (integer step = 0; step < 1000000; step = step + 1) begin
        #2
        cin <= (step % 3 == 0 || step % 19 == 0);
        if (cout) begin
            $display("(%08t) y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", $time, cnt, i_cnt, cout, i_cout);
        end
        if (cnt == i_cnt && cout == i_cout) ; else begin
            $error("(%08t) y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", $time, cnt, i_cnt, cout, i_cout);
            $finish;
        end
    end
    $display("(%08t) y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", $time, cnt, i_cnt, cout, i_cout);
    $finish;
end

endmodule
