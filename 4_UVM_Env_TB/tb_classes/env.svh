/*



Architecting Adaptable Code vs Intractable Code !!

This is the UVM EVIRONMENT CLASS:

Previously we just had uvm launch the uvm_test class and that had the build phase for all 
our uvm_components (x3). 

This however, will cause an issue of [intractable vs adaptable coding style]. 

RAY Salemi saw the worst case of intractable coding when an engineering team that
copied over all the tests into another directory and made couple edits as per their requirement

You can see that the error was that they "copied" and not "extended" this can be a huge design error as 
any modifications at a higher level will not translate through the copied testbench.

That is why we want to "" Seperate the testbench structure with the behaviour "" 

And thus we dump the TB Structure in this uvm_env and then have the uvm_test alter the behavior only!


*/
class env extends uvm_env;
   `uvm_component_utils(env);

   base_tester   tester_h;
   coverage      coverage_h;
   scoreboard    scoreboard_h;

   function void build_phase(uvm_phase phase);

// This fancy way of creating the components is called using the factory
// ""incantation"" 
//
// Note that we are calling a base tester here (Don't worry, this will be
// overriden in the top level test class that uses this structure!
      tester_h     = base_tester::type_id::create("tester_h",this);
      coverage_h   = coverage::type_id::create ("coverage_h",this);
      scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
   endfunction : build_phase

   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

endclass
   
   
