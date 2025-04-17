class pe_seq_item extends uvm_sequence_item;

    `uvm_object_utils(pe_seq_item)
  
    rand logic [3:0] in; 
    logic [1:0] out;
    logic valid; 
  
    function new(string name = "pe_seq_item");
      super.new(name);
    endfunction
  
  endclass: pe_seq_item