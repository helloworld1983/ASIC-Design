/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Dec 13 17:02:53 2017
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   temp_rollover_flag, n1, n2, n3, n4, n5, n6, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;
  wire   [3:0] temp_count_out;

  DFFSR \count_out_reg[0]  ( .D(temp_count_out[0]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(temp_count_out[1]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(count_out[1]) );
  DFFSR \count_out_reg[3]  ( .D(temp_count_out[3]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(count_out[3]) );
  DFFSR \count_out_reg[2]  ( .D(temp_count_out[2]), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(count_out[2]) );
  DFFSR rollover_flag_reg ( .D(temp_rollover_flag), .CLK(clk), .R(n_rst), .S(
        1'b1), .Q(rollover_flag) );
  NOR2X1 U8 ( .A(n1), .B(n2), .Y(temp_rollover_flag) );
  NAND2X1 U9 ( .A(n3), .B(n4), .Y(n2) );
  XNOR2X1 U10 ( .A(rollover_val[1]), .B(temp_count_out[1]), .Y(n4) );
  XNOR2X1 U11 ( .A(rollover_val[2]), .B(temp_count_out[2]), .Y(n3) );
  NAND3X1 U12 ( .A(n5), .B(n6), .C(n12), .Y(n1) );
  XNOR2X1 U13 ( .A(rollover_val[0]), .B(temp_count_out[0]), .Y(n12) );
  XNOR2X1 U14 ( .A(rollover_val[3]), .B(temp_count_out[3]), .Y(n5) );
  OAI22X1 U15 ( .A(n13), .B(n14), .C(n15), .D(n16), .Y(temp_count_out[3]) );
  OAI22X1 U16 ( .A(n17), .B(n14), .C(n15), .D(n18), .Y(temp_count_out[2]) );
  OAI22X1 U17 ( .A(n19), .B(n14), .C(n15), .D(n20), .Y(temp_count_out[1]) );
  NAND3X1 U18 ( .A(n21), .B(n6), .C(count_enable), .Y(n14) );
  INVX1 U19 ( .A(n22), .Y(n21) );
  OAI22X1 U20 ( .A(n15), .B(n23), .C(n24), .D(n25), .Y(temp_count_out[0]) );
  OAI21X1 U21 ( .A(n23), .B(n22), .C(n6), .Y(n25) );
  OAI22X1 U22 ( .A(n26), .B(n27), .C(rollover_val[3]), .D(n13), .Y(n22) );
  OAI21X1 U23 ( .A(n28), .B(n29), .C(n30), .Y(n27) );
  OAI21X1 U24 ( .A(n17), .B(n31), .C(rollover_val[2]), .Y(n30) );
  INVX1 U25 ( .A(n17), .Y(n29) );
  XOR2X1 U26 ( .A(n32), .B(count_out[2]), .Y(n17) );
  INVX1 U27 ( .A(n31), .Y(n28) );
  OAI21X1 U28 ( .A(n33), .B(n34), .C(n35), .Y(n31) );
  OAI21X1 U29 ( .A(n19), .B(n36), .C(rollover_val[1]), .Y(n35) );
  INVX1 U30 ( .A(n33), .Y(n36) );
  INVX1 U31 ( .A(n34), .Y(n19) );
  XNOR2X1 U32 ( .A(n20), .B(count_out[0]), .Y(n34) );
  INVX1 U33 ( .A(count_out[1]), .Y(n20) );
  NOR2X1 U34 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n33) );
  AND2X1 U35 ( .A(n13), .B(rollover_val[3]), .Y(n26) );
  XOR2X1 U36 ( .A(n16), .B(n37), .Y(n13) );
  NOR2X1 U37 ( .A(n32), .B(n18), .Y(n37) );
  INVX1 U38 ( .A(count_out[2]), .Y(n18) );
  NAND2X1 U39 ( .A(count_out[1]), .B(count_out[0]), .Y(n32) );
  INVX1 U40 ( .A(count_out[3]), .Y(n16) );
  INVX1 U41 ( .A(count_out[0]), .Y(n23) );
  NAND2X1 U42 ( .A(n6), .B(n24), .Y(n15) );
  INVX1 U43 ( .A(count_enable), .Y(n24) );
  INVX1 U44 ( .A(clear), .Y(n6) );
endmodule


module arbitration ( clk, n_rst, rxd, arbitration_start, win, loose );
  input clk, n_rst, rxd, arbitration_start;
  output win, loose;
  wire   tracking, count_enable, N65, n22, n24, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42;
  wire   [3:0] count_out;

  flex_counter FLEX_COUNTER ( .clk(clk), .n_rst(n_rst), .clear(n26), 
        .count_enable(count_enable), .rollover_val({1'b1, 1'b0, 1'b1, 1'b0}), 
        .count_out({count_out[3:1], N65}) );
  DFFSR tracking_reg ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(tracking)
         );
  DFFSR win_reg ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(win) );
  DFFSR loose_reg ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(loose) );
  AOI21X1 U26 ( .A(n27), .B(n28), .C(n29), .Y(n26) );
  INVX1 U27 ( .A(tracking), .Y(n28) );
  XNOR2X1 U28 ( .A(rxd), .B(n30), .Y(n27) );
  OAI21X1 U29 ( .A(n31), .B(n32), .C(n33), .Y(n24) );
  NAND2X1 U30 ( .A(win), .B(n34), .Y(n33) );
  OR2X1 U31 ( .A(n30), .B(n35), .Y(n32) );
  OAI21X1 U32 ( .A(n31), .B(n36), .C(n37), .Y(n22) );
  NAND2X1 U33 ( .A(loose), .B(n34), .Y(n37) );
  NAND2X1 U34 ( .A(tracking), .B(arbitration_start), .Y(n34) );
  NAND2X1 U35 ( .A(n30), .B(n35), .Y(n36) );
  INVX1 U36 ( .A(rxd), .Y(n35) );
  OAI21X1 U37 ( .A(n38), .B(n39), .C(n40), .Y(n30) );
  OAI21X1 U38 ( .A(count_out[2]), .B(n41), .C(n42), .Y(n40) );
  INVX1 U39 ( .A(N65), .Y(n42) );
  INVX1 U40 ( .A(n38), .Y(n41) );
  INVX1 U41 ( .A(count_out[1]), .Y(n39) );
  XOR2X1 U42 ( .A(N65), .B(count_out[3]), .Y(n38) );
  INVX1 U43 ( .A(count_enable), .Y(n31) );
  NOR2X1 U44 ( .A(n29), .B(tracking), .Y(count_enable) );
  INVX1 U45 ( .A(arbitration_start), .Y(n29) );
endmodule

