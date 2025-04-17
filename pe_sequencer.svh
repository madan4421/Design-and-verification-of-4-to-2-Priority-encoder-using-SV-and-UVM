class pe_sequencer extends uvm_sequencer#(pe_seq_item);

    `uvm_component_utils(pe_sequencer)
    
    function new(string name = "pe_sequencer", uvm_component parent);
      super.new(name, parent);
    endfunction
    
endclass: pe_sequencer