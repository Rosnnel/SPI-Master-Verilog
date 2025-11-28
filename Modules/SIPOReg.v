// SPDX-License-Identifier: CERN-OHL-S-2.0
// © 2025 Rosnnel Moncada

module SIPOReg #(parameter WordLen=8)
(clk,SCLKEdgeFlg,EnSIPO,BitOrder,MISO,ReceivedData);

    input clk,SCLKEdgeFlg,EnSIPO,BitOrder;
    input MISO;
    output [WordLen-1:0] ReceivedData;

    reg [WordLen-1:0] Reg;

    always@(posedge clk)
    begin
        if(EnSIPO)
        begin
            if(SCLKEdgeFlg)
            begin
                if(BitOrder)      //Little Endian
                    Reg <= {MISO,Reg[WordLen-1:1]};
                else                //Big Endian
                    Reg <= {Reg[WordLen-2:0],MISO};
            end
        end
    end

    assign ReceivedData = Reg;

endmodule