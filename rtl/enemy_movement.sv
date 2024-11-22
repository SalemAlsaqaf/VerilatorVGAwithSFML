`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2024 05:37:25 PM
// Design Name: 
// Module Name: drawing_logic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: This module is pipelined at stage 2,
//                      not that it matters, due to abstraction.
// 
//////////////////////////////////////////////////////////////////////////////////

`ifdef VERILATOR
`include "rtl/params.sv"
`endif

module enemy_movement #(
    parameter INITIAL_MEM_FILE = "NONE",
    localparam H_MAP_WIDTH = params::pacman::H_VISIBLE_AREA,
    localparam V_MAP_HEIGHT = params::pacman::V_VISIBLE_AREA
) (
    input logic vga_pix_clk,
    input logic rst,
    input logic frame_stb,  // 1 stage pipeline
    input logic [8:0] x_pac,
    input logic [8:0] y_pac,
    output logic [8:0] x_red,
    output logic [8:0] y_red,
    output logic [8:0] x_blue,
    output logic [8:0] y_blue,
    output logic [8:0] x_yellow,
    output logic [8:0] y_yellow,
    output logic [8:0] x_pink,
    output logic [8:0] y_pink
);

  logic CLK60HZ;
  assign CLK60HZ = frame_stb;

  ///////////////////////
  // MAP DRAWING LOGIC //
  ///////////////////////
  // TODO: Optimize this, MAP can be 1 bit wide. We only check MAP[3].
  logic [3:0] MAP[0:32*36-1];
  initial begin
    $display("Loading MAP from init file '%s'.", INITIAL_MEM_FILE);
    $readmemb(INITIAL_MEM_FILE, MAP);
  end


  // will hit if kept moving up...
  logic [3:0] MAP_UP_RED;
  logic [3:0] MAP_DOWN_RED;
  logic [3:0] MAP_RIGHT_RED;
  logic [3:0] MAP_LEFT_RED;

  always_comb begin
    MAP_UP_RED    = MAP[x_red/8+((y_red-1)/8)*32] ;
    MAP_DOWN_RED  = MAP[x_red/8+((y_red)/8)*32+32];
    MAP_RIGHT_RED = MAP[(x_red)/8 + 1+(y_red/8)*32];
    MAP_LEFT_RED  = MAP[(x_red-1)/8+(y_red/8)*32];
  end

  always_ff @(posedge vga_pix_clk) begin
    if (rst) begin
      x_red    <= 8 * 15;
      y_red    <= 8 * (4 + 10);
      x_blue   <= 8 * 14;
      y_blue   <= 8 * (4 + 13);
      x_yellow <= 8 * 1;
      y_yellow <= 8 * (4 + 13);
      x_pink   <= 8 * 16;
      y_pink   <= 8 * (4 + 13);
    end
  end


  // Yes, I like to align my = signs, but the auto formatter doesn't agree with my style...
  // verilog_format: off
  logic x_red_aligned          = x_red    [2:0] == '0;
  logic y_red_aligned          = y_red    [2:0] == '0;
  logic x_blue_aligned         = x_blue   [2:0] == '0;
  logic y_blue_aligned         = y_blue   [2:0] == '0;
  logic x_yellow_aligned       = x_yellow [2:0] == '0;
  logic y_yellow_aligned       = y_yellow [2:0] == '0;
  logic x_pink_aligned         = x_pink   [2:0] == '0;
  logic y_pink_aligned         = y_pink   [2:0] == '0;
  // verilog_format: on


  typedef enum {
    UP,
    RIGHT,
    LEFT,
    DOWN
  } direction_t;


endmodule : enemy_movement