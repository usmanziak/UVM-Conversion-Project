/*


This class is used to pass in the bfm and the active option!

*/
class tinyalu_agent_config;

   virtual tinyalu_bfm bfm;
   protected  uvm_active_passive_enum     is_active;

   function new (virtual tinyalu_bfm bfm, uvm_active_passive_enum
		 is_active);
      this.bfm = bfm;
      this.is_active = is_active;
   endfunction : new

   function uvm_active_passive_enum get_is_active();
      return is_active;
   endfunction : get_is_active
   
endclass : tinyalu_agent_config
