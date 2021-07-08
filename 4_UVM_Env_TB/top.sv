/*
*


Theory:

Our previous OOP Testbench was entirely hardcoded, meaning if we want to run with a different stimulus, 
we will have to re-write the entire tester class and re-compile the TB.

Let's turn that hardcoded testbench into a dynamic testbench using UVM

Application:

	1) UVM Tests

	This will allow us to run multiple tests with one compilation (Factory Design Pattern)
*insert picture of the commands*

	Compiled once and able to run different tests at run time

	2) UVM Components

	3) UVM Ennvironments




Moving on? Isn't this good enough:

What we did?
	1) We broke up the test class by structure (env) and the stimulus (overriding the env tester)
	2) We used adaptable programming with the tester structure (basetester -> random_tester -> add_tester)
	3) We used the factory to actually instantiate the (x3) sub components (factory incantation)
What needs to be done?

	1) Each component accesses the bfm independently, however, for a super complex testbench we need to have objects communicate instead!
	2) Let's create inter object communication and complete our final UVM Based TestBench

*/
module top;

// Importing the UVM Package (Class definitions, methods etc)
   import uvm_pkg::*;
   import   tinyalu_pkg::*;
`include "tinyalu_macros.svh"
`include "uvm_macros.svh"
   
// Our interface & DUT 
   tinyalu_bfm       bfm();
   tinyalu DUT (.A(bfm.A), .B(bfm.B), .op(bfm.op), 
                .clk(bfm.clk), .reset_n(bfm.reset_n), 
                .start(bfm.start), .done(bfm.done), .result(bfm.result));

// UVM already starts doing stuff for us, the manual process of instantiating
// a top level testbench class and running it's execute method is done for us
// by UVM!
//
initial begin

// This is a perfect example of using static methods/variables as global
// variables stored in a parameterized class that can now be shared across the
// entire testbench
//
// Previously: we passed the bfm handle to our class directly but notice that
// UVM will dynamically create our top testbench class for us. Thus, we just
// follow the formalities and store the bfm in a global storage so the UVM
// Factory can access it when needed!
//
// null & * make it available across the entire tb
   uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "bfm", bfm);
   // This reads the test from the simulation at run time
   run_test();
end

endmodule : top

     
   
