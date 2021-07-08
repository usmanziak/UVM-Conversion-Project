/*
*
This is a uvm_component (Scoreboard)

Steps for creating a uvm_component:
	1) Extend the uvm class
	2) Use the macro to register this new class with the UVM Factory
	3) Provide the minimum UVM Constructor
	4) Finally override the phases as per your needs!


UVM Phases:
1) build_phase

Use to build your TB hierarchy
Must mention any components here (AKA builds your test!)

2) connect_phase

Connect the components together

3) end_of_elaboration_phase 

for additional adjustment after the hierarchy and connections are setup

4) *task* run_phase (UVM calls this in it's own thread hence a task and not a function)
// A task can use simulation time (waiting for clocks, delays etc) functions
// however must return immediately!
5) report_phase

Runs when the last objection is dropped and the test is finished (Used for reporting!)

*/
class scoreboard extends uvm_component;
   `uvm_component_utils(scoreboard);

   virtual tinyalu_bfm bfm;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
// As you can see each class is now self-sufficient and calls it's own bfm
// from a global "repo or variable" (Better Design)
      if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
        $fatal("Failed to get BFM");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      shortint predicted_result;
      ;
      forever begin : self_checker
         @(posedge bfm.done)
	   #1;
           case (bfm.op_set)
             add_op: predicted_result = bfm.A + bfm.B;
             and_op: predicted_result = bfm.A & bfm.B;
             xor_op: predicted_result = bfm.A ^ bfm.B;
             mul_op: predicted_result = bfm.A * bfm.B;
           endcase // case (op_set)
         
         if ((bfm.op_set != no_op) && (bfm.op_set != rst_op))
           if (predicted_result != bfm.result)
             $error ("FAILED: A: %0h  B: %0h  op: %s result: %0h",
                     bfm.A, bfm.B, bfm.op_set.name(), bfm.result);
      end : self_checker
   endtask : run_phase
endclass : scoreboard






