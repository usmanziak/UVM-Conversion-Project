/*
*
Theory:

Why OOP?

Traditional Verilog programming so far has been sufficient for verifying our ALU but 
as soon as projects add layers of complexity ex: CPUs with 3 levels of cache

You need to implement complex predictors (ScoreBoard), Extensive Coverage, and 
robust stimulus generators. 

On top of that, we need to scale a unit test to a system test and have a large team of engineers work
with a common framework (This seems impossible!)

However, OOP can handle all this complexity!


Application:

We have converted our 3 modules into SV Classes and encapsulated all of them in 
a top level testbench class


Issues:

This is still not a common framework that large engineering teams can work on.
Let's introduce UVM.

Moreover, UVM does a lot of the stuff for us, it hands us engineers the entire structure of the TB

This OOP Testbench, I had to implement everything from scratch!

*/
module top;
  import   tinyalu_pkg::*;
`include "tinyalu_macros.svh"
   
   tinyalu DUT (.A(bfm.A), .B(bfm.B), .op(bfm.op), 
                .clk(bfm.clk), .reset_n(bfm.reset_n), 
                .start(bfm.start), .done(bfm.done), .result(bfm.result));

   tinyalu_bfm     bfm();

   testbench    testbench_h;
   


   initial begin
   
// We instantiate the top level class and pass in the bfm like a module port
// list but not exactly the same.. Explained in the testbench class.

      testbench_h = new(bfm);
      testbench_h.execute();
   end
   
endmodule : top

     
   
