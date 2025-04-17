class pe_driver extends uvm_driver#(pe_seq_item);

    `uvm_component_utils(pe_driver)
  
    virtual pe_interface vif;
    
    pe_seq_item txn;
  
    function new(string name = "pe_driver", uvm_component parent);
      super.new(name, parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(virtual pe_interface)::get(this, "", "vif", vif)) begin
        `uvm_info("DRIVER", "Unable to get virtual interface", UVM_MEDIUM);
      end
    endfunction: build_phase
    
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      txn = pe_seq_item::type_id::create("txn");
      forever begin
        #1;
        seq_item_port.get_next_item(txn);
        drive(txn);
        seq_item_port.item_done();
      end
    endtask
  
    task drive(pe_seq_item txn);
      vif.in = txn.in;
    endtask
    
endclass: pe_driver  