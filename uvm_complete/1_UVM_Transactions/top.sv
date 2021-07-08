/*
*


Let's finally finish off our UVM TB in three stages:

1) Transactions
2) Agents
3) Sequences

Theory:

Everything until now has been great, we kept breaking out TB in smaller parts to improve debugability and adaptability instead of intractable code.

We have also used proper OOP Paradigms to connect our classes with FIFOs and UVM Ports.

However, we never applied OOP to our data! We used structs to package and pass our data around the communication ports to our testbench

The weak point was that any modification to our command_s struct will affect the workings of all the classes that use it (Guts are exposed, A, B and op). 

The affected classes are: coverage, tester, scoreboard, and "driver"

Application:

Let's start transaction level modelling! 

("Transaction" fancy term == Data)

We will soon have our TB ready for complex designs such that of an Ethernet!


Painful but easy Part (All the list of changes needed to adapt our Testbench to our new transactions!


	1) Create a result_transaction class to hold the results
	2) create an add_transaction class that extends command_transaction and generates only add operations!
	3) Rename the base_tester to tester since it now works for all tests!
	4) command_monitor is modified to create a command_transaction
	5) result_monitor is // // result_transaction
	6) Scoreboard will now use the result_transaction's compare()
	7) The add_test will now use the add_transaction!


*/
module top;
   import uvm_pkg::*;
   import   tinyalu_pkg::*;
`include "tinyalu_macros.svh"
`include "uvm_macros.svh"
   
   tinyalu_bfm       bfm();
   tinyalu DUT (.A(bfm.A), .B(bfm.B), .op(bfm.op), 
                .clk(bfm.clk), .reset_n(bfm.reset_n), 
                .start(bfm.start), .done(bfm.done), .result(bfm.result));


initial begin
   uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "bfm", bfm);
   run_test();
end

endmodule : top

     
   
