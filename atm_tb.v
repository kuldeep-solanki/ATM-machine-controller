`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 01:42:29
// Design Name: 
// Module Name: atm_tb
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


//module atm_tb(

//    );
//endmodule

`timescale 1ns / 1ps
 //////////////////////////////////////////////////////////////////////////////////
 module atm_tb;
 reg clk,rst,IC,CS,MT;
 reg [1:0] OP;
 reg [3:0] entered_pin, pin;
 reg [7:0] amount_entered, balance;
 wire y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11;
 source
 dut(clk,rst,entered_pin,amount_entered,OP,IC,CS,MT,balance,pin,y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11);
initial
 begin
 clk <= 0;
 rst <= 0;
 IC <= 0;
 CS <= 0;
 MT <= 0;
 end
 always #20 clk = ~clk;
 initial
 begin
 #100 rst=1;
 #50
 IC=1;
 CS=1;
 balance=00000011;
 pin=0011;
 entered_pin=0011;
 amount_entered = 00000011;
 OP=11;
 MT=0;
 #240;
 IC=1;
 CS=1;
 balance=00000011;
 pin=0011;
 entered_pin=0000;
 amount_entered = 00000011;
 OP=10;
 MT=0;
 #240
 IC=1;
 CS=1;
 balance=00000101;
pin=0011;
 entered_pin=0011;
 amount_entered = 00000011;
 OP=01;
 MT=0;
 #240
 IC=1;
 CS=1;
 balance=00000101;
 pin=0011;
 entered_pin=0011;
 amount_entered = 00001001;
 OP=01;
 MT=0;
 #240
 IC=1;
 CS=1;
 balance=00000001;
 pin=0000;
 entered_pin=0000;
 amount_entered = 00000011;
 OP=10;
 MT=0;
 #240
 IC=1;
 CS=1;
 balance=00000001;
 pin=0000;
 entered_pin=0000;
 amount_entered = 00000111;
 OP=11;
 MT=0;
 end
 endmodule

