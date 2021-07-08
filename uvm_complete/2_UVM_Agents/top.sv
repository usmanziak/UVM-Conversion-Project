/*
*

We now focus on reusability, we need to make our structure modular by encapsulating the entire "env"
into a uvm_agent, this allows engineers to use these blocks of verification classes as IP Blocks.

This agent is similar to an env, with the addition of a configuration class to transfer the BFM (Setting up that IP)
And another control to check whether to generate stimulus or not!



	NOTE: The author is testing the tester module vs your agent!
*/
module top;
   import uvm_pkg::*;
   import   tinyalu_pkg::*;
`include "tinyalu_macros.svh"
`include "uvm_macros.svh"
   
 tinyalu_bfm       class_bfm();
   
 tinyalu class_dut (.A(class_bfm.A), .B(class_bfm.B), .op(class_bfm.op), 
                    .clk(class_bfm.clk), .reset_n(class_bfm.reset_n), 
                    .start(class_bfm.start), .done(class_bfm.done), 
                    .result(class_bfm.result));

 tinyalu_bfm       module_bfm();

 tinyalu module_dut (.A(module_bfm.A), .B(module_bfm.B), .op(module_bfm.op), 
                     .clk(module_bfm.clk), .reset_n(module_bfm.reset_n), 
                     .start(module_bfm.start), .done(module_bfm.done), 
                     .result(module_bfm.result));

 tinyalu_tester_module stim_module(module_bfm);

 initial begin
  uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "class_bfm", class_bfm);
  uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "module_bfm", module_bfm);
  run_test("dual_test");
 end
   
endmodule : top

     
   
