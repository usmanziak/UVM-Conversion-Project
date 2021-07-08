/*
*



This is just an extension of the main command_transaction class with 
overriding the constraint for the op to just throw "add"




*/

class add_transaction extends command_transaction;
   `uvm_object_utils(add_transaction)

   constraint add_only {op == add_op;}

   function new(string name="");super.new(name);endfunction
endclass : add_transaction

      
        
