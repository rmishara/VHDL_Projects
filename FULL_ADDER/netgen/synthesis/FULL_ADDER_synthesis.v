////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: FULL_ADDER_synthesis.v
// /___/   /\     Timestamp: Thu Jun 30 16:55:03 2022
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim FULL_ADDER.ngc FULL_ADDER_synthesis.v 
// Device	: xc6slx45-3-csg484
// Input file	: FULL_ADDER.ngc
// Output file	: E:\Xilinx projects\FULL_ADDER\netgen\synthesis\FULL_ADDER_synthesis.v
// # of Modules	: 1
// Design Name	: FULL_ADDER
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module FULL_ADDER (
  A, B, Cin, S, Cout
);
  input A;
  input B;
  input Cin;
  output S;
  output Cout;
  wire A_IBUF_0;
  wire B_IBUF_1;
  wire Cin_IBUF_2;
  wire Cout_OBUF_3;
  wire S_OBUF_4;
  LUT3 #(
    .INIT ( 8'hE8 ))
  Cout1 (
    .I0(B_IBUF_1),
    .I1(Cin_IBUF_2),
    .I2(A_IBUF_0),
    .O(Cout_OBUF_3)
  );
  LUT3 #(
    .INIT ( 8'h96 ))
  S1 (
    .I0(Cin_IBUF_2),
    .I1(A_IBUF_0),
    .I2(B_IBUF_1),
    .O(S_OBUF_4)
  );
  IBUF   A_IBUF (
    .I(A),
    .O(A_IBUF_0)
  );
  IBUF   B_IBUF (
    .I(B),
    .O(B_IBUF_1)
  );
  IBUF   Cin_IBUF (
    .I(Cin),
    .O(Cin_IBUF_2)
  );
  OBUF   S_OBUF (
    .I(S_OBUF_4),
    .O(S)
  );
  OBUF   Cout_OBUF (
    .I(Cout_OBUF_3),
    .O(Cout)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

