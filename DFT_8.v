`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Engineer: Venkata Tarun
// 
// Create Date: 15.02.2023 20:42:20
// Design Name: 8point dft using 4 point dft 
// Module Name: DFT_8
// Description: 

// Dependencies: DFT_4
// 

//////////////////////////////////////////////////////////////////////////////////


module DFT_8#(parameter N=32,P=10) (input [N-1:0]ar,ai,
                                            br,bi,
                                            cr,ci,
                                            dr,di,
                                            er,ei,
                                            fr,fi,
                                            gr,gi,
                                            hr,hi,

			output 		[N-1:0]AAAr,AAAi,
                                              BBBr,BBBi,
                                              CCCr,CCCi,
                                              DDDr,DDDi,
                                              EEEr,EEEi,
                                              FFFr,FFFi,
                                              GGGr,GGGi,
                                              HHHr,HHHi);
   
 wire[N:0]Ar,Ai,
                                              Br,Bi,
                                              Cr,Ci,
                                              Dr,Di,
                                              Er,Ei,
                                              Fr,Fi,
                                              Gr,Gi,
                                              Hr,Hi;
//
wire[31:0] w1=32'b10110101000001001111001100110100; //w1_8=0.707(1+j)
wire [P:0]W1;
assign W1={1'b0,w1[31:32-P]};
wire [3:0]d;






//4-point dft outputs
wire[N+1:0]Aar,Aai,Ccr,Cci, Eer,Eei,Ggr,Ggi,    Bbr,Bbi,Ddr,Ddi,Ffr,Ffi, Hhr,Hhi ;
 DFT_4#(N) DFT_8_1(ar,ai,cr,ci, er,ei,gr,gi,Aar,Aai,Bbr,Bbi,Ccr,Cci, Ddr,Ddi);
 DFT_4#(N) DFT_8_2(br,bi,dr,di, fr,fi,hr,hi,Eer,Eei,Ffr,Ffi,Ggr,Ggi, Hhr,Hhi);



//    1.       A,E
DFT_2 # ( N)     dft8AE(Aar[N-1:0],Aai[N-1:0],  Eer[N-1:0],Eei[N-1:0],       Ar[N:0],Ai[N:0],Er[N:0],Ei[N:0]);//multply with (1+0j) as angle =-0
/*assign Ai[P-1:0]={(P){1'b0}};
assign Ar[P-1:0]={(P){1'b0}};
assign Ei[P-1:0]={(P){1'b0}};
assign Er[P-1:0]={(P){1'b0}};
assign Ai[N+3+P]=Ai[N+2+P];
assign Ar[N+3+P]=Ar[N+P+2];
assign Ei[N+P+3]= Ei[N+P+2];
assign Er[N+P+3]=Er[N+P+2];*/



/*
Add_Sub_cmplx #( N+2)  Add_8A(Aar,Aai,Eer,Eei,0,Ar[N+2:P],Ai[N+2:P]);
//E
Add_Sub_cmplx #( N+2)  Add_8E(Aar,Aai,Eer,Eei,1,Er[N+2:P],Ei[N+2:P]);
*/


//        2.      B,F 
//product of 0.707 with F
wire [N+P+1:0]Fpr,Fpi;
Mul_cmplx   #(N,P+1) mul_8B(Ffr[N-1:0],Ffi[N-1:0],W1, -W1 ,Fpr,Fpi );//multply with (cos45-sin45j) as angle =-45
DFT_2 #(N)  dft8BF(Bbr[N-1:0],Bbi[N-1:0],           Fpr[N+P-1:P],Fpi[N+P-1:P],
                                                	                           Br[N:0],Bi[N:0],	Fr[N:0],Fi[N:0] );



/*
Add_Sub_cmplx #( N+2+P)  Add_8B({Bbr,{(P){1,b0}}},{Bbi,{(P){1,b0}}},Fpr,Fpi,0,Br,Bi);
//F
Add_Sub_cmplx #( N+2+P)  Add_8F({Bbr,{(P){1,b0}}},{Bbi,{(P){1,b0}}},Fpr,Fpi,1,Br,Bi);
*/
 
 
 
//		3.   C,G										
DFT_2 #(N)  dft8CG  (Ccr[N-1:0],Cci[N-1:0], Ggi[N-1:0],-Ggr[N-1:0],         Cr[N:0],Ci[N:0],Gr[N:0],Gi[N:0]);//multply with (0-j) as angle =-90
/*assign Ci[P-1:0]={(P){1'b0}};
assign Cr[P-1:0]={(P){1'b0}};
assign Gi[P-1:0]={(P){1'b0}};
assign Gr[P-1:0]={(P){1'b0}};

assign Cr[N+P+3]=Cr[N+P+2];
assign Ci[N+P+3]=Ci[N+P+2];
assign Gr[N+P+3]=Gr[N+P+2];
assign Gi[N+P+3]=Gi[N+P+2];*/


//                 4.  D,H
//product of 0.707 with H
wire [N+P+1:0]Hpr,Hpi;
Mul_cmplx   #(N,P+1) mul_8D(Hhr[N-1:0],Hhi[N-1:0],-W1,-W1,Hpr,Hpi );
DFT_2 #(N)      dft8DH(Ddr[N-1:0],Ddi[N-1:0],       Hpr[N+P-1:P],Hpi[N+P-1:P],
                                                                                Dr,Di,Hr,Hi );

assign  AAAr[N-1:0]=Ar[N-1:0];	assign  AAAi[N-1:0]=Ai[N-1:0];	
assign  BBBr[N-1:0]=Br[N-1:0];	assign  BBBi[N-1:0]=Bi[N-1:0];
assign  CCCr[N-1:0]=Cr[N-1:0];	assign CCCi[N-1:0]=Ci[N-1:0];	
assign  DDDr[N-1:0]=Dr[N-1:0];	assign DDDi[N-1:0]=Di[N-1:0];
assign  EEEr[N-1:0]=Er[N-1:0];	assign EEEi[N-1:0]=Ei[N-1:0];	
assign  FFFr[N-1:0]=Fr[N-1:0];	assign  FFFi[N-1:0]=Fi[N-1:0];
assign  GGGr[N-1:0]=Gr[N-1:0];	assign  GGGi[N-1:0]=Gi[N-1:0];	
assign  HHHr[N-1:0]=Hr[N-1:0];	assign  HHHi[N-1:0]=Hi[N-1:0];		
                                 
endmodule
