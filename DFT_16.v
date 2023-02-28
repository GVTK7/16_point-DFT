`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2023 23:21:19
// Design Name: 
// Module Name: DFT_16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - FIe Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module DFT_16#(parameter N=32,P=10)  (input [N-1:0]r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,
                                                   i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,
                                      output[N-1:0]  RRR0,RRR1,RRR2,RRR3,RRR4,RRR5,RRR6,RRR7,RRR8,RRR9,RRR10,RRR11,RRR12,RRR13,RRR14,RRR15,
                                                   III0,III1,III2,III3,III4,III5,III6,III7,III8,III9,III10,III11,III12,III13,III14,III15);



                              												//even terms 8point dft                     
wire [N-1:0]Rr0,Rr1,Rr2,Rr3,Rr4,Rr5,Rr6,Rr7, Ii0,Ii1,Ii2,Ii3,Ii4,Ii5,Ii6,Ii7;					
DFT_8  #( N,P) dft8_in16_1(r0,i0,  r2,i2,  r4,i4 , r6,i6,  r8,i8,  r10,i10,  r12,i12,  r14,i14,
                         Rr0,Ii0, Rr1,Ii1, Rr2,Ii2, Rr3,Ii3,  Rr4,Ii4,  Rr5,Ii5 , Rr6,Ii6, Rr7,Ii7);
															
															//odd terms 8point dft
wire [N-1:0]Rr8,Rr9,Rr10,Rr11,Rr12,Rr13,Rr14,Rr15, Ii8,Ii9,Ii10,Ii11,Ii12,Ii13,Ii14,Ii15;
DFT_8  #( N,P) dft8_in16_2(r1,i1,  r3,i3,  r5,i5 , r7,i7,  r9,i9,  r11,i11,  r13,i13,  r15,i15,
                         Rr8,Ii8, Rr9,Ii9, Rr10,Ii10, Rr11,Ii11,  Rr12,Ii12,  Rr13,Ii13 , Rr14,Ii14, Rr15,Ii15);
                         
wire[31:0] w2r= 32'b11101100100000110101111001110010;/*w1_16r=0.92387953    pi/8   */                wire [P:0]W2r;      assign W2r={1'b0,w2r[31:32-P]};
wire[31:0] w2i= 32'b01100001111101111000101010010100;/*w1_16i=0.38268343            */                wire [P:0]W2i;       assign W2i={1'b0,w2i[31:32-P]};
wire[31:0] w1=32'b10110101000001001111001100110100; /*w1_8=0.707(1+j)               */                wire [P:0]W1;        assign W1={1'b0,w1[31:32-P]};




//pre multiplication for odd terms
wire [N+P+1:0]RR8,II8,RR9,II9,RR10,II10,RR11,II11,RR12,II12,RR13,II13,RR14,II14,RR15,II15;
                                                                                       //Rr8       (1,0)
 Mul_cmplx   #( N,P+1)   pre_mul_Rr9(Rr9[N-1:0],Ii9[N-1:0],W2r,-W2i,RR9,II9);          //RR9       pi/8(cos,-sin)
 Mul_cmplx   #( N,P+1)   pre_mul_Rr10(Rr10[N-1:0],Ii10[N-1:0],W1,-W1,RR10,II10);       //Rr10      pi/4(cos,-sin)   
 Mul_cmplx   #( N,P+1)   pre_mulRr11(Rr11[N-1:0],Ii11[N-1:0],W2i,-W2r,RR11,II11);      //Rr11      pi/8(sin,-cos)
                                                                                       //Rr12      (0,-1)
  Mul_cmplx   #( N,P+1)   pre_mul_Rr13(Rr13[N-1:0],Ii13[N-1:0],-W2i,-W2r,RR13,II13);   //Rr13      pi/8(-sin,-cos)
 Mul_cmplx   #( N,P+1)   pre_mul_Rr14(Rr14[N-1:0],Ii14[N-1:0],-W1,-W1,RR14,II14);      //Rr14      pi/4(-cos,-sin)
 Mul_cmplx   #( N,P+1)   pre_mulRr15(Rr15[N-1:0],Ii15[N-1:0],-W2r,-W2i,RR15,II15);     //Rr15      pi/8(-cos,-sin)


// Finally adding even and odd terms results 
wire [N:0]R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,
          I0,I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15;

DFT_2 #(N)  dft16_0_8  (Rr0,Ii0,Rr8,         Ii8,                     R0[N:0],I0[N:0],R8[N:0],I8[N:0]);		//0,8
DFT_2 #(N)  dft16_1_9  (Rr1,Ii1,RR9[N-1+P:P],II9[N-1+P:P],            R1[N:0],I1[N:0],R9[N:0],I9[N:0]);		//1,9
DFT_2 #(N)  dft16_2_10  (Rr2,Ii2,RR10[N-1+P:P],II10[N-1+P:P],         R2[N:0],I2[N:0],R10[N:0],I10[N:0]);	//2,10
DFT_2 #(N)  dft16_3_11  (Rr3,Ii3,RR11[N-1+P:P],II11[N-1+P:P],         R3[N:0],I3[N:0],R11[N:0],I11[N:0]);	//3,11
DFT_2 #(N)  dft16_4_12  (Rr4,Ii4,Ii12         ,-Rr12,                 R4[N:0],I4[N:0],R12[N:0],I12[N:0]);	//4,12
DFT_2 #(N)  dft16_5_13  (Rr5,Ii5,RR13[N-1+P:P],II13[N-1+P:P],         R5[N:0],I5[N:0],R13[N:0],I13[N:0]);	//5,13
DFT_2 #(N)  dft16_6_14  (Rr6,Ii6,RR14[N-1+P:P],II14[N-1+P:P],         R6[N:0],I6[N:0],R14[N:0],I14[N:0]);	//6,14
DFT_2 #(N)  dft16_7_15  (Rr7,Ii7,RR15[N-1+P:P],II15[N-1+P:P],         R7[N:0],I7[N:0],R15[N:0],I15[N:0]);	//7,15

   assign RRR0=R0[N-1:0]; assign III0=I0[N-1:0];
   assign RRR1=R1[N-1:0]; assign III1=I1[N-1:0];
   assign RRR2=R2[N-1:0]; assign III2=I2[N-1:0];
   assign RRR3=R3[N-1:0]; assign III3=I3[N-1:0];
   assign RRR4=R4[N-1:0]; assign III4=I4[N-1:0];                                    
   assign RRR5=R5[N-1:0]; assign III5=I5[N-1:0];
   assign RRR6=R6[N-1:0]; assign III6=I6[N-1:0];
   assign RRR7=R7[N-1:0]; assign III7=I7[N-1:0];
   assign RRR8=R8[N-1:0]; assign III8=I8[N-1:0];
   assign RRR9=R9[N-1:0]; assign III9=I9[N-1:0];
   assign RRR10=R10[N-1:0]; assign III10=I10[N-1:0];
   assign RRR11=R11[N-1:0]; assign III11=I11[N-1:0];
   assign RRR12=R12[N-1:0]; assign III12=I12[N-1:0];
   assign RRR13=R13[N-1:0]; assign III13=I13[N-1:0];
   assign RRR14=R14[N-1:0]; assign III14=I14[N-1:0];
   assign RRR15=R15[N-1:0]; assign III15=I15[N-1:0];


         
                                           
endmodule
