/*



This is now the main tester as we have multiple kinds of data encapsulted in transactions

we no longer need a add_tester etc!






*/
class tester extends uvm_component;
   `uvm_component_utils (tester)

   uvm_put_port #(command_transaction) command_port;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      command_port = new("command_port", this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      command_transaction  command;

      phase.raise_objection(this);

      command = new("command");
      command.op = rst_op;
      command_port.put(command);

      repeat (10) begin

// We use the factory incantaion again so we can override this at a higher
// level for our specific transaction needs!	      
         command = command_transaction::type_id::create("command");
         assert(command.randomize());
         command_port.put(command);
      end

      command = new("command");
      command.op = mul_op;
      command.A = 8'hFF;
      command.B = 8'hFF;
      command_port.put(command);

      #500;
      phase.drop_objection(this);
   endtask : run_phase
endclass : tester






