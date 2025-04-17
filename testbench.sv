`include "uvm_macros.svh"
import uvm_pkg::*;
`include "pe_interface.sv"
`include "pe_seq_item.svh"
`include "pe_sequence.svh"
`include "pe_sequencer.svh"
`include "pe_monitor.svh"
`include "pe_driver.svh"
`include "pe_agent.svh"
`include "pe_scoreboard.svh"
`include "pe_environment.svh"
`include "pe_test.svh"

module priority_encoder_4to2_tb_top();

  pe_interface vif();

  priority_encoder_4to2 dut(.in(vif.in), .out(vif.out), .valid(vif.valid));

  initial begin
    vif.in = 0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, priority_encoder_4to2_tb_top);
  end

  initial begin
    uvm_config_db#(virtual pe_interface)::set(null, "uvm_test_top", "vif", vif);
  end

  initial begin
    run_test("pe_test");
  end

endmodule