class pe_monitor extends uvm_monitor;

    `uvm_component_utils(pe_monitor)
  
    virtual pe_interface vif;
    
    pe_seq_item txn;
  
    uvm_analysis_port#(pe_seq_item) mon_ap;
  
    function new(string name = "pe_monitor", uvm_component parent);
      super.new(name, parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      txn = pe_seq_item::type_id::create("txn", this); // Create a transaction
      if (!(uvm_config_db#(virtual pe_interface)::get(this, "", "vif", vif))) begin
        `uvm_info("MONITOR", "Unable to get virtual interface", UVM_MEDIUM);
      end
      mon_ap = new("mon_ap", this);
    endfunction: build_phase
  
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
        #1;
        txn.in = vif.in;
        txn.out = vif.out;
        txn.valid = vif.valid;
        mon_ap.write(txn);
      end
    endtask
      
endclass: pe_monitor  