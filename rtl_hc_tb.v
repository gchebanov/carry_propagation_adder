`default_nettype none
`timescale 1ns/1ns

module rtl_hc_tb #(parameter N = 64 );

reg clk;
initial clk = 0;
always #1 clk = ~clk;

reg [N-1:0] a;
reg [N-1:0] b;
wire [N-1:0] y;

rtl_hc rtl (clk, a, b, y);

initial begin
    a <= 64'h17705351ef640b95;
    b <= 64'h4d4efe8b5d14f84f;
    #10;
    $display("a=0x%0h b=0x%0h y=0x%0h", a, b, y);
    a <= '0;
    b <= '0;
    #10;
    $display("a=0x%0h b=0x%0h y=0x%0h", a, b, y);
    a <= '1;
    b <= '1;
    #10;
    $display("a=0x%0h b=0x%0h y=0x%0h", a, b, y);
    $finish;
end

endmodule
