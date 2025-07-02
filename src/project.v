/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_asiclab_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal register to store result
  reg [7:0] result;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result <= 8'b0;
    end else if (ui_in[1]) begin
      result <= 8'b0;  // Manual reset via ui_in[1]
    end else if (ui_in[0]) begin
      result <= ui_in + uio_in;  // Add when ui_in[0] is high
    end
  end

  assign uo_out   = result;
  assign uio_out  = result;
  assign uio_oe   = 8'hFF;  // Enable all uio_out bits

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
