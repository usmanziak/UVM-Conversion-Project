/*
*

Theory:

Our previous testbench lacked modularity and it is cosidered a major design flaw in the industry

We can either create an testbench that becomes adaptable and powerful as the design grows or buggy and brittle.
Our previous testbench was the latter, upon crunch time, engineering teams will run into countless modifications
which will raise all kinds of errors and even if the project is the success, The testbench is a complete waste and will 
have to be re-written for a new project!




Application:

We leverage SV interfaces to modularize our conventional testbench by 
encapsulating all the signal level stimulus into one block and share that across 
our modules.

	
	Tester - Generate test stimulus 
	Coverage - Provide functional coverage
	ScoreBoard - Checks the result 


Issues:

This design although modular still doesn't take advantages of OOP 
as testbenches become more complex!

OOP Advantages:

	- Code Reuse
	- Code Maintainability
	- Memory Management 


*/
module top;
   tinyalu_bfm    bfm();
   // bfm is ported using the SV Module ports just like regular signals

   tester     tester_i    (bfm);
   coverage   coverage_i  (bfm);
   scoreboard scoreboard_i(bfm);
   
   tinyalu DUT (.A(bfm.A), .B(bfm.B), .op(bfm.op), 
                .clk(bfm.clk), .reset_n(bfm.reset_n), 
                .start(bfm.start), .done(bfm.done), .result(bfm.result));
endmodule : top

     
   
