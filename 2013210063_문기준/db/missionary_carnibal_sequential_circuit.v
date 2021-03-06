module missionary_carnibal_combinational_circuit(H, I, A, B, D);        
     //I/O ports declaration
     input [1:0] A;
    input [1:0] B;
    input D;
    output [1:0] H;
    output [1:0] I;
    
    //inner net definition
    wire aw1, aw2, aw3, aw4, aw5, aw6, aw7, aw8, aw9, aw10, aw11, aw12, aw13, aw14, aw15, aw16, aw17, aw18, aw19;
    
    //primitive logic gate instantiation
    //and gate
    and (aw1, ~A[0], A[1]);
    and (aw2, A[0], ~A[1]);
    and (aw3, ~D, A[0]);
    and (aw4, ~D, ~B[0], B[1]);
    and (aw5, ~D, B[0], B[1]);
    and (aw6, ~D, B[0]);
    and (aw7, D, ~B[0], ~A[0]);
    and (aw8, D, ~B[0], ~B[1]);
    and (aw9, D, ~B[0]);
    and (aw10, D, B[0], ~B[1], ~A[0], A[1]);
    and (aw11, B[1], A[0], ~A[1]);
    and (aw12, B[1], A[0]);
    and (aw13, ~B[0], ~A[0]);
    and (aw14, ~B[0], A[0], ~A[1]);
    and (aw15, ~B[0], ~B[1]);
    and (aw16, B[0], A[1]);
    and (aw17, B[0], B[1]);
    
    //or gate
    or (H[0], aw1,aw3,aw5,aw7,aw11,aw15,aw16);
    or (H[1], aw3,aw5,aw9,aw12,aw15,aw16);
    or (I[0], aw1,aw2,aw4,aw6,aw8,aw13);
    or (I[1], aw6,aw9,aw10,aw14,aw15,aw17);

endmodule

//D flip-flop with asynchronous reset.
module D_Flip_Flop(Q,D,CLK,RST);
  output Q;
  input D, CLK, RST;
  reg Q;
  always @(posedge CLK or negedge RST)
    if (~RST) Q = 1'b0; // Same as : if (RST==0)
    else Q = D;
endmodule

module Additional_module(L, M, J, K, H, I, C);
  input [1:0] H, I;   //combinational circuit output
  input C;            //register movement direction output
  output [1:0] L, M;  
  output J, K;        
  
  assign L[1] = H[0];
  assign L[0] = H[1];
  assign M[1] = I[0];
  assign M[0] = I[1];

  assign J = (~C);    //next movement direction
  and(K, ~H[1], ~H[0], ~I[1], ~I[0]);    //finish bit

 endmodule

module missionary_carnibal_sequential_circuit(L, M, K, clock, reset);
 output [1:0] L, M;
 output K;
 input clock, reset;   //movement direction
 wire [1:0] A, B, H, I;  
 wire D, J;

 D_Flip_Flop  FF0 (A[0], H[0], clock, reset),
              FF1 (A[1], H[1], clock, reset),
              FF2 (B[0], I[0], clock, reset),
              FF3 (B[1], I[1], clock, reset),
              FF4 (D, J, clock, reset);
 
 missionary_carnibal_combinational_circuit     CC0 (H, I, A, B, D);

 Additional_module                             AM0 (L, M, J, K, H, I, D);

 endmodule