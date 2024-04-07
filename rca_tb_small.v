module rca_tb #(parameter N=3);

reg [N-1:0] a;
reg [N-1:0] b;
reg cin;
wire [N-1:0] y;
wire [N-1:0] i_y;
wire cout;
wire i_cout;

cla #(N) cpa (a, b, cin, y, cout);
internal #(N) internal (a, b, cin, i_y, i_cout);

initial begin
    a <= 0; b <= 0; cin <= 0;
    $monitor("(%03t) a=0x%0h b=0x%0h cin=0x%0h y=0x%0h cout=0x%0h", $time, a, b, cin, y, cout);
    a <= 'h2; b <= 'h3; cin <= 'h0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    b <= 'h4; cin <= 'h1;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    a <= 'h5;           cin <= 'h0;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
    cin <= 'h1;
    #10
    if (y == i_y && cout == i_cout) ; else begin
        $error("y=0x%0h i_y=0x%0h cout=0x%0h i_cout=0x%0h", y, i_y, cout, i_cout);
    end
end

endmodule