class pe_scoreboard extends uvm_scoreboard;
  
    `uvm_component_utils(pe_scoreboard)
  
    uvm_analysis_imp#(pe_seq_item, pe_scoreboard) sb_port;
    
    function new(string name = "pe_scoreboard", uvm_component parent);
      super.new(name, parent);
    endfunction
  
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);    
      sb_port = new("sb_port", this);
    endfunction: build_phase
  
    function void write(pe_seq_item txn);
      logic [2:0] expected_out;
      bit expected_valid;
      
      casez (txn.in)
        4'b1???: begin expected_out = 2'b11; expected_valid = 1; end
        4'b01??: begin expected_out = 2'b10; expected_valid = 1; end
        4'b001?: begin expected_out = 2'b01; expected_valid = 1; end
        4'b0001: begin expected_out = 2'b00; expected_valid = 1; end
        4'b0000: begin expected_out = 2'b00; expected_valid = 0; end 
        default: begin expected_out = 2'b00; expected_valid = 0; end
      endcase
  
      if (txn.out == expected_out && txn.valid == expected_valid) begin
        `uvm_info("SCOREBOARD", $sformatf("Test case passed at t=%0t", $time), UVM_MEDIUM);
      end else begin
        `uvm_error("SCOREBOARD", $sformatf("Test case failed: in=%0b, expected_out=%0b, got_out=%0b, expected_valid=%0b, got_valid=%0b at t=%0t",txn.in, expected_out, txn.out, expected_valid, txn.valid, $time));
      end
    endfunction: write 
    
endclass: pe_scoreboard