module conv_s #(
  parameter DATA_WIDTH = 8,
  parameter KERNEL_SIZE = 3
)(
  input clk,
  input RESET,
  input signed [DATA_WIDTH-1:0] DATA_IN,
  input valid_in,
  input signed [KERNEL_SIZE*DATA_WIDTH-1:0] KERNEL,
  output signed [(2*DATA_WIDTH + $clog2(KERNEL_SIZE))-1:0] DATA_OUT,
  output reg valid_out
);

  reg signed [DATA_WIDTH-1:0] shift_array [0:KERNEL_SIZE-1];
  wire signed [DATA_WIDTH-1:0] kernel_array [0:KERNEL_SIZE-1];
  reg signed [(2*DATA_WIDTH + $clog2(KERNEL_SIZE))-1:0] sum;
  integer i;


  generate
    genvar j;
    for (j = 0; j < KERNEL_SIZE; j = j + 1) begin
      assign kernel_array[j] = KERNEL[(j*DATA_WIDTH) +: DATA_WIDTH];
    end
  endgenerate

  always @(posedge clk) begin
    if (RESET) begin
      for (i = 0; i < KERNEL_SIZE; i = i + 1)
        shift_array[i] <= 0;
      valid_out <= 0;
    end else if (valid_in) begin
      // Shift input into array
      for (i = KERNEL_SIZE-1; i > 0; i = i - 1)
        shift_array[i] <= shift_array[i-1];
      shift_array[0] <= DATA_IN;
      
      valid_out <= 1;
    end else begin
      valid_out <= 0;
    end
  end
  always @(*)begin
  sum = 0;
      for (i = 0; i < KERNEL_SIZE; i = i + 1)
        sum = sum + shift_array[i] * kernel_array[i];
  end
  assign DATA_OUT=sum;
endmodule
 
