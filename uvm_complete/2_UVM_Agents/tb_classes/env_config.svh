/*
*/
class env_config;
 virtual tinyalu_bfm class_bfm;
 virtual tinyalu_bfm module_bfm;

 function new(virtual tinyalu_bfm class_bfm, virtual tinyalu_bfm module_bfm);
    this.class_bfm = class_bfm;
    this.module_bfm = module_bfm;
 endfunction : new
endclass : env_config

