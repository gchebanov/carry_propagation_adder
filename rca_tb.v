`default_nettype none
`timescale 1ns/1ns

module rca_tb #(parameter N=32);

reg [N-1:0] a;
reg [N-1:0] b;
reg cin;
wire [N-1:0] y;
wire [N-1:0] i_y;
wire cout;
wire i_cout;

cla #(N) cpa (a, b, cin, y, cout);
internal #(N) internal (a, b, cin, i_y, i_cout);

reg [N-1:0] t;

initial begin
    $monitor("(%03t) a=0x%0h b=0x%0h cin=0x%0h y=0x%0h cout=0x%0h", $time, a, b, cin, y, cout);
    a <= 0; b <= 0; cin <= 0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    a <= $random; b <= $random; cin <= 0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    a <= $random; b <= $random; cin <= 1;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    a <= $random; b <= $random; cin <= 0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    a <= $random; b <= $random; cin <= 1;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    t = $random;
    a <= t; b <= ~t; cin <= 1;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    t = $random;
    a <= t; b <= ~t+1; cin <= 0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
end

endmodule