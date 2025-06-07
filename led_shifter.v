module LedShifter #(
    parameter CLK_FREQ = 25_000_000  // Usado também para simulação
) (
    input  wire clk,
    input  wire rst_n,
    output reg [7:0] leds
);

    // Para testes: realizar deslocamento a cada CLK_FREQ / 4
    localparam SHIFT_PERIOD = CLK_FREQ / 4;

    reg [$clog2(SHIFT_PERIOD)-1:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            leds    <= 8'b0001_1111; // 0x1F
            counter <= 0;
        end else begin
            if (counter == SHIFT_PERIOD - 1) begin
                leds <= {leds[6:0], leds[7]}; // Shift circular esquerda
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
