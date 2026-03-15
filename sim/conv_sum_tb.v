`timescale 1ns / 1ps

module tb_conv_s;

  localparam DATA_WIDTH = 8;
  localparam KERNEL_SIZE = 3;
  localparam OUTPUT_WIDTH = (2 * DATA_WIDTH + $clog2(KERNEL_SIZE));

  reg clk;
  reg RESET;
  reg signed [DATA_WIDTH-1:0] DATA_IN;
  reg valid_in;
  reg signed [KERNEL_SIZE*DATA_WIDTH-1:0] KERNEL;
  wire signed [OUTPUT_WIDTH-1:0] DATA_OUT;
  wire valid_out;

  conv_s #(
    .DATA_WIDTH(DATA_WIDTH),
    .KERNEL_SIZE(KERNEL_SIZE)
  ) dut (
    .clk(clk),
    .RESET(RESET),
    .DATA_IN(DATA_IN),
    .valid_in(valid_in),
    .KERNEL(KERNEL),
    .DATA_OUT(DATA_OUT),
    .valid_out(valid_out)
  );

  always #5 clk = ~clk;

  task send_input;
    input signed [DATA_WIDTH-1:0] value;
    input valid;
    begin
      @(posedge clk);
      DATA_IN = value;
      valid_in = valid;
    end
  endtask

  initial begin
    $display("\n--- Starting Convolution Test ---\n");

    clk = 0;
    RESET = 1;
    DATA_IN = 0;
    valid_in = 0;
    KERNEL = {8'd1, 8'd2, 8'd1}; 

    #10 RESET = 0;

    $display("Time | DATA_IN | valid_in | DATA_OUT | valid_out");

    send_input(8'd1, 1);  
    send_input(8'd2, 1);  
    send_input(8'd7, 1);  
    send_input(8'd9, 1);  
    send_input(8'd6, 1);  
    send_input(8'd3, 1); 
    send_input(8'd10, 0);  
    send_input(8'd15, 0);  

    #20;
    $display("\n--- Test Finished ---\n");
    $finish;
  end

  always @(posedge clk) begin
    $display("%4t | %7d | %9b | %8d | %9b",
      $time, DATA_IN, valid_in, DATA_OUT, valid_out);
  end

endmodule
