`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2023 14:22:35
// Design Name: 
// Module Name: tb
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


module tb_16dft();
parameter N=32;
parameter P=10;
reg [N-1:0]r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,
                                                   i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15;
wire[N-1:0]  RRR0,RRR1,RRR2,RRR3,RRR4,RRR5,RRR6,RRR7,RRR8,RRR9,RRR10,RRR11,RRR12,RRR13,RRR14,RRR15,
                                                   III0,III1,III2,III3,III4,III5,III6,III7,III8,III9,III10,III11,III12,III13,III14,III15;




 DFT_16#( N,P)  tb_16dft_dut(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,
                                                   i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,
                                       RRR0,RRR1,RRR2,RRR3,RRR4,RRR5,RRR6,RRR7,RRR8,RRR9,RRR10,RRR11,RRR12,RRR13,RRR14,RRR15,
                                                   III0,III1,III2,III3,III4,III5,III6,III7,III8,III9,III10,III11,III12,III13,III14,III15);
                                              
                                              
initial
begin 
r0=32'd2;  r1=32'd4;  r2=32'd6;  r3=32'd8;  r4=32'd10;  r5=32'd12;  r6=32'd14;  r7=32'd16;  r8=32'd18;  r9=32'd20;  r10=32'd22;  r11=32'd24;  r12=32'd26;  r13=32'd28;  r14=32'd30;  r15=32'd32;
i0=32'd3;  i1=32'd5;  i2=32'd7;  i3=32'd9;  i4=32'd11;  i5=32'd13;  i6=32'd15;  i7=32'd17;  i8=32'd19;  i9=32'd21;  i10=32'd23;  i11=32'd25;  i12=32'd27;  i13=32'd29;  i14=32'd31;  i15=32'd1;

end                          
endmodule
