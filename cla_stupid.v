module cla_stupid #(
    parameter N = 2
) (
    input wire [N: 0] g,
    input wire [N: 1] p,
    output wire [N: 0] c
);

wire [N: 0][N: 0] a;

genvar i, j;
generate
    for (i = 0; i <= N; i = i + 1) begin
        assign a[i][i] = g[i];
        for (j = i - 1; j >= 0; j = j - 1) begin
            assign a[j][i] = a[j + 1][i] | (&p[i: j+1] & g[j]);
        end
    end
endgenerate

assign c = a[0];

endmodule
