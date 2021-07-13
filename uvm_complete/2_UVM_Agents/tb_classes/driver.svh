/*
*/
class driver extends uvm_component;
   `uvm_component_utils(driver)

   virtual tinyalu_bfm bfm;

   uvm_get_port #(command_transaction) command_port;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
   function void build_phase(uvm_phase phase);
      tinyalu_agent_config tinyalu_agent_config_h;
      if(!uvm_config_db #(tinyalu_agent_config)::get(this, "","config", tinyalu_agent_config_h))
        `uvm_fatal("DRIVER", "Failed to get BFM");
      bfm = tinyalu_agent_config_h.bfm;
      command_port = new("command_port",this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      byte         unsigned        iA;
      byte         unsigned        iB;
      operation_t                  op_set;
      shortint     result;
      command_transaction    command;
      forever begin : command_loop
         command_port.get(command);
         bfm.send_op(command.A, command.B, command.op, result);
      end : command_loop
   endtask : run_phase
   
   
endclass : driver
