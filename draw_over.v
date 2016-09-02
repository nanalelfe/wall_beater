module draw_over(clock, reset_over_counter, enable_over_counter, over_x, over_y, block_counter_over);
       
    input clock, reset_over_counter, enable_over_counter;  
    reg [7:0] startup_x;
    reg [6:0] startup_y;  
    
    output [7:0] over_x;
    output [6:0] over_y;
    
    assign over_x = startup_x;
    assign over_y = startup_y;
    
    output reg [8:0] block_counter_over;   

	always @ (posedge clock)
	begin
		if (!reset_over_counter)
			begin
			block_counter_over <= 9'd0;
			end
		else if (enable_over_counter)
			begin 
			if (block_counter_over == 9'd246)
				block_counter_over <= 9'd0;
			else 
				block_counter_over <= block_counter_over + 1;
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
	
	// GAME OVER
	
	// G
	wire [14:0] coord_111 = {8'd55, 7'd44};
	wire [14:0] coord_112 = {8'd55, 7'd45};
	wire [14:0] coord_113 = {8'd55, 7'd46};
	wire [14:0] coord_114 = {8'd55, 7'd47};
	wire [14:0] coord_115 = {8'd55, 7'd48};
	wire [14:0] coord_116 = {8'd55, 7'd49};
	wire [14:0] coord_117 = {8'd55, 7'd50};
	wire [14:0] coord_118 = {8'd56, 7'd44};
	wire [14:0] coord_119 = {8'd57, 7'd44};
	wire [14:0] coord_120 = {8'd58, 7'd44};
	wire [14:0] coord_121 = {8'd59, 7'd44};
	wire [14:0] coord_122 = {8'd56, 7'd50};
	wire [14:0] coord_123 = {8'd57, 7'd50};
	wire [14:0] coord_124 = {8'd58, 7'd50};
	wire [14:0] coord_125 = {8'd59, 7'd50};
	wire [14:0] coord_126 = {8'd59, 7'd49};
	wire [14:0] coord_127 = {8'd59, 7'd48};
	wire [14:0] coord_128 = {8'd59, 7'd47};
	wire [14:0] coord_129 = {8'd58, 7'd47};
	
	
	// A
	wire [14:0] coord_130 = {8'd64, 7'd44};
	wire [14:0] coord_131 = {8'd63, 7'd45};
	wire [14:0] coord_132 = {8'd65, 7'd45};
	wire [14:0] coord_133 = {8'd62, 7'd46};
	wire [14:0] coord_134 = {8'd62, 7'd47};
	wire [14:0] coord_135 = {8'd62, 7'd48};
	wire [14:0] coord_136 = {8'd62, 7'd49};
	wire [14:0] coord_137 = {8'd62, 7'd50};
	wire [14:0] coord_138 = {8'd63, 7'd48};
	wire [14:0] coord_139 = {8'd64, 7'd48};
	wire [14:0] coord_140 = {8'd65, 7'd48};
	wire [14:0] coord_141 = {8'd66, 7'd46};
	wire [14:0] coord_142 = {8'd66, 7'd47};
	wire [14:0] coord_143 = {8'd66, 7'd48};
	wire [14:0] coord_144 = {8'd66, 7'd49};
	wire [14:0] coord_145 = {8'd66, 7'd50};
	
	// M
	
	wire [14:0] coord_146 = {8'd69, 7'd44};
	wire [14:0] coord_147 = {8'd69, 7'd45};
	wire [14:0] coord_148 = {8'd69, 7'd46};
	wire [14:0] coord_149 = {8'd69, 7'd47};
	wire [14:0] coord_150 = {8'd69, 7'd48};
	wire [14:0] coord_151 = {8'd69, 7'd49};
	wire [14:0] coord_152 = {8'd69, 7'd50};
	wire [14:0] coord_153 = {8'd70, 7'd45};
	wire [14:0] coord_154 = {8'd71, 7'd46};
	wire [14:0] coord_155 = {8'd72, 7'd45};
	wire [14:0] coord_156 = {8'd73, 7'd44};
	wire [14:0] coord_157 = {8'd73, 7'd45};
	wire [14:0] coord_158 = {8'd73, 7'd46};
	wire [14:0] coord_159 = {8'd73, 7'd47};
	wire [14:0] coord_160 = {8'd73, 7'd48};
	wire [14:0] coord_161 = {8'd73, 7'd49};
	wire [14:0] coord_162 = {8'd73, 7'd50};
	
	
	// E
	
	wire [14:0] coord_163 = {8'd76, 7'd44};
	wire [14:0] coord_164 = {8'd76, 7'd45};
	wire [14:0] coord_165 = {8'd76, 7'd46};
	wire [14:0] coord_166 = {8'd76, 7'd47};
	wire [14:0] coord_167 = {8'd76, 7'd48};
	wire [14:0] coord_168 = {8'd76, 7'd49};
	wire [14:0] coord_169 = {8'd76, 7'd50};
	wire [14:0] coord_170 = {8'd77, 7'd44};
	wire [14:0] coord_171 = {8'd78, 7'd44};
	wire [14:0] coord_172 = {8'd79, 7'd44};
	wire [14:0] coord_173 = {8'd77, 7'd47};
	wire [14:0] coord_174 = {8'd78, 7'd47};
	wire [14:0] coord_175 = {8'd77, 7'd50};
	wire [14:0] coord_176 = {8'd78, 7'd50};
	wire [14:0] coord_177 = {8'd79, 7'd50};
	
	// O
	
	wire [14:0] coord_178 = {8'd85, 7'd44};
	wire [14:0] coord_179 = {8'd86, 7'd44};
	wire [14:0] coord_180 = {8'd87, 7'd44};
	wire [14:0] coord_181 = {8'd84, 7'd45};
	wire [14:0] coord_182 = {8'd84, 7'd46};
	wire [14:0] coord_183 = {8'd84, 7'd47};
	wire [14:0] coord_184 = {8'd84, 7'd48};
	wire [14:0] coord_185 = {8'd84, 7'd49};
	wire [14:0] coord_186 = {8'd85, 7'd50};
	wire [14:0] coord_187 = {8'd86, 7'd50};
	wire [14:0] coord_188 = {8'd87, 7'd50};
	wire [14:0] coord_189 = {8'd88, 7'd45};
	wire [14:0] coord_190 = {8'd88, 7'd46};
	wire [14:0] coord_191 = {8'd88, 7'd47};
	wire [14:0] coord_192 = {8'd88, 7'd48};
	wire [14:0] coord_193 = {8'd88, 7'd49};
	
	// V
	
	wire [14:0] coord_194 = {8'd91, 7'd44};
	wire [14:0] coord_195 = {8'd91, 7'd45};
	wire [14:0] coord_196 = {8'd91, 7'd46};
	wire [14:0] coord_197 = {8'd92, 7'd47};
	wire [14:0] coord_198 = {8'd92, 7'd48};
	wire [14:0] coord_199 = {8'd93, 7'd49};
	wire [14:0] coord_200 = {8'd93, 7'd50};
	wire [14:0] coord_201 = {8'd94, 7'd48};
	wire [14:0] coord_202 = {8'd94, 7'd47};
	wire [14:0] coord_203 = {8'd95, 7'd46};
	wire [14:0] coord_204 = {8'd95, 7'd45};
	wire [14:0] coord_205 = {8'd95, 7'd44};
	
	//E
	
	wire [14:0] coord_206 = {8'd76 + 8'd22, 7'd44};
	wire [14:0] coord_207 = {8'd76+ 8'd22, 7'd45};
	wire [14:0] coord_208 = {8'd76+ 8'd22, 7'd46};
	wire [14:0] coord_209 = {8'd76+ 8'd22, 7'd47};
	wire [14:0] coord_210 = {8'd76+ 8'd22, 7'd48};
	wire [14:0] coord_211 = {8'd76+ 8'd22, 7'd49};
	wire [14:0] coord_212 = {8'd76+ 8'd22, 7'd50};
	wire [14:0] coord_223 = {8'd77+ 8'd22, 7'd44};
	wire [14:0] coord_224 = {8'd78+ 8'd22, 7'd44};
	wire [14:0] coord_225 = {8'd79+ 8'd22, 7'd44};
	wire [14:0] coord_226 = {8'd77+ 8'd22, 7'd47};
	wire [14:0] coord_227 = {8'd78+ 8'd22, 7'd47};
	wire [14:0] coord_228 = {8'd77+ 8'd22, 7'd50};
	wire [14:0] coord_229 = {8'd78+ 8'd22, 7'd50};
	wire [14:0] coord_230 = {8'd79+ 8'd22, 7'd50};
	
	
	// R
	
	wire [14:0] coord_231 = {8'd104, 7'd44};
	wire [14:0] coord_232 = {8'd105, 7'd44};
	wire [14:0] coord_233 = {8'd106, 7'd44};
	wire [14:0] coord_234 = {8'd107, 7'd44};
	wire [14:0] coord_235 = {8'd104, 7'd45};
	wire [14:0] coord_236 = {8'd104, 7'd46};
	wire [14:0] coord_237 = {8'd104, 7'd47};
	wire [14:0] coord_238 = {8'd104, 7'd48};
	wire [14:0] coord_239 = {8'd104, 7'd49};
	wire [14:0] coord_240 = {8'd104, 7'd50};
	wire [14:0] coord_241 = {8'd105, 7'd47};
	wire [14:0] coord_242 = {8'd106, 7'd47};
	wire [14:0] coord_243 = {8'd107, 7'd45};
	wire [14:0] coord_244 = {8'd107, 7'd46};
	wire [14:0] coord_245 = {8'd107, 7'd48};
	wire [14:0] coord_246 = {8'd107, 7'd49};
	wire [14:0] coord_247 = {8'd107, 7'd50};	
	
	always @ (*)
	begin
		case (block_counter_over)
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
				startup_x = coord_90[14:7]+ 7'd23;
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
			9'd110:
			begin
				startup_x = coord_110[14:7];
				startup_y = coord_110[6:0];
			end
			9'd111:
			begin
				startup_x = coord_111[14:7];
				startup_y = coord_111[6:0];
			end
			9'd112:
			begin
				startup_x = coord_112[14:7];
				startup_y = coord_112[6:0];
			end
			9'd113:
			begin
				startup_x = coord_113[14:7];
				startup_y = coord_113[6:0];
			end
			9'd114:
			begin
				startup_x = coord_114[14:7];
				startup_y = coord_114[6:0];
			end
			9'd115:
			begin
				startup_x = coord_115[14:7];
				startup_y = coord_115[6:0];
			end
			9'd116:
			begin
				startup_x = coord_116[14:7];
				startup_y = coord_116[6:0];
			end
			9'd117:
			begin
				startup_x = coord_117[14:7];
				startup_y = coord_117[6:0];
			end
			9'd118:
			begin
				startup_x = coord_118[14:7];
				startup_y = coord_118[6:0];
			end
			9'd119:
			begin
				startup_x = coord_119[14:7];
				startup_y = coord_119[6:0];
			end
			9'd120:
			begin
				startup_x = coord_120[14:7];
				startup_y = coord_120[6:0];
			end
			9'd121:
			begin
				startup_x = coord_121[14:7];
				startup_y = coord_121[6:0];
			end
			9'd122:
			begin
				startup_x = coord_122[14:7];
				startup_y = coord_122[6:0];
			end
			9'd123:
			begin
				startup_x = coord_123[14:7];
				startup_y = coord_123[6:0];
			end
			9'd124:
			begin
				startup_x = coord_124[14:7];
				startup_y = coord_124[6:0];
			end
			9'd125:
			begin
				startup_x = coord_125[14:7];
				startup_y = coord_125[6:0];
			end
			9'd126:
			begin
				startup_x = coord_130[14:7];
				startup_y = coord_130[6:0];
			end
			9'd127:
			begin
				startup_x = coord_131[14:7];
				startup_y = coord_131[6:0];
			end
			9'd128:
			begin
				startup_x = coord_132[14:7];
				startup_y = coord_132[6:0];
			end
			9'd129:
			begin
				startup_x = coord_133[14:7];
				startup_y = coord_133[6:0];
			end
			9'd130:
			begin
				startup_x = coord_134[14:7];
				startup_y = coord_134[6:0];
			end
			9'd131:
			begin
				startup_x = coord_135[14:7];
				startup_y = coord_135[6:0];
			end
			9'd132:
			begin
				startup_x = coord_136[14:7];
				startup_y = coord_136[6:0];
			end
			9'd133:
			begin
				startup_x = coord_137[14:7];
				startup_y = coord_137[6:0];
			end
			9'd134:
			begin
				startup_x = coord_138[14:7];
				startup_y = coord_138[6:0];
			end
			9'd135:
			begin
				startup_x = coord_139[14:7];
				startup_y = coord_139[6:0];
			end
			9'd136:
			begin
				startup_x = coord_140[14:7];
				startup_y = coord_140[6:0];
			end
			9'd137:
			begin
				startup_x = coord_141[14:7];
				startup_y = coord_141[6:0];
			end
			9'd138:
			begin
				startup_x = coord_142[14:7];
				startup_y = coord_142[6:0];
			end
			9'd139:
			begin
				startup_x = coord_143[14:7];
				startup_y = coord_143[6:0];
			end
			9'd140:
			begin
				startup_x = coord_144[14:7];
				startup_y = coord_144[6:0];
			end
			9'd141:
			begin
				startup_x = coord_145[14:7];
				startup_y = coord_145[6:0];
			end
			9'd142:
			begin
				startup_x = coord_146[14:7];
				startup_y = coord_146[6:0];
			end
			9'd143:
			begin
				startup_x = coord_147[14:7];
				startup_y = coord_147[6:0];
			end
			9'd144:
			begin
				startup_x = coord_148[14:7];
				startup_y = coord_148[6:0];
			end
			9'd145:
			begin
				startup_x = coord_149[14:7];
				startup_y = coord_149[6:0];
			end
			9'd146:
			begin
				startup_x = coord_150[14:7];
				startup_y = coord_150[6:0];
			end
			9'd147:
			begin
				startup_x = coord_151[14:7];
				startup_y = coord_151[6:0];
			end
			9'd148:
			begin
				startup_x = coord_152[14:7];
				startup_y = coord_152[6:0];
			end
			9'd149:
			begin
				startup_x = coord_153[14:7];
				startup_y = coord_153[6:0];
			end
			9'd150:
			begin
				startup_x = coord_154[14:7];
				startup_y = coord_154[6:0];
			end
			9'd151:
			begin
				startup_x = coord_155[14:7];
				startup_y = coord_155[6:0];
			end
			9'd152:
			begin
				startup_x = coord_156[14:7];
				startup_y = coord_156[6:0];
			end
			9'd153:
			begin
				startup_x = coord_157[14:7];
				startup_y = coord_157[6:0];
			end
			9'd154:
			begin
				startup_x = coord_158[14:7];
				startup_y = coord_158[6:0];
			end
			9'd155:
			begin
				startup_x = coord_159[14:7];
				startup_y = coord_159[6:0];
			end
			9'd156:
			begin
				startup_x = coord_160[14:7];
				startup_y = coord_160[6:0];
			end
			9'd157:
			begin
				startup_x = coord_161[14:7];
				startup_y = coord_161[6:0];
			end
			9'd158:
			begin
				startup_x = coord_162[14:7];
				startup_y = coord_162[6:0];
			end
			9'd159:
			begin
				startup_x = coord_163[14:7];
				startup_y = coord_163[6:0];
			end
			9'd160:
			begin
				startup_x = coord_164[14:7];
				startup_y = coord_164[6:0];
			end
			9'd161:
			begin
				startup_x = coord_165[14:7];
				startup_y = coord_165[6:0];
			end
			9'd162:
			begin
				startup_x = coord_166[14:7];
				startup_y = coord_166[6:0];
			end
			9'd163:
			begin
				startup_x = coord_167[14:7];
				startup_y = coord_167[6:0];
			end
			9'd164:
			begin
				startup_x = coord_168[14:7];
				startup_y = coord_168[6:0];
			end
			9'd165:
			begin
				startup_x = coord_169[14:7];
				startup_y = coord_169[6:0];
			end
			9'd166:
			begin
				startup_x = coord_170[14:7];
				startup_y = coord_170[6:0];
			end
			9'd167:
			begin
				startup_x = coord_171[14:7];
				startup_y = coord_171[6:0];
			end
			9'd168:
			begin
				startup_x = coord_172[14:7];
				startup_y = coord_172[6:0];
			end
			9'd169:
			begin
				startup_x = coord_173[14:7];
				startup_y = coord_173[6:0];
			end
			9'd170:
			begin
				startup_x = coord_174[14:7];
				startup_y = coord_174[6:0];
			end
			9'd171:
			begin
				startup_x = coord_175[14:7];
				startup_y = coord_175[6:0];
			end
			9'd172:
			begin
				startup_x = coord_176[14:7];
				startup_y = coord_176[6:0];
			end
			9'd173:
			begin
				startup_x = coord_177[14:7];
				startup_y = coord_177[6:0];
			end
			9'd174:
			begin
				startup_x = coord_178[14:7];
				startup_y = coord_178[6:0];
			end
			9'd175:
			begin
				startup_x = coord_179[14:7];
				startup_y = coord_179[6:0];
			end
			9'd176:
			begin
				startup_x = coord_180[14:7];
				startup_y = coord_180[6:0];
			end
			9'd177:
			begin
				startup_x = coord_181[14:7];
				startup_y = coord_181[6:0];
			end
			9'd178:
			begin
				startup_x = coord_182[14:7];
				startup_y = coord_182[6:0];
			end
			9'd179:
			begin
				startup_x = coord_183[14:7];
				startup_y = coord_183[6:0];
			end                    
			9'd180:
			begin
				startup_x = coord_184[14:7];
				startup_y = coord_184[6:0];
			end
			9'd181:
			begin
				startup_x = coord_185[14:7];
				startup_y = coord_185[6:0];
			end
			9'd182:
			begin
				startup_x = coord_186[14:7];
				startup_y = coord_186[6:0];
			end
			9'd183:
			begin
				startup_x = coord_187[14:7];
				startup_y = coord_187[6:0];
			end
			9'd184:
			begin
				startup_x = coord_188[14:7];
				startup_y = coord_188[6:0];
			end
			9'd185:
			begin
				startup_x = coord_189[14:7];
				startup_y = coord_189[6:0];
			end
			9'd186:
			begin
				startup_x = coord_190[14:7];
				startup_y = coord_190[6:0];
			end
			9'd187:
			begin
				startup_x = coord_191[14:7];
				startup_y = coord_191[6:0];
			end
			9'd188:
			begin
				startup_x = coord_192[14:7];
				startup_y = coord_192[6:0];
			end
			9'd189:
			begin
				startup_x = coord_194[14:7];
				startup_y = coord_194[6:0];
			end
			9'd190:
			begin
				startup_x = coord_195[14:7];
				startup_y = coord_195[6:0];
			end
			9'd191:
			begin
				startup_x = coord_196[14:7];
				startup_y = coord_196[6:0];
			end
			9'd192:
			begin
				startup_x = coord_197[14:7];
				startup_y = coord_197[6:0];
			end
			9'd193:
			begin
				startup_x = coord_198[14:7];
				startup_y = coord_198[6:0];
			end
			9'd194:
			begin
				startup_x = coord_199[14:7];
				startup_y = coord_199[6:0];
			end
			9'd195:
			begin
				startup_x = coord_200[14:7];
				startup_y = coord_200[6:0];
			end
			9'd196:
			begin
				startup_x = coord_201[14:7];
				startup_y = coord_201[6:0];
			end
			9'd197:
			begin
				startup_x = coord_202[14:7];
				startup_y = coord_202[6:0];
			end
			9'd198:
			begin
				startup_x = coord_203[14:7];
				startup_y = coord_203[6:0];
			end
			9'd199:
			begin
				startup_x = coord_204[14:7];
				startup_y = coord_204[6:0];
			end
			9'd200:
			begin
				startup_x = coord_205[14:7];
				startup_y = coord_205[6:0];
			end
			9'd201:
			begin
				startup_x = coord_206[14:7];
				startup_y = coord_206[6:0];
			end
			9'd202:
			begin
				startup_x = coord_207[14:7];
				startup_y = coord_207[6:0];
			end
			9'd203:
			begin
				startup_x = coord_208[14:7];
				startup_y = coord_208[6:0];
			end
			9'd204:
			begin
				startup_x = coord_209[14:7];
				startup_y = coord_209[6:0];
			end
			9'd205:
			begin
				startup_x = coord_210[14:7];
				startup_y = coord_210[6:0];
			end
			9'd206:
			begin
				startup_x = coord_211[14:7];
				startup_y = coord_211[6:0];
			end
			9'd207:
			begin
				startup_x = coord_212[14:7];
				startup_y = coord_212[6:0];
			end
			9'd208:
			begin
				startup_x = coord_193[14:7];
				startup_y = coord_193[6:0];
			end
			9'd209:
			begin
			end	
			9'd210:
			begin
				
			end
			9'd211:
			begin
				
			end
			9'd212:
			begin
				
			end
			9'd213:
			begin
				
			end
			9'd214:
			begin
				
			end
			9'd215:
			begin
				
			end
			9'd216:
			begin
				
			end
			9'd217:
			begin
				
			end
			9'd218:
			begin
				startup_x = coord_223[14:7];
				startup_y = coord_223[6:0];
			end
			9'd219:
			begin
				startup_x = coord_224[14:7];
				startup_y = coord_224[6:0];
			end
			9'd220:
			begin
				startup_x = coord_225[14:7];
				startup_y = coord_225[6:0];
			end
			9'd221:
			begin
				startup_x = coord_226[14:7];
				startup_y = coord_226[6:0];
			end
			9'd222:
			begin
				startup_x = coord_227[14:7];
				startup_y = coord_227[6:0];
			end
			9'd223:
			begin
				startup_x = coord_228[14:7];
				startup_y = coord_228[6:0];
			end
			9'd224:
			begin
				startup_x = coord_229[14:7];
				startup_y = coord_229[6:0];
			end
			9'd225:
			begin
				startup_x = coord_230[14:7];
				startup_y = coord_230[6:0];
			end
			9'd226:
			begin
				startup_x = coord_231[14:7];
				startup_y = coord_231[6:0];
			end
			9'd227:
			begin
				startup_x = coord_232[14:7];
				startup_y = coord_232[6:0];
			end
			9'd228:
			begin
				startup_x = coord_233[14:7];
				startup_y = coord_233[6:0];
			end
			9'd229:
			begin
				startup_x = coord_234[14:7];
				startup_y = coord_234[6:0];
			end
			9'd230:
			begin
				startup_x = coord_235[14:7];
				startup_y = coord_235[6:0];
			end
			9'd231:
			begin
				startup_x = coord_236[14:7];
				startup_y = coord_236[6:0];
			end
			9'd232:
			begin
				startup_x = coord_237[14:7];
				startup_y = coord_237[6:0];
			end
			9'd233:
			begin
				startup_x = coord_238[14:7];
				startup_y = coord_238[6:0];
			end
			9'd234:
			begin
				startup_x = coord_239[14:7];
				startup_y = coord_239[6:0];
			end
			9'd235:
			begin
				startup_x = coord_240[14:7];
				startup_y = coord_240[6:0];
			end
			9'd236:
			begin
				startup_x = coord_241[14:7];
				startup_y = coord_241[6:0];
			end
			9'd237:
			begin
				startup_x = coord_242[14:7];
				startup_y = coord_242[6:0];
			end
			9'd238:
			begin
				startup_x = coord_243[14:7];
				startup_y = coord_243[6:0];
			end
			9'd239:
			begin
				startup_x = coord_244[14:7];
				startup_y = coord_244[6:0];
			end
			9'd240:
			begin
				startup_x = coord_245[14:7];
				startup_y = coord_245[6:0];
			end
			9'd241:
			begin
				startup_x = coord_246[14:7];
				startup_y = coord_246[6:0];
			end
			9'd242:
			begin
				startup_x = coord_247[14:7];
				startup_y = coord_247[6:0];
			end
			9'd243:
			begin
				startup_x = coord_126[14:7];
				startup_y = coord_126[6:0];
			end
			9'd244:
			begin
				startup_x = coord_127[14:7];
				startup_y = coord_127[6:0];
			end
			9'd245:
			begin
				startup_x = coord_128[14:7];
				startup_y = coord_128[6:0];
			end
			9'd246:
			begin
				startup_x = coord_129[14:7];
				startup_y = coord_129[6:0];
			end
	
		endcase   
	end
	
endmodule
 		
				