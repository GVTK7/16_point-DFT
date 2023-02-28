`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Venkata Tarun
// 
// Create Date: 15.02.2023 16:20:15
// Design Name: Complex Multiplier
// Module Name: Mul_cmplx 
// Description: (cr,ci)=(arbr-aibi,arbi+aibr)
// 
// Dependencies: Array_MUL_Sign,Add_Sub_Nbit
// 
//////////////////////////////////////////////////////////////////////////////////


module Mul_cmplx   #(parameter N=21,M=11) (input [N-1:0]ar,ai,
                                         input [M-1:0]br,bi,
                                         output[M+N:0]cr,ci );
 wire [M+N-1:0]arbr,aibi,arbi,aibr;
 
 //Multiplication for Real_part                                         
 Array_MUL_Sign #(N,M)  mul_cplx1(ar,br,1'b1,arbr);
 Array_MUL_Sign #(N,M)  mul_cplx2(ai,bi,1'b1,aibi);
 
 //Multiplication for Imaginary_part 
 Array_MUL_Sign #(N,M)  mul_cplx3(ar,bi,1'b1,arbi);
 Array_MUL_Sign #(N,M)  mul_cplx4(ai,br,1'b1,aibr);
 
 //
Add_Sub_Nbit  #(N+M)    add_sub1(arbr,aibi,1'b1,cr);
Add_Sub_Nbit  #(N+M)    add_sub2(arbi,aibr,1'b0,ci);

endmodule
