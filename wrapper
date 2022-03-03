`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: J. Calllenes
//           P. Hummel
// 
// Create Date: 01/20/2019 10:36:50 AM
// Design Name: 
// Module Name: OTTER_Wrapper 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module OTTER_Wrapper(
   input CLK,
   input BTNL,
   input BTNC,
   input BTNR,
   input BTNU,
   input BTND,
   input [15:0] SWITCHES,
   output logic [15:0] LEDS,
   output [7:0] CATHODES,
   output [3:0] ANODES,
   output [7:0] VGA_RGB,
   output VGA_HS,
   output VGA_VS
   );
        
    // INPUT PORT IDS ////////////////////////////////////////////////////////
    // Right now, the only possible inputs are the switches
    // In future labs you can add more MMIO, and you'll have
    // to add constants here for the mux below
    localparam SWITCHES_AD = 32'h11000000;
    localparam VGA_READ_AD = 32'h11000160;
    localparam BTNU_RD= 32'h11001100; // may just use variables bnt_int
    localparam BTND_RD= 32'h11001110; // may just use variables bnt_int
    localparam BTNL_RD= 32'h11001120; // may just use variables bnt_int
    localparam BTNR_RD= 32'h11001130; // may just use variables bnt_int
           
    // OUTPUT PORT IDS ///////////////////////////////////////////////////////
    // In future labs you can add more MMIO
    localparam LEDS_AD      = 32'h11000020;
    localparam SSEG_AD     = 32'h11000040;
    localparam VGA_ADDR_AD = 32'h11000120;
    localparam VGA_COLOR_AD = 32'h11000140; 
    
   // Signals for connecting OTTER_MCU to OTTER_wrapper /////////////////////////
   logic s_reset, s_interrupt, btn_intU,btn_intD, btn_intL, btn_intR;
   logic sclk = 1'b0;   
   logic [31:0] IOBUS_out,IOBUS_in,IOBUS_addr;
   logic IOBUS_wr;
   
   // Signals for connecting VGA Framebuffer Driver
   logic r_vga_we;             // write enable
   logic [12:0] r_vga_wa;      // address of framebuffer to read and write
   logic [7:0] r_vga_wd;       // pixel color data to write to framebuffer
   logic [7:0] r_vga_rd;       // pixel color data read from framebuffer
 
   logic [15:0]  r_SSEG;
   
   // Connect Signals ////////////////////////////////////////////////////////////
  // assign s_interrupt = btn_int;
  assign s_interrupt = btn_intU|btn_intD|btn_intL|btn_intR; // if interrupt 
  //assign int_U =  btn_intU;
   //assign int_D =  btn_intD;
   //assign int_R =  btn_intR;
   //assign int_L =  btn_intL;
   assign s_reset = BTNC;
   
   // Declare OTTER_CPU ///////////////////////////////////////////////////////
   otter_mcu MCU (.btn_intU(btn_intU),.btn_intD(btn_intD),.btn_intL(btn_intL),.btn_intR (btn_intR),
                    .rst(s_reset),.intr(s_interrupt), .clk(sclk),  
                   .iobus_out(IOBUS_out),.iobus_in(IOBUS_in),
                   .iobus_addr(IOBUS_addr),.iobus_wr(IOBUS_wr));

   // Declare Seven Segment Display /////////////////////////////////////////
   SevSegDisp SSG_DISP (.DATA_IN(r_SSEG), .CLK(CLK), .MODE(1'b0),
                       .CATHODES(CATHODES), .ANODES(ANODES));
   
   // Declare Debouncer One Shot  ///////////////////////////////////////////
   debounce_one_shot DBL(.CLK(sclk), .BTN(BTNL), .DB_BTN(btn_intL));
   debounce_one_shot DBR(.CLK(sclk), .BTN(BTNR), .DB_BTN(btn_intR));
    debounce_one_shot DBU(.CLK(sclk), .BTN(BTND), .DB_BTN(btn_intU));
   debounce_one_shot DBD(.CLK(sclk), .BTN(BTNU), .DB_BTN(btn_intD));
   
   // Declare VGA Frame Buffer //////////////////////////////////////////////
   vga_fb_driver_80x60 vga_fb_driver(.CLK_50MHz(sclk), .WA(r_vga_wa), .WD(r_vga_wd),
                               .WE(r_vga_we), .RD(r_vga_rd), .ROUT(VGA_RGB[7:5]),
                               .GOUT(VGA_RGB[4:2]), .BOUT(VGA_RGB[1:0]),
                               .HS(VGA_HS), .VS(VGA_VS));   
 
   // Clock Divider to create 50 MHz Clock /////////////////////////////////
   always_ff @(posedge CLK) begin
       sclk <= ~sclk;
   end

   // Connect Board peripherals (Memory Mapped IO devices) to IOBUS /////////////////////////////////////////
   always_ff @ (posedge sclk) begin
        r_vga_we<=0;       
        if(IOBUS_wr)
            case(IOBUS_addr)
                LEDS_AD: LEDS <= IOBUS_out[15:0];    
                SSEG_AD: r_SSEG <= IOBUS_out[15:0];
                VGA_ADDR_AD: r_vga_wa <= IOBUS_out[12:0];
                VGA_COLOR_AD: begin  
                        r_vga_wd <= IOBUS_out[7:0];
                        r_vga_we <= 1;  
                    end     
            endcase
    end
    
    always_comb begin
        case(IOBUS_addr)
            SWITCHES_AD: IOBUS_in = {16'b0, SWITCHES};
            VGA_READ_AD: IOBUS_in = {24'b0, r_vga_rd};
            BTNU_RD: IOBUS_in = {1'b0, btn_intU};
            BTND_RD: IOBUS_in = {1'b0, btn_intD};
            BTNL_RD: IOBUS_in = {1'b0, btn_intL};
            BTNR_RD: IOBUS_in = {1'b0, btn_intR};
            default: IOBUS_in = 32'b0;
        endcase
    end
   endmodule
