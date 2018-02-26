/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Dec 13 17:07:08 2017
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


module acceptance_filter ( clk, n_rst, enable, rxd, crc_calculated, correct );
  input [14:0] crc_calculated;
  input clk, n_rst, enable, rxd;
  output correct;
  wire   N4, N5, N6, correct1, tracking, correctph, N15, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53;
  wire   [3:0] count_out;

  DFFSR tracking_reg ( .D(n52), .CLK(clk), .R(n_rst), .S(1'b1), .Q(tracking)
         );
  DFFSR correct1_reg ( .D(correctph), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        correct1) );
  flex_counter FLEX_COUNTER ( .clk(clk), .n_rst(n_rst), .clear(n53), 
        .count_enable(enable), .rollover_val({1'b1, 1'b1, 1'b1, 1'b0}), 
        .count_out({count_out[3:1], N4}) );
  XOR2X1 U21 ( .A(count_out[3]), .B(n49), .Y(n15) );
  NOR2X1 U22 ( .A(n38), .B(N4), .Y(n17) );
  NOR2X1 U23 ( .A(N4), .B(N5), .Y(n22) );
  NAND2X1 U24 ( .A(N4), .B(n38), .Y(n28) );
  AOI22X1 U25 ( .A(crc_calculated[12]), .B(n22), .C(crc_calculated[13]), .D(
        n41), .Y(n16) );
  OAI21X1 U26 ( .A(n39), .B(n36), .C(n16), .Y(n21) );
  AOI22X1 U27 ( .A(crc_calculated[9]), .B(n41), .C(crc_calculated[10]), .D(n17), .Y(n19) );
  NAND2X1 U28 ( .A(N4), .B(N5), .Y(n25) );
  AOI22X1 U29 ( .A(crc_calculated[11]), .B(n42), .C(crc_calculated[8]), .D(n22), .Y(n18) );
  NAND2X1 U30 ( .A(n19), .B(n18), .Y(n20) );
  AOI22X1 U31 ( .A(N6), .B(n21), .C(n20), .D(n37), .Y(n35) );
  NOR2X1 U32 ( .A(crc_calculated[7]), .B(n25), .Y(n23) );
  NOR2X1 U33 ( .A(n37), .B(n23), .Y(n24) );
  OAI21X1 U34 ( .A(crc_calculated[4]), .B(n40), .C(n24), .Y(n32) );
  OAI22X1 U35 ( .A(crc_calculated[6]), .B(n39), .C(crc_calculated[5]), .D(n28), 
        .Y(n31) );
  NOR2X1 U36 ( .A(crc_calculated[3]), .B(n25), .Y(n26) );
  NOR2X1 U37 ( .A(N6), .B(n26), .Y(n27) );
  OAI21X1 U38 ( .A(crc_calculated[0]), .B(n40), .C(n27), .Y(n30) );
  OAI22X1 U39 ( .A(crc_calculated[2]), .B(n39), .C(crc_calculated[1]), .D(n28), 
        .Y(n29) );
  OAI22X1 U40 ( .A(n32), .B(n31), .C(n30), .D(n29), .Y(n33) );
  NAND2X1 U41 ( .A(n33), .B(n15), .Y(n34) );
  OAI21X1 U42 ( .A(n35), .B(n15), .C(n34), .Y(N15) );
  INVX2 U43 ( .A(crc_calculated[14]), .Y(n36) );
  INVX2 U44 ( .A(N6), .Y(n37) );
  INVX2 U45 ( .A(N5), .Y(n38) );
  INVX2 U46 ( .A(n17), .Y(n39) );
  INVX2 U47 ( .A(n22), .Y(n40) );
  INVX2 U48 ( .A(n28), .Y(n41) );
  INVX2 U49 ( .A(n25), .Y(n42) );
  AOI21X1 U50 ( .A(n43), .B(n44), .C(n53), .Y(n52) );
  INVX1 U51 ( .A(tracking), .Y(n44) );
  XNOR2X1 U52 ( .A(N15), .B(rxd), .Y(n43) );
  INVX1 U53 ( .A(enable), .Y(n53) );
  AOI21X1 U54 ( .A(n45), .B(enable), .C(tracking), .Y(correctph) );
  XOR2X1 U55 ( .A(rxd), .B(N15), .Y(n45) );
  NOR2X1 U56 ( .A(n46), .B(n47), .Y(correct) );
  NAND2X1 U57 ( .A(count_out[3]), .B(count_out[2]), .Y(n47) );
  NAND3X1 U58 ( .A(correct1), .B(n48), .C(count_out[1]), .Y(n46) );
  INVX1 U59 ( .A(N4), .Y(n48) );
  NOR2X1 U60 ( .A(n50), .B(n51), .Y(n49) );
  XNOR2X1 U61 ( .A(n51), .B(n50), .Y(N6) );
  INVX1 U62 ( .A(count_out[2]), .Y(n50) );
  OAI21X1 U63 ( .A(count_out[1]), .B(N4), .C(n51), .Y(N5) );
  NAND2X1 U64 ( .A(N4), .B(count_out[1]), .Y(n51) );
endmodule

