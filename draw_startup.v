module draw_startup(clock, reset_startup_counter, enable_startup_counter, startup_x, startup_y, block_counter);
       
    input clock, reset_startup_counter, enable_startup_counter;  
    output reg [7:0] startup_x;
    output reg [6:0] startup_y;
    
    output reg [8:0] block_counter;   

	always @ (posedge clock)
	begin
		if (!reset_startup_counter)
			begin
			block_counter <= 9'd0;
			end
		else if (enable_startup_counter)
			begin 
			if (block_counter != 9'd109) begin
				block_counter <= block_counter + 1; end
				//block_counter <= 9'd0;
			//else 	
			end 
	end 	
	
	/*  SHOW_STARTUP_SCREEN  */
	
	// P
	wire [14:0] coord_1 = {8'd32, 7'd70}; 
	wire [14:0] coord_2 = {8'd32, 7'd71}; // 111
	wire [14:0] coord_3 = {8'd32, 7'd72};
	wire [14:0] coord_4 = {8'd32, 7'd73};
	wire [14:0] coord_5 = {8'd32, 7'd74};
	wire [14:0] coord_6 = {8'd32, 7'd75};
	wire [14:0] coord_7 = {8'd32, 7'd76};
	wire [14:0] coord_8 = {8'd33, 7'd70};
	wire [14:0] coord_9 = {8'd34, 7'd70};
	wire [14:0] coord_10 = {8'd35, 7'd71};
	wire [14:0] coord_11 = {8'd35, 7'd72};
	wire [14:0] coord_12 = {8'd34, 7'd70};
	wire [14:0] coord_13 = {8'd33, 7'd70};
	                                     
	// R
	wire [14:0] coord_14 = {8'd38, 7'd70};
	wire [14:0] coord_15 = {8'd38, 7'd71};
	wire [14:0] coord_16 = {8'd38, 7'd72};
	wire [14:0] coord_17 = {8'd38, 7'd73};
	wire [14:0] coord_18 = {8'd38, 7'd74};
	wire [14:0] coord_19 = {8'd38, 7'd75};
	wire [14:0] coord_20 = {8'd38, 7'd76};
	wire [14:0] coord_21 = {8'd39, 7'd70};
	wire [14:0] coord_22 = {8'd40, 7'd70};
	wire [14:0] coord_23 = {8'd41, 7'd70};
	wire [14:0] coord_24 = {8'd41, 7'd71};
	wire [14:0] coord_25 = {8'd41, 7'd72};
	wire [14:0] coord_26 = {8'd40, 7'd73};
	wire [14:0] coord_27 = {8'd41, 7'd74};
	wire [14:0] coord_28 = {8'd41, 7'd75};
	wire [14:0] coord_29 = {8'd41, 7'd76};
	
	// E
	wire [14:0] coord_30 = {8'd44, 7'd70};
	wire [14:0] coord_31 = {8'd44, 7'd71};
	wire [14:0] coord_32 = {8'd44, 7'd72};
	wire [14:0] coord_33 = {8'd44, 7'd73};
	wire [14:0] coord_34 = {8'd44, 7'd74};
	wire [14:0] coord_35 = {8'd44, 7'd75};
	wire [14:0] coord_36 = {8'd44, 7'd76};
	wire [14:0] coord_37 = {8'd45, 7'd70};
	wire [14:0] coord_38 = {8'd46, 7'd70};
	wire [14:0] coord_39 = {8'd45, 7'd73};
	wire [14:0] coord_40 = {8'd46, 7'd73};
	wire [14:0] coord_41 = {8'd45, 7'd76};
	wire [14:0] coord_42 = {8'd46, 7'd76};
	
	
	// S (1)
	wire [14:0] coord_43 = {8'd49, 7'd70};
	wire [14:0] coord_44 = {8'd50, 7'd70};
	wire [14:0] coord_45 = {8'd51, 7'd70};
	wire [14:0] coord_46 = {8'd52, 7'd70};
	wire [14:0] coord_47 = {8'd49, 7'd71};
	wire [14:0] coord_48 = {8'd49, 7'd72};
	wire [14:0] coord_49 = {8'd49, 7'd73};
	wire [14:0] coord_50 = {8'd50, 7'd73};
	wire [14:0] coord_51 = {8'd51, 7'd73}; 
	wire [14:0] coord_52 = {8'd52, 7'd73}; // 111
	wire [14:0] coord_53 = {8'd52, 7'd74};
	wire [14:0] coord_54 = {8'd52, 7'd75};
	wire [14:0] coord_55 = {8'd52, 7'd76};
	wire [14:0] coord_56 = {8'd51, 7'd76};
	wire [14:0] coord_57 = {8'd50, 7'd76};
	wire [14:0] coord_58 = {8'd49, 7'd76};
	
	// S (2)
	wire [14:0] coord_59 = {8'd55, 7'd70};
	wire [14:0] coord_60 = {8'd56, 7'd70};
	wire [14:0] coord_61 = {8'd57, 7'd70};
	wire [14:0] coord_62 = {8'd58, 7'd70};
	wire [14:0] coord_63 = {8'd55, 7'd71};
	wire [14:0] coord_64 = {8'd55, 7'd72};
	wire [14:0] coord_65 = {8'd55, 7'd73};
	wire [14:0] coord_66 = {8'd56, 7'd73};
	wire [14:0] coord_67 = {8'd57, 7'd73}; 
	wire [14:0] coord_68 = {8'd58, 7'd73}; // 111
	wire [14:0] coord_69 = {8'd58, 7'd74};
	wire [14:0] coord_70 = {8'd58, 7'd75};
	wire [14:0] coord_71 = {8'd58, 7'd76};
	wire [14:0] coord_72 = {8'd57, 7'd76};
	wire [14:0] coord_73 = {8'd56, 7'd76};
	wire [14:0] coord_74 = {8'd55, 7'd76};
	
	
	
	// K
	
	wire [14:0] coord_75 = {8'd66, 7'd70};
	wire [14:0] coord_76 = {8'd66, 7'd71};
	wire [14:0] coord_77 = {8'd66, 7'd72};
	wire [14:0] coord_78 = {8'd66, 7'd73};
	wire [14:0] coord_79 = {8'd66, 7'd74};
	wire [14:0] coord_80 = {8'd66, 7'd75};
	wire [14:0] coord_81 = {8'd66, 7'd76};
	wire [14:0] coord_82 = {8'd67, 7'd73};
	wire [14:0] coord_83 = {8'd68, 7'd72};
	wire [14:0] coord_84 = {8'd68, 7'd74};
	wire [14:0] coord_85 = {8'd69, 7'd71};
	wire [14:0] coord_86 = {8'd69, 7'd75};
	wire [14:0] coord_87 = {8'd70, 7'd70};
	wire [14:0] coord_88 = {8'd70, 7'd76};
	    
	
	// E
	wire [14:0] coord_89 = {8'd73, 7'd70};
	wire [14:0] coord_90 = {8'd73, 7'd71};
	wire [14:0] coord_91 = {8'd73, 7'd72};
	wire [14:0] coord_92 = {8'd73, 7'd73};
	wire [14:0] coord_93 = {8'd73, 7'd74};
	wire [14:0] coord_94 = {8'd73, 7'd75};
	wire [14:0] coord_95 = {8'd73, 7'd76};
	wire [14:0] coord_96 = {8'd74, 7'd70};
	wire [14:0] coord_97 = {8'd75, 7'd70};
	wire [14:0] coord_98 = {8'd74, 7'd73};
	wire [14:0] coord_99 = {8'd75, 7'd73};
	wire [14:0] coord_100 = {8'd74, 7'd76};
	wire [14:0] coord_101 = {8'd75, 7'd76};
	
	
	// Y
	wire [14:0] coord_102 = {8'd78, 7'd70};
	wire [14:0] coord_103 = {8'd79, 7'd71};
	wire [14:0] coord_104 = {8'd82, 7'd70};
	wire [14:0] coord_105 = {8'd81, 7'd71};
	wire [14:0] coord_106 = {8'd80, 7'd72};
	wire [14:0] coord_107 = {8'd80, 7'd73};
	wire [14:0] coord_108 = {8'd80, 7'd74};
	wire [14:0] coord_109 = {8'd80, 7'd75};
	wire [14:0] coord_110 = {8'd80, 7'd76};
		
	
	
		always @ (*)
	begin
		case (block_counter)
			9'd0:
			begin
				startup_x = coord_1[14:7] + 7'd23;
				startup_y = coord_1[6:0];
			end 
			9'd1:
			begin
				startup_x = coord_2[14:7] + 7'd23;
				startup_y = coord_2[6:0];
			end   
			9'd2:
			begin
				startup_x = coord_3[14:7] + 7'd23;
				startup_y = coord_3[6:0];
			end
			9'd3:
			begin
				startup_x = coord_4[14:7] + 7'd23;
				startup_y = coord_4[6:0];
			end 
			9'd4:
			begin
				startup_x = coord_5[14:7] + 7'd23;
				startup_y = coord_5[6:0];
			end   
			9'd5:
			begin
				startup_x = coord_6[14:7] + 7'd23;
				startup_y = coord_6[6:0];
			end   
			9'd6:
			begin
				startup_x = coord_7[14:7]+ 7'd23;
				startup_y = coord_7[6:0];
			end   
			9'd7:
			begin
				startup_x = coord_8[14:7]+ 7'd23;
				startup_y = coord_8[6:0];
			end   
			9'd8:
			begin
				startup_x = coord_9[14:7]+ 7'd23;
				startup_y = coord_9[6:0];
			end   
			9'd9:
			begin
				startup_x = coord_10[14:7]+ 7'd23;
				startup_y = coord_10[6:0];
			end   
			9'd10:
			begin
				startup_x = coord_11[14:7]+ 7'd23;
				startup_y = coord_11[6:0];
			end   
			9'd11:
			begin
				startup_x = coord_12[14:7]+ 7'd23;
				startup_y = coord_12[6:0];
			end   
			9'd12:
			begin
				startup_x = coord_13[14:7]+ 7'd23;
				startup_y = coord_13[6:0];
			end   
			9'd13:
			begin
				startup_x = coord_14[14:7]+ 7'd23;
				startup_y = coord_14[6:0];
			end   
			9'd14:
			begin
				startup_x = coord_15[14:7]+ 7'd23;
				startup_y = coord_15[6:0];
			end   
			9'd15:
			begin
				startup_x = coord_16[14:7]+ 7'd23;
				startup_y = coord_16[6:0];
			end   
			9'd16:
			begin
				startup_x = coord_17[14:7]+ 7'd23;
				startup_y = coord_17[6:0];
			end   
			9'd17:
			begin
				startup_x = coord_18[14:7]+ 7'd23;
				startup_y = coord_18[6:0];
			end   
			9'd18:
			begin
				startup_x = coord_19[14:7]+ 7'd23;
				startup_y = coord_19[6:0];
			end   
			9'd19:
			begin
				startup_x = coord_20[14:7]+ 7'd23;
				startup_y = coord_20[6:0];
			end   
			9'd20:
			begin
				startup_x = coord_21[14:7]+ 7'd23;
				startup_y = coord_21[6:0];
			end   
			9'd21:
			begin
				startup_x = coord_22[14:7]+ 7'd23;
				startup_y = coord_22[6:0];
			end   
			9'd22:
			begin
				startup_x = coord_23[14:7]+ 7'd23;
				startup_y = coord_23[6:0];
			end   
			9'd23:
			begin
				startup_x = coord_24[14:7]+ 7'd23;
				startup_y = coord_24[6:0];
			end   
			9'd24:
			begin
				startup_x = coord_25[14:7]+ 7'd23;
				startup_y = coord_25[6:0];
			end   
			9'd25:
			begin
				startup_x = coord_26[14:7]+ 7'd23;
				startup_y = coord_26[6:0];
			end   
			9'd26:
			begin
				startup_x = coord_27[14:7]+ 7'd23;
				startup_y = coord_27[6:0];
			end   
			9'd27:
			begin
				startup_x = coord_28[14:7]+ 7'd23;
				startup_y = coord_28[6:0];
			end   
			9'd28:
			begin
				startup_x = coord_29[14:7]+ 7'd23;
				startup_y = coord_29[6:0];
			end   
			9'd29:
			begin
				startup_x = coord_30[14:7]+ 7'd23;
				startup_y = coord_30[6:0];
			end   
			9'd30:
			begin
				startup_x = coord_31[14:7]+ 7'd23;
				startup_y = coord_31[6:0];
			end   
			9'd31:
			begin
				startup_x = coord_32[14:7]+ 7'd23;
				startup_y = coord_32[6:0];
			end   
			9'd32:
			begin
				startup_x = coord_33[14:7]+ 7'd23;
				startup_y = coord_33[6:0];
			end   
			9'd33:
			begin
				startup_x = coord_34[14:7]+ 7'd23;
				startup_y = coord_34[6:0];
			end   
			9'd34:
			begin
				startup_x = coord_35[14:7]+ 7'd23;
				startup_y = coord_35[6:0];
			end   
			9'd35:
			begin
				startup_x = coord_36[14:7]+ 7'd23;
				startup_y = coord_36[6:0];
			end   
			9'd36:
			begin
				startup_x = coord_37[14:7]+ 7'd23;
				startup_y = coord_37[6:0];
			end   
			9'd37:
			begin
				startup_x = coord_38[14:7]+ 7'd23;
				startup_y = coord_38[6:0];
			end   
			9'd38:
			begin
				startup_x = coord_39[14:7]+ 7'd23;
				startup_y = coord_39[6:0];
			end   
			9'd39:
			begin
				startup_x = coord_40[14:7]+ 7'd23;
				startup_y = coord_40[6:0];
			end   
			9'd40:
			begin
				startup_x = coord_41[14:7]+ 7'd23;
				startup_y = coord_41[6:0];
			end   
			9'd41:
			begin
				startup_x = coord_42[14:7]+ 7'd23;
				startup_y = coord_42[6:0];
			end   
			9'd42:
			begin
				startup_x = coord_43[14:7]+ 7'd23;
				startup_y = coord_43[6:0];
			end   
			9'd43:
			begin
				startup_x = coord_44[14:7]+ 7'd23;
				startup_y = coord_44[6:0];
			end   
			9'd44:
			begin
				startup_x = coord_45[14:7]+ 7'd23;
				startup_y = coord_45[6:0];
			end   
			9'd45:
			begin
				startup_x = coord_46[14:7]+ 7'd23;
				startup_y = coord_46[6:0];
			end   
			9'd46:
			begin
				startup_x = coord_47[14:7]+ 7'd23;
				startup_y = coord_47[6:0];
			end   
			9'd47:
			begin
				startup_x = coord_48[14:7]+ 7'd23;
				startup_y = coord_48[6:0];
			end   
			9'd48:
			begin
				startup_x = coord_49[14:7]+ 7'd23;
				startup_y = coord_49[6:0];
			end   
			9'd49:
			begin
				startup_x = coord_50[14:7]+ 7'd23;
				startup_y = coord_50[6:0];
			end   
			9'd50:
			begin
				startup_x = coord_51[14:7]+ 7'd23;
				startup_y = coord_51[6:0];
			end   
			9'd51:
			begin
				startup_x = coord_52[14:7]+ 7'd23;
				startup_y = coord_52[6:0];
			end   
			9'd52:
			begin
				startup_x = coord_53[14:7]+ 7'd23;
				startup_y = coord_53[6:0];
			end   
			9'd53:
			begin
				startup_x = coord_54[14:7]+ 7'd23;
				startup_y = coord_54[6:0];
			end   
			9'd54:
			begin
				startup_x = coord_55[14:7]+ 7'd23;
				startup_y = coord_55[6:0];
			end   
			9'd55:
			begin
				startup_x = coord_56[14:7]+ 7'd23;
				startup_y = coord_56[6:0];
			end   
			9'd56:
			begin
				startup_x = coord_57[14:7]+ 7'd23;
				startup_y = coord_57[6:0];
			end   
			9'd57:
			begin
				startup_x = coord_58[14:7]+ 7'd23;
				startup_y = coord_58[6:0];
			end   
			9'd58:
			begin
				startup_x = coord_59[14:7]+ 7'd23;
				startup_y = coord_59[6:0];
			end   
			9'd59:
			begin
				startup_x = coord_60[14:7]+ 7'd23;
				startup_y = coord_60[6:0];
			end   
			9'd60:
			begin
				startup_x = coord_61[14:7]+ 7'd23;
				startup_y = coord_61[6:0];
			end   
			9'd61:
			begin
				startup_x = coord_62[14:7]+ 7'd23;
				startup_y = coord_62[6:0];
			end   
			9'd62:
			begin
				startup_x = coord_63[14:7]+ 7'd23;
				startup_y = coord_63[6:0];
			end   
			9'd63:
			begin
				startup_x = coord_64[14:7]+ 7'd23;
				startup_y = coord_64[6:0];
			end   
			9'd64:
			begin
				startup_x = coord_65[14:7]+ 7'd23;
				startup_y = coord_65[6:0];
			end   
			9'd65:
			begin
				startup_x = coord_66[14:7]+ 7'd23;
				startup_y = coord_66[6:0];
			end   
			9'd66:
			begin
				startup_x = coord_67[14:7]+ 7'd23;
				startup_y = coord_67[6:0];
			end   
			9'd67:
			begin
				startup_x = coord_68[14:7]+ 7'd23;
				startup_y = coord_68[6:0];
			end   
			9'd68:
			begin
				startup_x = coord_69[14:7]+ 7'd23;
				startup_y = coord_69[6:0];
			end   
			9'd69:
			begin
				startup_x = coord_70[14:7]+ 7'd23;
				startup_y = coord_70[6:0];
			end   
			9'd70:
			begin
				startup_x = coord_71[14:7]+ 7'd23;
				startup_y = coord_71[6:0];
			end   
			9'd71:
			begin
				startup_x = coord_72[14:7]+ 7'd23;
				startup_y = coord_72[6:0];
			end   
			9'd72:
			begin
				startup_x = coord_73[14:7]+ 7'd23;
				startup_y = coord_73[6:0];
			end   
			9'd73:
			begin
				startup_x = coord_74[14:7]+ 7'd23;
				startup_y = coord_74[6:0];
			end   
			9'd74:
			begin
				startup_x = coord_75[14:7]+ 7'd23;
				startup_y = coord_75[6:0];
			end   
			9'd75:
			begin
				startup_x = coord_76[14:7]+ 7'd23;
				startup_y = coord_76[6:0];
			end   
			9'd76:
			begin
				startup_x = coord_77[14:7]+ 7'd23;
				startup_y = coord_77[6:0];
			end   
			9'd77:
			begin
				startup_x = coord_78[14:7]+ 7'd23;
				startup_y = coord_78[6:0];
			end   
			9'd78:
			begin
				startup_x = coord_79[14:7]+ 7'd23;
				startup_y = coord_79[6:0];
			end   
			9'd79:
			begin
				startup_x = coord_80[14:7]+ 7'd23;
				startup_y = coord_80[6:0];
			end   
			9'd80:
			begin
				startup_x = coord_81[14:7]+ 7'd23;
				startup_y = coord_81[6:0];
			end   
			9'd81:
			begin
				startup_x = coord_82[14:7]+ 7'd23;
				startup_y = coord_82[6:0];
			end   
			9'd82:
			begin
				startup_x = coord_83[14:7]+ 7'd23;
				startup_y = coord_83[6:0];
			end   
			9'd83:
			begin
				startup_x = coord_84[14:7]+ 7'd23;
				startup_y = coord_84[6:0];
			end   
			9'd84:
			begin
				startup_x = coord_85[14:7]+ 7'd23;
				startup_y = coord_85[6:0];
			end   
			9'd85:
			begin
				startup_x = coord_86[14:7]+ 7'd23;
				startup_y = coord_86[6:0];
			end   
			9'd86:
			begin
				startup_x = coord_87[14:7]+ 7'd23;
				startup_y = coord_87[6:0];
			end   
			9'd87:
			begin
				startup_x = coord_88[14:7]+ 7'd23;
				startup_y = coord_88[6:0];
			end   
			9'd88:
			begin
				startup_x = coord_89[14:7]+ 7'd23;
				startup_y = coord_89[6:0];
			end   
			9'd89:
			begin
				startup_x = coord_90[14:7] + 7'd23;
				startup_y = coord_90[6:0];
			end   
			9'd90:
			begin
				startup_x = coord_91[14:7]+ 7'd23;
				startup_y = coord_91[6:0];
			end   
			9'd91:
			begin
				startup_x = coord_92[14:7]+ 7'd23;
				startup_y = coord_92[6:0];
			end   
			9'd92:
			begin
				startup_x = coord_93[14:7]+ 7'd23;
				startup_y = coord_93[6:0];
			end   
			9'd93:
			begin
				startup_x = coord_94[14:7]+ 7'd23;
				startup_y = coord_94[6:0];
			end   
			9'd94:
			begin
				startup_x = coord_95[14:7]+ 7'd23;
				startup_y = coord_95[6:0];
			end   
			9'd95:
			begin
				startup_x = coord_96[14:7]+ 7'd23;
				startup_y = coord_96[6:0];
			end   
			9'd96:
			begin
				startup_x = coord_97[14:7]+ 7'd23;
				startup_y = coord_97[6:0];
			end   
			9'd97:
			begin
				startup_x = coord_98[14:7]+ 7'd23;
				startup_y = coord_98[6:0];
			end   
			9'd98:
			begin
				startup_x = coord_99[14:7]+ 7'd23;
				startup_y = coord_99[6:0];
			end   
			9'd99:
			begin
				startup_x = coord_100[14:7]+ 7'd23;
				startup_y = coord_100[6:0];
			end   
			9'd100:
			begin
				startup_x = coord_101[14:7]+ 7'd23;
				startup_y = coord_101[6:0];
			end   
			9'd101:
			begin
				startup_x = coord_102[14:7]+ 7'd23;
				startup_y = coord_102[6:0];
			end   
			9'd102:
			begin
				startup_x = coord_103[14:7]+ 7'd23;
				startup_y = coord_103[6:0];
			end   
			9'd103:
			begin
				startup_x = coord_104[14:7]+ 7'd23;
				startup_y = coord_104[6:0];
			end   
			9'd104:
			begin
				startup_x = coord_105[14:7]+ 7'd23;
				startup_y = coord_105[6:0];
			end   
			9'd105:
			begin
				startup_x = coord_106[14:7]+ 7'd23;
				startup_y = coord_106[6:0];
			end   
			9'd106:
			begin
				startup_x = coord_107[14:7]+ 7'd23;
				startup_y = coord_107[6:0];
			end   
			9'd107:
			begin
				startup_x = coord_108[14:7]+ 7'd23;
				startup_y = coord_108[6:0];
			end   
			9'd108:
			begin
				startup_x = coord_109[14:7]+ 7'd23;
				startup_y = coord_109[6:0];
			end   
			9'd109:
			begin
				startup_x = coord_110[14:7]+ 7'd23;
				startup_y = coord_110[6:0];
			end 
		endcase   
	end
	
endmodule
 		
				