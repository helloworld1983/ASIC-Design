/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Dec 13 16:58:22 2017
/////////////////////////////////////////////////////////////


module AHB_Slave ( HCLK, HRESETn, HWRITE, HSEL, HADDR, HWDATA, HTRANS, HBURST, 
        HSIZE, HRDATA, HRESP, HREADYOUT, sensor_data, slave_wait, command_data, 
        address, renable, wenable, data_size, burst_size );
  input [31:0] HADDR;
  input [31:0] HWDATA;
  input [1:0] HTRANS;
  input [2:0] HBURST;
  input [2:0] HSIZE;
  output [31:0] HRDATA;
  input [31:0] sensor_data;
  output [15:0] command_data;
  output [15:0] address;
  output [2:0] data_size;
  output [2:0] burst_size;
  input HCLK, HRESETn, HWRITE, HSEL, slave_wait;
  output HRESP, HREADYOUT, renable, wenable;
  wire   N81, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89;
  wire   [2:0] state;
  wire   [2:0] next_state;
  assign HRDATA[31] = sensor_data[31];
  assign HRDATA[30] = sensor_data[30];
  assign HRDATA[29] = sensor_data[29];
  assign HRDATA[28] = sensor_data[28];
  assign HRDATA[27] = sensor_data[27];
  assign HRDATA[26] = sensor_data[26];
  assign HRDATA[25] = sensor_data[25];
  assign HRDATA[24] = sensor_data[24];
  assign HRDATA[23] = sensor_data[23];
  assign HRDATA[22] = sensor_data[22];
  assign HRDATA[21] = sensor_data[21];
  assign HRDATA[20] = sensor_data[20];
  assign HRDATA[19] = sensor_data[19];
  assign HRDATA[18] = sensor_data[18];
  assign HRDATA[17] = sensor_data[17];
  assign HRDATA[16] = sensor_data[16];
  assign HRDATA[15] = sensor_data[15];
  assign HRDATA[14] = sensor_data[14];
  assign HRDATA[13] = sensor_data[13];
  assign HRDATA[12] = sensor_data[12];
  assign HRDATA[11] = sensor_data[11];
  assign HRDATA[10] = sensor_data[10];
  assign HRDATA[9] = sensor_data[9];
  assign HRDATA[8] = sensor_data[8];
  assign HRDATA[7] = sensor_data[7];
  assign HRDATA[6] = sensor_data[6];
  assign HRDATA[5] = sensor_data[5];
  assign HRDATA[4] = sensor_data[4];
  assign HRDATA[3] = sensor_data[3];
  assign HRDATA[2] = sensor_data[2];
  assign HRDATA[1] = sensor_data[1];
  assign HRDATA[0] = sensor_data[0];
  assign command_data[15] = HWDATA[15];
  assign command_data[14] = HWDATA[14];
  assign command_data[13] = HWDATA[13];
  assign command_data[12] = HWDATA[12];
  assign command_data[11] = HWDATA[11];
  assign command_data[10] = HWDATA[10];
  assign command_data[9] = HWDATA[9];
  assign command_data[8] = HWDATA[8];
  assign command_data[7] = HWDATA[7];
  assign command_data[6] = HWDATA[6];
  assign command_data[5] = HWDATA[5];
  assign command_data[4] = HWDATA[4];
  assign command_data[3] = HWDATA[3];
  assign command_data[2] = HWDATA[2];
  assign command_data[1] = HWDATA[1];
  assign command_data[0] = HWDATA[0];
  assign address[15] = HADDR[31];
  assign address[14] = HADDR[14];
  assign address[13] = HADDR[13];
  assign address[12] = HADDR[12];
  assign address[11] = HADDR[11];
  assign address[10] = HADDR[10];
  assign address[9] = HADDR[9];
  assign address[8] = HADDR[8];
  assign address[7] = HADDR[7];
  assign address[6] = HADDR[6];
  assign address[5] = HADDR[5];
  assign address[4] = HADDR[4];
  assign address[3] = HADDR[3];
  assign address[2] = HADDR[2];
  assign address[1] = HADDR[1];
  assign address[0] = HADDR[0];
  assign data_size[2] = HSIZE[2];
  assign data_size[1] = HSIZE[1];
  assign data_size[0] = HSIZE[0];
  assign burst_size[2] = HBURST[2];
  assign burst_size[1] = HBURST[1];
  assign burst_size[0] = HBURST[0];
  assign HRESP = N81;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[1]) );
  NOR2X1 U56 ( .A(n53), .B(n54), .Y(wenable) );
  NOR2X1 U57 ( .A(n53), .B(n55), .Y(renable) );
  OAI22X1 U58 ( .A(n56), .B(n57), .C(n58), .D(n59), .Y(next_state[2]) );
  OR2X1 U59 ( .A(n60), .B(n61), .Y(next_state[1]) );
  OAI21X1 U60 ( .A(n62), .B(n63), .C(n64), .Y(n61) );
  INVX1 U61 ( .A(HWRITE), .Y(n63) );
  OAI22X1 U62 ( .A(n65), .B(n54), .C(n56), .D(n66), .Y(n60) );
  OR2X1 U63 ( .A(n67), .B(n68), .Y(next_state[0]) );
  OAI21X1 U64 ( .A(HWRITE), .B(n62), .C(n64), .Y(n68) );
  INVX1 U65 ( .A(n69), .Y(n64) );
  OAI21X1 U66 ( .A(n70), .B(n71), .C(n72), .Y(n69) );
  OAI21X1 U67 ( .A(n73), .B(n74), .C(n75), .Y(n72) );
  NAND3X1 U68 ( .A(n76), .B(n77), .C(n78), .Y(n74) );
  NOR2X1 U69 ( .A(address[11]), .B(address[10]), .Y(n78) );
  INVX1 U70 ( .A(address[12]), .Y(n77) );
  NOR2X1 U71 ( .A(address[14]), .B(address[13]), .Y(n76) );
  NAND3X1 U72 ( .A(n79), .B(n80), .C(n81), .Y(n73) );
  NOR2X1 U73 ( .A(address[6]), .B(address[5]), .Y(n81) );
  INVX1 U74 ( .A(address[7]), .Y(n80) );
  NOR2X1 U75 ( .A(address[9]), .B(address[8]), .Y(n79) );
  INVX1 U76 ( .A(n75), .Y(n62) );
  OAI21X1 U77 ( .A(n82), .B(n83), .C(n71), .Y(n75) );
  NAND3X1 U78 ( .A(n58), .B(n59), .C(HSEL), .Y(n71) );
  AND2X1 U79 ( .A(n55), .B(n54), .Y(n82) );
  OAI22X1 U80 ( .A(n65), .B(n55), .C(n59), .D(n66), .Y(n67) );
  NAND3X1 U81 ( .A(n55), .B(n54), .C(n84), .Y(n66) );
  NAND3X1 U82 ( .A(n59), .B(n57), .C(state[1]), .Y(n54) );
  NAND2X1 U83 ( .A(state[0]), .B(n58), .Y(n55) );
  NOR2X1 U84 ( .A(state[2]), .B(state[1]), .Y(n58) );
  INVX1 U85 ( .A(n85), .Y(n65) );
  OAI21X1 U86 ( .A(n70), .B(n83), .C(n86), .Y(n85) );
  NAND2X1 U87 ( .A(HSEL), .B(n86), .Y(n83) );
  INVX1 U88 ( .A(n53), .Y(n86) );
  NOR2X1 U89 ( .A(n87), .B(HTRANS[1]), .Y(n53) );
  AND2X1 U90 ( .A(HTRANS[1]), .B(n87), .Y(n70) );
  INVX1 U91 ( .A(HTRANS[0]), .Y(n87) );
  NOR2X1 U92 ( .A(slave_wait), .B(N81), .Y(HREADYOUT) );
  INVX1 U93 ( .A(n84), .Y(N81) );
  MUX2X1 U94 ( .B(n88), .A(n89), .S(n56), .Y(n84) );
  INVX1 U95 ( .A(state[1]), .Y(n56) );
  NOR2X1 U96 ( .A(state[0]), .B(n57), .Y(n89) );
  INVX1 U97 ( .A(state[2]), .Y(n57) );
  NOR2X1 U98 ( .A(state[2]), .B(n59), .Y(n88) );
  INVX1 U99 ( .A(state[0]), .Y(n59) );
endmodule

