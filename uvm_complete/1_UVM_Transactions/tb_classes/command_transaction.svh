/*
*
Our first Transaction!

A transaction provides a lot more useful data level operations that we need to take into 
consideration for a complex design such that of a Ethernet (Complex Data)

This includes:
	1) Provide a string with the data values "convert2string"
	2) Copying another transaction into this "do_copy"
	3) Comparing // // "do_compare"
	4) Randomizing the data values "randomize"
	5) Done! Encapsulating will make it easier for the tester (no need for it to check legal values 
	to drive the DUT with)

Previously:

	we had get_op() 

	8 possible values but only 6 legal ones




	& get_data()


	1/3 chance of having all zeros, all ones or randomized data in A and B

	without it we'd have 1/256 chance of all zeros (Bad for coverage goals)

	rand in System Verilog will solve this for us!!
*/
class command_transaction extends uvm_transaction;
   `uvm_object_utils(command_transaction)

   // Our rand implementation!
   rand byte unsigned        A;
   rand byte unsigned        B;
   rand operation_t         op;


   // And our constraint for the data (equal chances of 1, 0 and random
   constraint data { A dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1};
                     B dist {8'h00:=1, [8'h01 : 8'hFE]:=1, 8'hFF:=1}; }

   // ^ Now no need for get op or get data (Get op will only get the 6 legal
   // enumerated values!
   
   
// Deep Copy Operation right here!
//
   function void do_copy(uvm_object rhs);
      command_transaction copied_transaction_h;

      if(rhs == null) 
        `uvm_fatal("COMMAND TRANSACTION", "Tried to copy from a null pointer")

      if(!$cast(copied_transaction_h,rhs))
        `uvm_fatal("COMMAND TRANSACTION", "Tried to copy wrong type.")
   // Copy the parent stuff and then copy the AB etc
   //
      super.do_copy(rhs); // copy all parent class data

      A = copied_transaction_h.A;
      B = copied_transaction_h.B;
      op = copied_transaction_h.op;

   endfunction : do_copy
// VERY IMPORTANT: In a large design, you may not want to copy 250 ports of
// a Design. A team would rather have a handle to the data instead of making
// 250 copies! 
//
//
// This only works if the team follows the MOOCOW Principle:

// " Mandatory Obligatory Object Copy On Write (MOOCOW), 
// Thus we have a clone function that uses the do_copy() and makes a sweet
// clone for you to change and play around with! (Instead of changing a data
// that everyone had a handle too! BAD
//
   function command_transaction clone_me();
      command_transaction clone;
      uvm_object tmp;

      tmp = this.clone();
      $cast(clone, tmp);
      return clone;
   endfunction : clone_me


// The do_compare method allows you to, This is a deep comparison of two
// transactions so obviously gets passed up there...
//
// Note that rhs (is what we compare)
// uvm_comparer is another formality and beyond the scope!
//
// 1 if same 

   function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      command_transaction compared_transaction_h;
      bit   same;
      
      if (rhs==null) `uvm_fatal("RANDOM TRANSACTION", 
                                "Tried to do comparison to a null pointer");
      
      if (!$cast(compared_transaction_h,rhs))
        same = 0;
      else
        same = super.do_compare(rhs, comparer) && 
               (compared_transaction_h.A == A) &&
               (compared_transaction_h.B == B) &&
               (compared_transaction_h.op == op);
               
      return same;
   endfunction : do_compare

// This is great for printing!
   function string convert2string();
      string s;
      s = $sformatf("A: %2h  B: %2h op: %s",
                        A, B, op.name());
      return s;
   endfunction : convert2string


   // This is a UVM_OBJECT so no need for a parent like the one needed in
   // a UVM_Component!
   function new (string name = "");
      super.new(name);
   endfunction : new

endclass : command_transaction

      
        
