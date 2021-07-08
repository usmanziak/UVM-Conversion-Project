/*
*
This is the top level testbench and will launch the 3 sub classes and their methods in a thread


*/
class testbench;

// This is here to "remind" that this must be given the handle to a BFM

   virtual tinyalu_bfm bfm;

   tester    tester_h;
   coverage  coverage_h;
   scoreboard scoreboard_h;

   // Instantiation function!
   function new (virtual tinyalu_bfm b);
       bfm = b;
   endfunction : new

   // Tasks allow to take time, functions do not
   //
   task execute();
      tester_h    = new(bfm);
      coverage_h   = new(bfm);
      scoreboard_h = new(bfm);
// This thread lives on simulating the DUT, even when this execute task exits
      fork
         tester_h.execute();
         coverage_h.execute();
         scoreboard_h.execute();
      join_none
   endtask : execute
endclass : testbench

     
   
