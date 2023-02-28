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


module tb_8dft();
parameter N=32;
parameter P=10;
reg [N-1:0]ar,ai,br,bi,cr,ci,dr,di,er,ei,fr,fi, gr,gi,hr,hi;

//
wire [N-1:0]AAAr,AAAi,
                                              BBBr,BBBi,
                                              CCCr,CCCi,
                                              DDDr,DDDi,
                                              EEEr,EEEi,
                                              FFFr,FFFi,
                                              GGGr,GGGi,
                                              HHHr,HHHi;






DFT_8  #( N,P) tb_8dft(ar,ai,br,bi,cr,ci,dr,di,er,ei,fr,fi, gr,gi,hr,hi,
                                             
					      AAAr,AAAi,
                                              BBBr,BBBi,
                                              CCCr,CCCi,
                                              DDDr,DDDi,
                                              EEEr,EEEi,
                                              FFFr,FFFi,
                                              GGGr,GGGi,
                                              HHHr,HHHi);
                                              
                                              
initial
begin 
ar=32'd2;   ai=32'd3;
br=32'd4;   bi=32'd5;
cr=32'd6;   ci=32'd7;
dr=32'd8;   di=32'd9;
er=32'd10;   ei=32'd11;
fr=32'd12;   fi=32'd13;
gr=32'd14;   gi=32'd15;
hr=32'd16;   hi=32'd1;

end                          
endmodule
