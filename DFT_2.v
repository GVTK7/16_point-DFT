`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Venkata Tarun
// 
// Create Date: 15.02.2023 19:50:43
// Design Name: 2 point DFT
// Module Name: DFT_2 
// Description: dft of [a,b]=[x,y]=[a+b,a-b],where a,b are complex numbers
//
// Dependencies:  Add_Sub_cmplx
//////////////////////////////////////////////////////////////////////////////////


module DFT_2 #(parameter N=32)(ar,ai,br,bi,Ar,Ai,Br,Bi);
input [N-1:0]ar,ai,br,bi;
output [N:0]Ar,Ai,Br,Bi;
Add_Sub_cmplx #(N)   Add_Sub_cmplx_dft_1 (ar,ai,br,bi,1'b0,Ar,Ai);
Add_Sub_cmplx #(N)   Add_Sub_cmplx_dft_2 (ar,ai,br,bi,1'b1,Br,Bi);
endmodule

