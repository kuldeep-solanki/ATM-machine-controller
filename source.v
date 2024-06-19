`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 01:39:07
// Design Name: 
// Module Name: source
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

module source(
    input wire clk, 
    input wire rst, 
    input wire IC, 
    input wire CS, 
    input wire MT, 
    input wire [3:0] entered_pin, 
    input wire [7:0] amount_entered, 
    input wire [1:0] OP, // OP= option that is selected by the user
    input wire [7:0] balance, 
    input wire [3:0] pin,
    output reg y0, 
    output reg y1, 
    output reg y2, 
    output reg y3, 
    output reg y4, 
    output reg y5, 
    output reg y6, 
    output reg y7, 
    output reg y8, 
    output reg y9, 
    output reg y10, 
    output reg y11
);

    reg [7:0] balance_reg;
    reg [3:0] pin_reg;
    
    parameter [3:0] 
        idle_state = 4'b0000,
        scan_card = 4'b0001,        
        enter_pin = 4'b0010,
        option_select = 4'b0011,
        invalid = 4'b0100,
        withdraw = 4'b0101,
        balance_check = 4'b0110,
        deposit = 4'b0111,
        money_withdraw = 4'b1000,
        balance_show = 4'b1001,
        money_deposited = 4'b1010,
        anything_else = 4'b1011;
    
    reg [3:0] current_state, next_state;

    always @(*)
    begin
        y0 <= 0;      // idle state
        y1 <= 0;      // card inserted
        y2 <= 0;      // card scanned
        y3 <= 0;      // pin entered
        y4 <= 0;      // invalid result
        y5 <= 0;      // withdraw
        y6 <= 0;      // balance check
        y7 <= 0;      // deposit
        y8 <= 0;      // withdrawing money
        y9 <= 0;      // balance showing
        y10 <= 0;     // money deposited
        y11 <= 0;     // more transactions
        next_state <= 0;
        balance_reg <= balance;
        pin_reg <= pin;
        
        case(current_state)
            idle_state: begin
                if(IC) begin
                    next_state <= scan_card;
                    y1 <= 1;
                    $display("Scanning card");
                end else begin
                    next_state <= idle_state;
                    y0 <= 1;
                    $display("insert your card");
                end
            end
            
            scan_card: begin
                if(CS) begin
                    next_state <= enter_pin;
                    y2 <= 1;
                    $display("Scan completed");
                end else begin
                    next_state <= idle_state;
                    y0 <= 1;
                    $display("insert your card");
                end
            end
            
            enter_pin: begin
                if(entered_pin == pin_reg) begin
                    next_state <= option_select;
                    y3 <= 1;
                    $display("select option");
                end else begin
                    next_state <= invalid;
                    y4 <= 1;
                    $display("invalid input");
                end
            end
            
            invalid: begin
                next_state <= idle_state;
                y0 <= 1;
                $display("insert your card");
            end
            
            option_select: begin    // select option for withdraw or deposit of balance check
                if(OP == 2'b10) begin
                    next_state <= withdraw;
                    y5 <= 1;
                    $display("please enter amount to withdraw ");
                end else if(OP == 2'b01) begin
                    next_state <= balance_check;
                    y6 <= 1;
                    $display("checking balance");
                end else if(OP == 2'b11) begin
                    next_state <= deposit;
                    y7 <= 1;
                    $display("please enter amount to deposit");
                end else begin
                    next_state <= invalid;
                    y4 <= 1;
                    $display("invalid state");
                end
            end
            
            withdraw: begin
                if(amount_entered <= balance_reg) begin // if amount entered is less than balance in account
                    next_state <= money_withdraw;
                    y8 <= 1;
                    $display("withdrawing money ");
                end else begin
                    next_state <= invalid;
                    y4 <= 1;
                    $display("invalid input");
                end
            end
            
            balance_check: begin
                next_state <= balance_show;
                y9 <= 1;
                $display("your balance current balance is %0h ", balance_reg);
            end
            
            deposit: begin
                if(amount_entered <= 8'b11111111) begin
                    next_state <= money_deposited;
                    y10 <= 1;
                    $display("money deposited");
                end else begin
                    next_state <= invalid;
                    y4 <= 1;
                    $display("invalid input");
                end
            end
            
            money_withdraw: begin
                next_state <= anything_else;
                y11 <= 1;
                $display("more transactions..");
            end
            
            balance_show: begin
                next_state <= anything_else;
                y11 <= 1;
                $display("more transactions..");
            end
            
            money_deposited: begin
                next_state <= anything_else;
                y11 <= 1;
                $display("more transactions..");
            end
            
            anything_else: begin
                if(MT) begin
                    next_state <= option_select;
                    y3 <= 1;
                    $display("select option");
                end else begin
                    next_state <= idle_state;
                    y0 <= 1;
                    $display("insert your card");
                end
            end
            
            default: begin
                next_state <= idle_state;
                y0 <= 1;
                $display("insert your card");
            end
        endcase
    end
    
    always @(posedge clk or negedge rst)
    begin
        if(!rst)
            current_state <= idle_state;
        else
            current_state <= next_state;
    end
    
endmodule
