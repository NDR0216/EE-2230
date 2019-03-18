`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/16 00:31:06
// Design Name: 
// Module Name: jugde_winner
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


module judge_winner(
    input switch,
    input rst,
    input player,
    input [5:0] score0,
    input [5:0] score1,
    //output [3:0] round,
    output reg endgame,
    output reg [2:0] winner
    );
    reg [3:0]round = 4'b0;
    reg endgame = 1'b0;
    reg [1:0] duce = 2'd0;
    always@(posedge switch or posedge rst)
    if(rst)
        duce <= 2'd0;
    else if(score0 == 6'd0 && score1 > 0)
        duce <= duce + 1;
    else if(duce == 2'd2)
        duce <= duce;
    always@(posedge switch or posedge rst)
    if(rst)
        round <= 4'd0;
    else if(round == 4'd14)
        round <= round;
    else if(endgame == 0)
        round = round + 1'b1;
    always@*
    if(rst)
    begin
        endgame = 1'b0;
        winner = 3'b000;
    end
    else
    begin
        if(round == 4'd14)
        begin
            endgame = 1;
            if(score0 == score1)//Tie
                winner = 3'b100;
            else if(score0 < score1)// P0 win
                winner = 3'b001;
            else if(score0 > score1)// P1 win
                winner = 3'b010;
        end
        else
        begin
            if(player == 0)
            begin
                if(score0 == 6'd0 && score1 > 6'd20)// P0 win
                begin
                    winner = 3'b001;
                    endgame = 1;
                end
                else if(score0 == 6'd0 && duce == 2'd2)
                begin
                    winner = 3'b001;
                    endgame = 1;
                end
            end
            else if(player == 1)
            begin
                if(score0 == 6'd0 && score1 == 6'd0)// Tie
                begin
                    winner = 3'b100;
                    endgame = 1;
                end
                else if(score1 == 6'd0)//  P1 win
                begin
                    winner = 3'b010;
                    endgame = 1;
                end
            end
        end
    end
endmodule
