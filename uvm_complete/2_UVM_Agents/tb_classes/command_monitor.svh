/*
*/
class command_monitor extends uvm_component;
   `uvm_component_utils(command_monitor);

   virtual tinyalu_bfm bfm;

   uvm_analysis_port #(command_transaction) ap;

   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      tinyalu_agent_config tinyalu_agent_config_h;
      if(!uvm_config_db #(tinyalu_agent_config)::get(this, "","config", tinyalu_agent_config_h))
	`uvm_fatal("COMMAND MONITOR", "Failed to get CONFIG");
      tinyalu_agent_config_h.bfm.command_monitor_h = this;
      ap  = new("ap",this);
   endfunction : build_phase

   function void write_to_monitor(byte A, byte B, operation_t op);
     command_transaction cmd;
     `uvm_info("COMMAND MONITOR",$sformatf("MONITOR: A: %2h  B: %2h  op: %s",
                A, B, op.name()), UVM_HIGH);
     cmd = new("cmd");
     cmd.A = A;
     cmd.B = B;
     cmd.op = op;
     ap.write(cmd);
   endfunction : write_to_monitor
endclass : command_monitor


  
