`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:Venkata Tarun
// 
// Create Date: 15.02.2023 20:06:43
// Design Name:4 point dft using 2 point dft
// Module Name: DFT_4
 
// Description: 4 point DFT using 2point DFT
//               [a1,b1] from 2point dft
//               [c1,d1] from 2point  dft
//               [A,B,C,D]=[a1+c1,b1+j*d1,a1-c1,b1-j*d1]
// Dependencies: DFT_2, Add_Sub_cmplx
// 
//////////////////////////////////////////////////////////////////////////////////


module DFT_4#(parameter N=32) (input[N-1:0]ar,ai,
                                           br,bi,
                                           cr,ci,
                                           dr,di,
                               output [N-1:0]Ar,Ai,
                                           Br,Bi,
                                           Cr,Ci,
                                           Dr,Di);
                                           
                                           
wire [N:0]a1r,a1i,b1r,b1i;
wire [N:0]c1r,c1i,d1r,d1i;
DFT_2 #(N) dft2_4point_ab(ar,ai,cr,ci,a1r,a1i,b1r,b1i);//Even numbers 2-point DFT
DFT_2 #(N) dft2_4point_cd(br,bi,dr,di,c1r,c1i,d1r,d1i);
/*a1+c1*/Add_Sub_cmplx #(N+1)   Add_Sub_cmplx_dft_4_A (a1r,a1i,c1r,c1i ,1'b0,Ar,Ai);


/*b1+j*d1*/
//Add_Sub_cmplx #(N)   Add_Sub_cmplx_dft_4_B (b1r,b1i,-d1i,d1r ,0,Br,Bi);
Add_Sub_Nbit #(N+1) Add_Sub_cmplBr(b1r,d1i,1'b0,Br);           //real part=b1r-j*j*d1i
Add_Sub_Nbit #(N+1) Add_Sub_cmplBi(b1i,d1r,1'b1,Bi);           //Img part =j*b1i-j*d1r


/*a1-c1*/Add_Sub_cmplx #(N+1)   Add_Sub_cmplx_dft_4_C (a1r,a1i,c1r,c1i ,1'b1,Cr,Ci);


/*b1-j*d1*/
//Add_Sub_cmplx #(N)   Add_Sub_cmplx_dft_4_D (b1r,b1i,-d1i,d1r ,1,B1r,B1i);
Add_Sub_Nbit #(N+1) Add_Sub_cmplDr(b1r,d1i,1'b1,Dr);           //real part=b1r-(-j*j)*d1i
Add_Sub_Nbit #(N+1) Add_Sub_cmplDi(b1i,d1r,1'b0,Di);           //Img part =j*b1i-(-j)*d1r

endmodule
