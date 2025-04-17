class pe_sequence extends uvm_sequence#(pe_seq_item);

    `uvm_object_utils(pe_sequence)
    
    pe_seq_item txn;
    
    function new(string name = "pe_sequence");
      super.new(name);
    endfunction
  
    task body();
      repeat (50) begin 
       txn = pe_seq_item::type_id::create("txn");
       start_item(txn);
       assert(txn.randomize());
       finish_item(txn);
      end
    endtask
    
endclass: pe_sequence