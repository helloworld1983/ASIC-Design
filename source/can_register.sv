// $Id: $
// File name:   can_register.sv
// Created:     11/30/2017
// Author:      Sang Hun Kim
// Lab Section: 337-01
// Version:     1.0  Initial Design Entry
// Description: can_register

`timescale 1ns / 10ps
module can_register
  (
   input wire 	     clk,
   input wire 	     n_rst,
   input wire [31:0] command,
   input wire 	     rxd,
   output reg 	     txd, 
   output reg 	     write_fifo,
   output reg 	     read_fifo,
   output reg [31:0] send_data
   );

   typedef enum      bit [2:0] {SOF, ARBITRATION, CONTROL, DATA, CRC, ACK, EOF} stateType;

   stateType state;
   stateType next_state;
   reg [31:0] 	     rx_data;
   reg 		     rx_enable;
   reg 		     win_lose;
   reg 		     arbitration_start;
   reg 		     crc_enable;
   reg [14:0] 	     crc;
   reg 		     af_enable;
   reg 		     correct;
   reg 		     load_enable;
   reg [31:0] 	     send_data_to_tx;
    reg 		     tx_enable;
   reg [5:0] 	     num_bits;
   reg 		     clear;
   reg 		     count_enable;
   reg [5:0] 	     count_out;
   reg 		     rollover_flag;
   reg [5:0] 	     rollover_val;
 reg [31:0] send_dataph;
   //Storing RX_DATA
   reg [31:0] 	     temp_rx_data;

  
   wire 		     store_data;
   assign store_data = (state == CRC && count_out == 0);
   
 	     
   always_ff @ (negedge clk)
     begin
	if (n_rst == 1'b0)
	  begin
	     temp_rx_data <= '0;
	  end
	else
	  begin
	     if( store_data)
	       temp_rx_data   <=rx_data;
	  end // else: !if(n_rst == 1'b0)
     end // always_ff @
   
   
   reg 	WRITE_CANph;
   reg 	WRITE_CAN;
   
   

   //acceptance filter IMPLEMENTATION
  
   
   
   acceptance_filter ACCEPT
     (
      .clk(clk),
      .n_rst(n_rst),
      .rxd(rxd),
      .crc_calculated(crc),
      .correct(correct),
      .enable(af_enable)
      );
   

   //CRC IMPLEMENTATION
   wire data_for_crc;
   assign data_for_crc = (WRITE_CAN)? txd : rxd;
   
   
   can_crc CRC_module
     (
      .data(data_for_crc),
      .crc_en(crc_enable),
      .clk(clk),
      .n_rst(n_rst),
      .crc_out(crc)
      );

   //flex_counter IMPLEMENTATION
	     
   
   flex_counter #(6) FLEX_COUNTER
   (
    .clk(clk),
    .n_rst(n_rst),
    .clear(clear),
    .count_enable(count_enable),
    .rollover_val(rollover_val),
    .count_out(count_out),
    .rollover_flag(rollover_flag)
    );
   
   
   //tx_sr IMPLEMENTATION

 	     
   tx_sr TX_SR
     (
      .clk(clk),
      .n_rst(n_rst),
      .tx_enable(tx_enable),
      .load_enable(load_enable),
      .tx_data(send_data_to_tx),
      .tx_out(txd)
      );
   
   //rx_sr IMPLEMENTATION

   
   rx_sr RX_SR
     (
      .clk(clk),
      .n_rst(n_rst),
      .rx_enable(rx_enable),
      .can_bus_data(rxd),
      .rx_data(rx_data)
      );

   //arbitration IMPLEMENTATION

   
   arbitration ARBITRATION_module
     (
      .clk(clk),
      .n_rst(n_rst),
      .rxd(rxd),
      .arbitration_start(arbitration_start),
      .win(win),
      .loose(loose)
      );

   wire [31:0]	data_stored_commandph;
   reg 	[31:0]data_stored_command;
   reg 	      sync1;//used to delay save signal
   reg 	      sync2;
   reg 	      sync;
   wire       sync_final;
   assign sync_final = (sync1 || sync2);
   assign data_stored_commandph = (sync2) ? command : data_stored_command;
  
   
   
   always_ff @ (posedge clk, negedge n_rst)
     begin
	if (n_rst == 1'b0)
	  begin
	     sync1 <= 0;
	     sync2<=0;
	     state <= SOF;
		send_data <= '0;
	     WRITE_CAN<= 1;
	     //data_stored_command<= '1;
	  end
	else
	  begin
	     sync1<= sync;
	     sync2<= sync1;
	     send_data<= send_dataph;
	     WRITE_CAN<= WRITE_CANph;
	     state <= next_state;
	     //data_stored_command<= data_stored_command;
	     
	  end
     end // always_ff @

   always_ff @( negedge clk)
     begin
	if(n_rst == 1'b0)
	  data_stored_command<= '1;
	else
	  data_stored_command<= data_stored_commandph;
       end

   always_comb
     begin
	next_state = state;
	case(state)
	  SOF:
	    begin
	       
		 next_state = ARBITRATION;
	     
	    end
	  ARBITRATION:
	    begin
	       if (count_out == 10)
		 next_state = CONTROL;
	       else
		 next_state = ARBITRATION;
	    end
	  CONTROL:
	    begin
	       if (count_out == 7)
		 next_state = DATA;
	       else
		 next_state = CONTROL;
	    end
	  DATA:
	    begin
	       if (count_out == 31)
		 next_state = CRC;
	       
	       else
		 next_state = DATA;   
	    end
	  CRC:
	    begin
	       if (count_out == 14)
		 next_state = ACK;
	       else
		 next_state = CRC;
	    end
	  ACK:
	    begin
	      
		 next_state = EOF;
	     
	    end
	  EOF:
	    begin
	     
		 next_state = SOF;
	      
	    end
	endcase // case (state)
     end // always_comb
 
   always_comb
     begin
	load_enable = 1'b0;
	send_data_to_tx = '0;
	arbitration_start = 1'b0;
	clear = 1'b0;
	count_enable = 1'b0;
	rollover_val = '0;
	tx_enable = 1'b1;
	rx_enable = 1'b1;
	crc_enable = 1'b0;
	read_fifo = 1'b0;
	write_fifo = 1'b0;
	af_enable = 1'b0;
	WRITE_CANph = WRITE_CAN;
	sync = 0;
	send_dataph = send_data;
	
	//EACH STATE IN STATE MACHINE IN CAN REGISTER REPRESENTS EACH FIELD IN CAN BUS DATA TRANSFER SYSTEM.
	case(state)
	  SOF:
	    begin
	       count_enable = 1'b1;
	       rollover_val = 1;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    count_enable = 1'b0;
		    clear = 1'b1;
		 end
	     
	    end // case: SOF
	  ARBITRATION:
	    begin
	       count_enable = 1'b1;
	       rollover_val = 10;
	       tx_enable = 1;
	       rx_enable = 1;
	       
	       
	       arbitration_start = 1'b1;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    
		    send_data_to_tx = { 31'b10101010000000000000000000000000};
		 end
	       else if (count_out != 10)
		   begin
		      if (win)
			begin
			   count_enable = 1'b1;
			   clear = 1'b0;
			   read_fifo = 1'b1;
			   WRITE_CANph = 1;
			   sync = 1;
			   
			end
		      else if (loose)
			begin
			   count_enable = 1'b1;
			   clear = 1'b0;
			   WRITE_CANph = 0;			   
			   
			end
		      else
			begin
			   tx_enable = 1'b1;
			   rx_enable = 1'b1;
			   clear = 1'b0;
			  // send_data_to_tx = {11'b10101010000,'0};
			end
		   end
		 else
		   begin
		      count_enable = 1'b0;
		      clear = 1'b1;
		   end
	    end // case: ARBITRATION
	  CONTROL:
	    begin
		send_dataph = '0;	
	       count_enable = 1'b1;
	       rollover_val = 7;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    send_data_to_tx = { 31'b00100000000000000000000000000000};
		 end
	       else
		 begin
		    if (count_out != 7)
		      begin
			 tx_enable = 1'b1;
			 rx_enable = 1'b1;
			 send_data_to_tx = {31'b00100000000000000000000000000000};
		      end
		    else
		      begin
			 read_fifo = 1'b0;
			 count_enable = 1'b0;
			 clear = 1'b1;
			 //crc_enable = 1;
			 
		      end
		 end // else: !if(count_out == 0)
	    end // case: CONTROL
	  DATA:
	    begin	  
	       count_enable = 1'b1;
	       rollover_val = 31;
	       crc_enable = 1'b1;
	    
	        if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    send_data_to_tx = data_stored_command;
		 end
	       else
		 begin
        
		    if (count_out != 31)
		      begin
			 tx_enable = 1'b1;
			 rx_enable = 1'b1;
			 

		      end
		    else
		      begin
			 count_enable = 1'b0;
			 clear = 1'b1;
			 //crc_enable = 0;
			 
		      end
		 end // else: !if(count_out == 2)
	    end // case: DATA
	  CRC:
	    begin
	      
	       count_enable = 1'b1;
	       rollover_val = 14;
	       send_data_to_tx = crc<<17;
	       if(count_out >= 1)
		  af_enable = 1'b1;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    //send_data_to_tx = send_data_to_tx<<17;
		 end
	       else
		 begin
		    if (count_out != 14)
		      begin
			 tx_enable = 1'b1;
			 rx_enable = 1'b1;
			 //send_data_to_tx = {'0,crc};
			 //send_data_to_tx = send_data_to_tx<<17;
			 
		      end
		    else
		      begin
			 tx_enable = 1;
			 count_enable = 1'b0;
			 clear = 1'b1;
			 
		      end // else: !if(count_out != 14)
		 end // else: !if(count_out == 0)
	    end // case: CRC
	  ACK:
	    begin
	       af_enable = 1'b0;
	       count_enable = 1'b1;
	       rollover_val = 1;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    count_enable = 1'b0;
		    clear = 1'b1;
		    if (correct == 1'b1)
		      begin
			 send_data_to_tx = 8'h00000000;
			 send_dataph = temp_rx_data;
			 write_fifo = 1'b1;
		      end
		    else
		      send_data_to_tx = 8'h80000000;
		 end
	   
	    end // case: ACK
	  EOF:
	    begin
	       count_enable = 1'b1;
	       rollover_val = 1;
	       if (count_out == 0)
		 begin
		    load_enable = 1'b1;
		    tx_enable = 1'b1;
		    rx_enable = 1'b1;
		    send_data_to_tx = '0;
		    count_enable = 1'b0;
		    clear = 1'b1;
		 end
	 
	    end // case: EOF
	endcase // case (state)
     end // always_comb
   
endmodule // can_register

