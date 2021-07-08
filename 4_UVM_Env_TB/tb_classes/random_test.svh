/*


This is the top level uvm_component (uvm_test).

We will build a testbench hierarchy here:

Go to the scoreboard class for:
1) How to create any UVM Component 
2) How to override phases and the sequence in which they get launched in UVM



Below is the top level test that gets instantiated in the top module:

This test however seperates the structure with the stimulus 

The structure is encapsulated in the environment now


*/
class random_test extends uvm_test;
   
// This is registering this uvm_test with the factory

   `uvm_component_utils(random_test);

   env       env_h;


   function void build_phase(uvm_phase phase);

//Here we override the basetester factory incantation used in the environment
//with the right random_tester class that we require!
      base_tester::type_id::set_type_override(random_tester::get_type());
      env_h = env::type_id::create("env_h",this);
   endfunction : build_phase

// Constructor (following UVM obligations)

   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
endclass


