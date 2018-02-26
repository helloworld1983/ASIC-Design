/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Dec 13 17:10:30 2017
/////////////////////////////////////////////////////////////


module can_crc ( data, crc_en, clk, n_rst, crc_out );
  output [14:0] crc_out;
  input data, crc_en, clk, n_rst;
  wire   n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42, n44,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61;

  DFFSR \crc_out_reg[0]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[0]) );
  DFFSR \crc_out_reg[1]  ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[1]) );
  DFFSR \crc_out_reg[2]  ( .D(n42), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[2]) );
  DFFSR \crc_out_reg[3]  ( .D(n40), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[3]) );
  DFFSR \crc_out_reg[4]  ( .D(n38), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[4]) );
  DFFSR \crc_out_reg[5]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[5]) );
  DFFSR \crc_out_reg[6]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[6]) );
  DFFSR \crc_out_reg[7]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[7]) );
  DFFSR \crc_out_reg[8]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[8]) );
  DFFSR \crc_out_reg[9]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[9]) );
  DFFSR \crc_out_reg[10]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[10]) );
  DFFSR \crc_out_reg[11]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[11]) );
  DFFSR \crc_out_reg[12]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[12]) );
  DFFSR \crc_out_reg[13]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[13]) );
  DFFSR \crc_out_reg[14]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        crc_out[14]) );
  MUX2X1 U48 ( .B(n47), .A(data), .S(crc_en), .Y(n46) );
  INVX1 U49 ( .A(crc_out[0]), .Y(n47) );
  INVX1 U50 ( .A(n48), .Y(n44) );
  MUX2X1 U51 ( .B(crc_out[1]), .A(crc_out[0]), .S(crc_en), .Y(n48) );
  INVX1 U52 ( .A(n49), .Y(n42) );
  MUX2X1 U53 ( .B(crc_out[2]), .A(crc_out[1]), .S(crc_en), .Y(n49) );
  MUX2X1 U54 ( .B(n50), .A(crc_out[2]), .S(crc_en), .Y(n40) );
  INVX1 U55 ( .A(crc_out[3]), .Y(n50) );
  MUX2X1 U56 ( .B(n51), .A(crc_out[3]), .S(crc_en), .Y(n38) );
  INVX1 U57 ( .A(crc_out[4]), .Y(n51) );
  INVX1 U58 ( .A(n52), .Y(n36) );
  MUX2X1 U59 ( .B(crc_out[5]), .A(crc_out[4]), .S(crc_en), .Y(n52) );
  INVX1 U60 ( .A(n53), .Y(n34) );
  MUX2X1 U61 ( .B(crc_out[6]), .A(crc_out[5]), .S(crc_en), .Y(n53) );
  MUX2X1 U62 ( .B(n54), .A(crc_out[6]), .S(crc_en), .Y(n32) );
  INVX1 U63 ( .A(n55), .Y(n30) );
  MUX2X1 U64 ( .B(crc_out[8]), .A(n54), .S(crc_en), .Y(n55) );
  INVX1 U65 ( .A(crc_out[7]), .Y(n54) );
  INVX1 U66 ( .A(n56), .Y(n28) );
  MUX2X1 U67 ( .B(crc_out[9]), .A(crc_out[8]), .S(crc_en), .Y(n56) );
  MUX2X1 U68 ( .B(n57), .A(crc_out[9]), .S(crc_en), .Y(n26) );
  MUX2X1 U69 ( .B(n58), .A(n57), .S(crc_en), .Y(n24) );
  INVX1 U70 ( .A(crc_out[10]), .Y(n57) );
  INVX1 U71 ( .A(crc_out[11]), .Y(n58) );
  INVX1 U72 ( .A(n59), .Y(n22) );
  MUX2X1 U73 ( .B(crc_out[12]), .A(crc_out[11]), .S(crc_en), .Y(n59) );
  INVX1 U74 ( .A(n60), .Y(n20) );
  MUX2X1 U75 ( .B(crc_out[13]), .A(crc_out[12]), .S(crc_en), .Y(n60) );
  MUX2X1 U76 ( .B(n61), .A(crc_out[13]), .S(crc_en), .Y(n18) );
  INVX1 U77 ( .A(crc_out[14]), .Y(n61) );
endmodule

