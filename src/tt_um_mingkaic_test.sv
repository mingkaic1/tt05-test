`default_nettype none

module tt_um_mingkaic_test (
    input  logic [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output logic [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  logic [7:0] uio_in,   // IOs: Bidirectional Input path
    output logic [7:0] uio_out,  // IOs: Bidirectional Output path
    output logic [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  logic       ena,      // will go high when the design is enabled
    input  logic       clk,      // clock
    input  logic       rst_n     // reset_n - low to reset
);

    localparam ADD = 2'd0;
    localparam SUB = 2'd1;
    localparam OR  = 2'd2;
    localparam XOR = 2'd3;

    // Aliases
    logic [8:0] in, out;
    logic [1:0] op;
    assign in = ui_in;
    assign uio_out = out;
    assign op = uio_in[1:0];

    // Configure bidirectional pins
    assign uio_oe = 8'b0000_0000;  // All inputs

    always_ff @ (posedge clk) begin
        if (~rst_n) begin
            out <= 8'd0;
        end
        else begin
            case (op)
                ADD: out <= out + in;
                SUB: out <= out - in;
                OR:  out <= out | in;
                XOR: out <= out ^ in;
            endcase
        end
    end

endmodule: tt_um_mingkaic_test
