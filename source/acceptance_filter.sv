// $Id: $
// File name:   arbitration.sv
// Created:     12/1/2017
// Author:      Sang Hun Kim
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: arbitration

`timescale 1ns / 10ps

module acceptance_filter
  (
   input wire 	clk,
   input wire 	n_rst,
   input wire 	enable,
   input wire 	rxd ,
   input [14:0] crc_calculated,
   output wire 	correct  
   );

   //Variables for FLEX_COUNTER to 10
   reg 		     clear;
   reg     count_enable;
   reg 	[3:0]	     count_out;
   reg 		     rollover_flag;

   reg 		     tracking;
   

 
//FLEX COUNTER UPTO 15 FOR EACH CALCULATED CRC BITS
   flex_counter FLEX_COUNTER 
   (
    .clk(clk),
    .n_rst(n_rst),
    .clear(clear),
    .count_enable(count_enable),
    .rollover_val(4'b1110),
    .count_out(count_out),
    .rollover_flag(rollover_flag)
    );

   reg 		     correctph;
   reg 		     trackingph;
   reg 		     correct1;
   
   assign correct = (count_out == 14 && correct1);
   
   //COMBINATION BLOCK TO CHECK WHETHER THE DATA SENT FROM RX-SR IS CORRECT BY COMPARING CRC VALUES FROM RX-SR AND CALCULATED CRC VALUE FROM CRC BLOCK.

always_comb
  begin
     trackingph = tracking;
     correctph = 1;
     clear = 0;
     
     count_enable = 1;
     if(tracking) 
       correctph = 0;
     
     if(enable && tracking==0) //CHECK IF EACH BIT OF CRC VALUE FROM RX-SR (MSB) MATCHES WITH CALCULATED CRC VALUE. IF NOT MATCHING, THEN SET CORRECT BIT TO 0 AND STOP TRACKING.
       begin
	  clear = 0;
	  correctph = 1;
	  if(crc_calculated[14-count_out] !=rxd)
	    begin
	       correctph = 0;
	       trackingph =1;	       
	    end
	  
       end
     if(!enable)
       begin
	  trackingph = 0;
	  count_enable = 0;
	  clear = 1;
	  
       end
     
  end // always_comb
   
   
          

   
   always_ff @ (posedge clk, negedge n_rst)
     begin
	if(n_rst == 0)
	  begin
	     tracking<=0;
	     correct1<= 0;
	     
	  end
	else
	  begin
	     correct1 <= correctph;
	     tracking<=trackingph;
	  end // else: !if(n_rst == 0)
	
	
     end // always_ff @
endmodule // arbitration

	     
