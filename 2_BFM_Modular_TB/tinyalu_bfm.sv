/*
*
(BFM) using SV Interfaces. 

This interface encapsulates all the signals including the clock

Additionally, this provides 2 tasks that sends an operation to the ALU

This is a perfect example of what it means to modularize your TB, any protocol level change will transfer through the rest of the
TB Components like (Scoreboard, Tester, Coverage)!

*/
interface tinyalu_bfm;
   import tinyalu_pkg::*;

   byte         unsigned        A;
   byte         unsigned        B;
   bit          clk;
   bit          reset_n;
   wire [2:0]   op;
   bit          start;
   wire         done;
   wire [15:0]  result;
   operation_t  op_set;

   assign op = op_set;

   initial begin
      clk = 0;
      forever begin
         #10;
         clk = ~clk;
      end
   end

// This will drop the reset signal and raise it back again 
   task reset_alu();
      reset_n = 1'b0;
      @(negedge clk);
      @(negedge clk);
      reset_n = 1'b1;
      start = 1'b0;
   endtask : reset_alu


// The operation_t is an enumerated type defined in the *tinyalu_pkg*

  task send_op(input byte iA, input byte iB, input operation_t iop, output shortint alu_result);
     
     op_set = iop;
     
     if (iop == rst_op) begin
         @(posedge clk);
         reset_n = 1'b0;
         start = 1'b0;
         @(posedge clk);
         #1;
         reset_n = 1'b1;
      end else begin
         @(negedge clk);
         A = iA;
         B = iB;
         start = 1'b1;
         if (iop == no_op) begin
            @(posedge clk);
            #1;
            start = 1'b0;           
      end else begin
// An example of the signal level protocols also dumped in this BFM for the
// DUT
            do
              @(negedge clk);
            while (done == 0);
            start = 1'b0;
         end
      end // else: !if(iop == rst_op)
      
   endtask : send_op

endinterface : tinyalu_bfm

   
