module PISOReg #(parameter WordLen=8)
(clk,SCLKEdgeFlg,EnPISO,LoadPISO,WordFlg,Endiannes,DataIN,MOSI);

    input clk,SCLKEdgeFlg,EnPISO,LoadPISO,WordFlg,Endiannes;
    input [WordLen-1:0] DataIN;
    output reg MOSI;

    reg [WordLen-1:0] Reg;

    always@(posedge clk)
    begin
        if(EnPISO)
        begin
            if(LoadPISO)
                Reg <= DataIN;
            else if(SCLKEdgeFlg && ~WordFlg)
            begin
                if(~Endiannes)      //Little Endian
                    Reg <= {1'b0,Reg[WordLen-1:1]};
                else                //Big Endian
                    Reg <= {Reg[WordLen-2:0],1'b0};
            end
        end
    end

    always@(*)
    begin
        if(~Endiannes)
            MOSI = Reg[0];
        else
            MOSI = Reg[WordLen-1];
    end

endmodule