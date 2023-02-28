`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Venkata Tarun
// 
// Create Date: 15.02.2023 19:55:41
// Design Name: Complex addition 
// Module Name: Add_Sub_cmplx
// Description:Complex addition 
// 
// Dependencies: Add_Sub_Nbit 
//////////////////////////////////////////////////////////////////////////////////


module Add_Sub_cmplx #(parameter N=32)(ar,ai,br,bi,k,cr,ci);
input[N-1:0] ar,ai,br,bi;
input k;
output[N:0]cr,ci;
Add_Sub_Nbit #(N) Add_Sub_cmplx1(ar,br,k,cr);
Add_Sub_Nbit #(N) Add_Sub_cmplx2(ai,bi,k,ci);
endmodule
