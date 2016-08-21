//
`define top cdu
// 
// This Verilog file should be used for Custom Verilog HDL only
// 
`timescale 1 ps/ 1 ps
module stratix_async_input (regin, ddioregin, padio, delayctrlin, combout, regout, ddioregout);
input regin, ddioregin, delayctrlin ,padio ;
output combout, regout, ddioregout;

supply0 VSS;
supply1 VDD;
bd tlib000162 ( .z(padio_delayed), .a(padio) );
mx21 tlib000163 ( .z(combout) , .a(padio) , .b(padio_delayed) , .sb(delayctrlin) );
b1 tlib000164 ( .z(regout), .a(regin) );
b1 tlib000165 ( .z(ddioregout), .a(ddioregin) );
endmodule

module stratix_io_register (clk, datain, ena, sreset, areset, devclrn, devpor, regout, power_up, async_preset, async_clear, sync_preset, sync_clear );
input clk, ena, datain, areset, sreset, devclrn, devpor ,power_up, async_preset, async_clear, sync_preset, sync_clear ;

output regout;
supply0 VSS;
supply1 VDD;
mx21 tlib000171 ( .z(power_up_high), .a( 1'b1 ), .b(devpor), .sb(power_up) );
mx21 tlib000172 ( .z(power_up_low), .a(devpor), .b( 1'b1 ), .sb(power_up) );
mx21i tlib000173 ( .zn(areset_preset), .a( 1'b0 ), .b(areset), .sb(async_preset) );
mx21i tlib000174 ( .zn(areset_clear), .a( 1'b0 ), .b(areset), .sb(async_clear) );
an2 tlib000175 ( .z(nset), .a(power_up_high), .b(areset_preset) );
an3 tlib000176 ( .z(nreset), .a(power_up_low), .b(areset_clear), .c(devclrn) );
mx21 tlib000177 ( .z(u3z), .a(datain), .b( 1'b1 ), .sb(sync_preset) );
mx21 tlib000178 ( .z(u4z), .a(u3z), .b( 1'b0 ), .sb(sync_clear) );
mx21 tlib000179 ( .z(data), .a(datain), .b(u4z), .sb(u8z) );
an2 tlib000180 ( .z(u6z), .a(sreset), .b(sync_preset) );
an2 tlib000181 ( .z(u7z), .a(sreset), .b(sync_clear) );
or2 tlib000182 ( .z(u8z), .a(u6z), .b(u7z) );
dspbrs tlib000183 ( .q(regout) , .c(clk) , .d(regout) , .rn(nreset) , .sd(data) , .se(ena) , .sn(nset) );
endmodule

module stratix_input_0XXX0XXUUXX00000 ( padio, combout );
input padio ;

output combout ;

supply0 VSS;
supply1 VDD;
ic tlib000204 ( .z(padio_net), .pad(padio) );
stratix_io_register tlib000205 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_net), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000206 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000207 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_net), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000208 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_async_input tlib000209 ( .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio(padio_net), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout) );
endmodule

module x_lut4_0x0f0f ( i2, o );

input i2 ;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst016097  ( .a(i2), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0f0f ( dataa, datac, inverta, combout );
input dataa, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0f0f tlib000004 (  .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0f0f ( dataa, datac, inverta, combout );

input dataa, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f0f tlib000001 (  .dataa(dataa), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module stratix_async_inout (datain, oe, regin, ddioregin, padio_input, padio_internal, combout, padio_enable, delayctrlin, regout, ddioregout, open_drain_output);
input datain, oe, regin, ddioregin, delayctrlin, padio_input, open_drain_output;
output combout, regout, ddioregout, padio_internal, padio_enable;
supply0 VSS;
supply1 VDD;
bd tlib000155 ( .z(padio_input_delayed), .a(padio_input) );
mx21 tlib000156 ( .z(combout) , .a(padio_input) , .b(padio_input_delayed) , .sb(delayctrlin) );
b1 tlib000157 ( .z(regout), .a(regin) );
b1 tlib000158 ( .z(ddioregout), .a(ddioregin) );
na2 tlib000159 ( .zn(u7zn) , .a(datain) , .b(open_drain_output) );
an2 tlib000160 ( .z(padio_enable) , .a(oe) , .b(u7zn) );
b1 tlib000161 ( .z(padio_internal), .a(datain) );
endmodule

module stratix_inout_U010X0XXX0XXUUXX00001101000000000000000 ( datain, padio, combout );
inout padio;
input datain ;

output combout ;

supply0 VSS;
supply1 VDD;
mx21 tlib000184 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000185 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000186 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000187 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000188 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000189 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000190 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(datain), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000191 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000192 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000193 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000194 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000195 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000196 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000197 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000198 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000199 ( .z(mx21_3_z) , .a(datain) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000200 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000201 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
iobhc tlib000202 ( .pad(padio) , .z(padio_input) , .a(padio_internal) , .e(padio_enable) );
stratix_async_inout tlib000203 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_input(padio_input), .padio_enable(padio_enable), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b1) );
endmodule

module stratix_inout_1010X0XXX0XXUUXX00001101000000000000000 ( padio, combout );
inout padio;

output combout ;

supply0 VSS;
supply1 VDD;
mx21 tlib000184 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000185 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000186 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000187 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000188 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000189 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000190 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000191 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000192 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000193 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000194 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000195 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000196 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000197 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000198 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000199 ( .z(mx21_3_z) , .a(1'b1) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000200 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000201 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
iobhc tlib000202 ( .pad(padio) , .z(padio_input) , .a(padio_internal) , .e(padio_enable) );
stratix_async_inout tlib000203 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_input(padio_input), .padio_enable(padio_enable), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b1) );
endmodule

module x_lut4_0xf000 ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst296161  ( .b(i2), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f000 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf000 tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f000 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f000 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module stratix_async_output (datain, oe, regin, ddioregin, padio_internal, padio_enable, regout, ddioregout, open_drain_output);
input datain, oe, regin, ddioregin ,open_drain_output ;
output regout, ddioregout ,padio_internal, padio_enable ;

supply0 VSS;
supply1 VDD;
na2 tlib000166 ( .zn(u2zn) , .a(datain) , .b(open_drain_output) );
an2 tlib000167 ( .z(padio_enable) , .a(oe) , .b(u2zn) );
b1 tlib000168 ( .z(padio_internal), .a(datain) );
b1 tlib000169 ( .z(regout), .a(regin) );
b1 tlib000170 ( .z(ddioregout), .a(ddioregin) );
endmodule

module stratix_output_U010X0XXXXXUXX00000110000000000000000 ( datain, padio );
output padio ;
input datain ;

supply0 VSS;
supply1 VDD;
oth tlib000210 ( .pad(padio), .a(padio_internal), .e(padio_enable) );
mx21 tlib000211 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000212 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000213 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_internal), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000214 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000215 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_internal), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000216 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000217 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(datain), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000218 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000219 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000220 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000221 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000222 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000223 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000224 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000225 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000226 ( .z(mx21_3_z) , .a(datain) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000227 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000228 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
stratix_async_output tlib000229 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_enable(padio_enable), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b0) );
endmodule

module stratix_input_0XXX0XXUXXX00000 ( padio );
input padio ;

supply0 VSS;
supply1 VDD;
ic tlib000204 ( .z(padio_net), .pad(padio) );
stratix_io_register tlib000205 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_net), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000206 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000207 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_net), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000208 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_async_input tlib000209 ( .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio(padio_net), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout) );
endmodule

module stratix_output_0010X0XXXXXUXX00000110000000000000000 ( padio );
output padio ;

supply0 VSS;
supply1 VDD;
oth tlib000210 ( .pad(padio), .a(padio_internal), .e(padio_enable) );
mx21 tlib000211 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000212 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000213 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_internal), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000214 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000215 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_internal), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000216 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000217 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000218 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000219 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000220 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000221 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000222 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000223 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000224 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000225 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000226 ( .z(mx21_3_z) , .a(1'b0) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000227 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000228 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
stratix_async_output tlib000229 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_enable(padio_enable), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b0) );
endmodule

module stratix_inout_1010X0XXX0XXUXXX00001101000000000000000 ( padio );
inout padio;

supply0 VSS;
supply1 VDD;
mx21 tlib000184 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000185 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000186 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000187 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000188 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000189 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000190 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000191 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000192 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000193 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000194 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000195 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000196 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000197 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000198 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000199 ( .z(mx21_3_z) , .a(1'b1) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000200 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000201 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
iobhc tlib000202 ( .pad(padio) , .z(padio_input) , .a(padio_internal) , .e(padio_enable) );
stratix_async_inout tlib000203 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_input(padio_input), .padio_enable(padio_enable), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b1) );
endmodule

module stratix_inout_U010X0XXX0XXUXXX00001101000000000000000 ( datain, padio );
inout padio;
input datain ;

supply0 VSS;
supply1 VDD;
mx21 tlib000184 ( .z(out_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
mx21 tlib000185 ( .z(oe_clk_ena), .a(outclkena), .b( 1'b1 ), .sb(1'b0) );
stratix_io_register tlib000186 ( .regout(in_reg_out), .clk(1'b0), .ena(inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000187 ( .zn(i_inclk), .a(1'b0) );
stratix_io_register tlib000188 ( .regout(in_ddio0_reg_out), .clk(i_inclk), .ena (inclkena), .datain(padio_input), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000189 ( .regout(in_ddio1_reg_out), .clk(1'b0), .ena(inclkena), .datain(in_ddio0_reg_out), .areset(areset), .sreset(1'b0), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset( 1'b0 ), .sync_clear( 1'b0 ) );
stratix_io_register tlib000190 ( .regout(out_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(datain), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000191 ( .regout(out_ddio_reg_out), .clk(1'b0), .ena(out_clk_ena), .datain(1'b0), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
stratix_io_register tlib000192 ( .regout (oe_reg_out), .clk(1'b0), .ena(oe_clk_ena), .datain(1'b1), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
i1 tlib000193 ( .zn(ioutclk), .a(1'b0) );
stratix_io_register tlib000194 ( .regout(oe_pulse_reg_out), .clk(ioutclk), .ena(oe_clk_ena), .datain(oe_reg_out), .areset(areset), .sreset(sreset), .devpor(devpor), .devclrn(devclrn), .power_up(1'b0), .async_preset(1'b0), .async_clear(1'b0), .sync_preset(1'b0), .sync_clear(1'b0) );
an2 tlib000195 ( .z(an2_1z), .a(oe_pulse_reg_out), .b(oe_reg_out) );
mx21 tlib000196 ( .z(extend_oe_disable_true) , .a(an2_1z) , .b(oe_reg_out) , .sb(1'b1) );
mx21 tlib000197 ( .z(oe_out) , .a(extend_oe_disable_true) , .b(1'b1) , .sb(1'b1) );
mx21 tlib000198 ( .z(ddio_data) , .a(out_ddio_reg_out) , .b(out_reg_out) , .sb(1'b0) );
mx21 tlib000199 ( .z(mx21_3_z) , .a(datain) , .b(out_reg_out) , .sb(1'b0) );
or2 tlib000200 ( .z(ddio_true), .a(1'b0), .b(1'b0) );
mx21 tlib000201 ( .z(tmp_datain) , .a(mx21_3_z) , .b(ddio_data) , .sb(ddio_true) );
iobhc tlib000202 ( .pad(padio) , .z(padio_input) , .a(padio_internal) , .e(padio_enable) );
stratix_async_inout tlib000203 ( .datain(tmp_datain), .oe(oe_out), .regin(in_reg_out), .ddioregin(in_ddio1_reg_out), .padio_internal(padio_internal), .padio_input(padio_input), .padio_enable(padio_enable), .delayctrlin(1'b0), .combout(combout), .regout(regout), .ddioregout(ddioregout), .open_drain_output(1'b1) );
endmodule

module x_lut4_0x0f00 ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst016062  ( .b(n36), .a(i2), .zn(o) );
i1 inst016063  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0f00 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0f00 tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0f00 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f00 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff0c ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst313683  ( .b(n36), .a2(n35), .a1(i2), .zn(o) );
i1 inst313684  ( .a(i1), .zn(n35) );
i1 inst313685  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff0c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff0c tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff0c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff0c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa60a ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst203930  ( .sb(i3), .b(n36), .a(n35), .zn(o) );
i1 inst203931  ( .a(i2), .zn(n37) );
na2 inst203932  ( .b(n37), .a(i1), .zn(n38) );
xo2 inst203933  ( .b(i0), .a(n38), .z(n36) );
na2 inst203934  ( .b(n37), .a(i0), .zn(n35) );

endmodule


module lcell_reg_stratix_son_rof_pol (sclr,sload,clk,aclr,aload,ena,datain,datac,devclrn,devpor,regout);
input sclr,sload,clk,aclr,aload,ena,datain,datac,devclrn,devpor;
output regout;
supply0 VSS;
supply1 VDD;
dspbrs tlib000113 ( .q(regout),.c(clk),.d(regout),.rn(reset),.sd(data),.se(ena),.sn(set), .qn(nc_0001) );
mx41 tlib000114 ( .z(data),.i0(datain),.i1(datac),.i2(1'b0),.i3(1'b0),.s0(sload),.s1(sclr) );
an3 tlib000115 ( .z(res),.a(devpor),.b(devclrn),.c(aclrn) );
i1 tlib000116 ( .zn(aclrn),.a(aclr) );
or2 tlib000117 ( .z(set),.a(aloadn),.b(datacn) );
i1 tlib000118 ( .zn(aloadn),.a(aload) );
i1 tlib000119 ( .zn(datacn),.a(datac) );
or2 tlib000120 ( .z(w1),.a(aloadn),.b(datac) );
an2 tlib000121 ( .z(reset),.a(res),.b(w1) );
endmodule

module lcell_async_stratix_oa_sc_cf_c0tx_c1tx_a60a (dataa, datab, cin0, cin1, inverta, combout, cout, cout0, cout1);
input dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000060 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000061 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0xa60a tlib000062 ( .i0(inverta_dataa),.i1(datab),.i2(cin_int),.i3(1'b1),.o(combout) );
x_lut4_0xa60a tlib000063 ( .i0(inverta_dataa),.i1(datab),.i2(cin0),.i3(1'b0),.o(cout0) );
x_lut4_0xa60a tlib000064 ( .i0(inverta_dataa),.i1(datab),.i2(cin1),.i3(1'b0),.o(cout1) );
mx21 tlib000065 ( .z(cout), .a(cout0), .b(cout1), .sb(inverta) );
endmodule

module lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_a60a ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_a60a tlib000001 (  .dataa(dataa), .datab(datab), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_oa_sc_ct_c0tx_c1tx_a60a (dataa, datab, cin, cin0, cin1, inverta, combout, cout, cout0, cout1);
input cin, dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000071 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000072 ( .z(cin_int), .a(cin0), .b(cin1), .sb(cin) );
x_lut4_0xa60a tlib000073 ( .i0(inverta_dataa),.i1(datab),.i2(cin_int),.i3(1'b1),.o(combout) );
x_lut4_0xa60a tlib000074 ( .i0(inverta_dataa),.i1(datab),.i2(cin0),.i3(1'b0),.o(cout0) );
x_lut4_0xa60a tlib000075 ( .i0(inverta_dataa),.i1(datab),.i2(cin1),.i3(1'b0),.o(cout1) );
mx21 tlib000076 ( .z(cout), .a(cout0), .b(cout1), .sb(cin) );
endmodule

module lcell_stratix_son_rof_pol_oa_sc_ct_c0tx_c1tx_a60a ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_ct_c0tx_c1tx_a60a tlib000001 (  .dataa(dataa), .datab(datab), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x6a5f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst127365  ( .b(i2), .a2(i1), .a1(n36), .zn(n35) );
aoi21 inst127366  ( .b(n36), .a2(i1), .a1(i2), .zn(n37) );
mx21i inst127367  ( .sb(i0), .b(n38), .a(n37), .zn(o) );
i1 inst127368  ( .a(i3), .zn(n36) );
i1 inst127369  ( .a(n35), .zn(n38) );

endmodule


module lcell_async_stratix_oa_sc_ct_c0tx_c1tx_6a5f (dataa, datab, cin, cin0, cin1, inverta, combout, cout, cout0, cout1);
input cin, dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000071 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000072 ( .z(cin_int), .a(cin0), .b(cin1), .sb(cin) );
x_lut4_0x6a5f tlib000073 ( .i0(inverta_dataa),.i1(datab),.i2(cin_int),.i3(1'b1),.o(combout) );
x_lut4_0x6a5f tlib000074 ( .i0(inverta_dataa),.i1(datab),.i2(cin0),.i3(1'b0),.o(cout0) );
x_lut4_0x6a5f tlib000075 ( .i0(inverta_dataa),.i1(datab),.i2(cin1),.i3(1'b0),.o(cout1) );
mx21 tlib000076 ( .z(cout), .a(cout0), .b(cout1), .sb(cin) );
endmodule

module lcell_stratix_son_rof_pol_oa_sc_ct_c0tx_c1tx_6a5f ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_ct_c0tx_c1tx_6a5f tlib000001 (  .dataa(dataa), .datab(datab), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xa5aa ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst203541  ( .b(n37), .a(i2), .zn(n36) );
xo2 inst203542  ( .b(n36), .a(i0), .z(o) );
i1 inst203543  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sc_ct_c0tx_c1tx_a5aa ( dataa, datad, cin, cin0, cin1, inverta, combout );
input dataa, datad, cin, cin0, cin1, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000007 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000008 ( .z(cin_int), .a(cin0), .b(cin1), .sb(cin) );
x_lut4_0xa5aa tlib000009 (  .i0(inverta_dataa), .i2(cin_int), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sc_ct_c0tx_c1tx_a5aa ( clk, dataa, datac, datad, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sc_ct_c0tx_c1tx_a5aa tlib000001 (  .dataa(dataa), .datad(datad), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_oa_sc_cf_c0tx_c1tx_6a5f (dataa, datab, cin0, cin1, inverta, combout, cout, cout0, cout1);
input dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000060 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000061 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0x6a5f tlib000062 ( .i0(inverta_dataa),.i1(datab),.i2(cin_int),.i3(1'b1),.o(combout) );
x_lut4_0x6a5f tlib000063 ( .i0(inverta_dataa),.i1(datab),.i2(cin0),.i3(1'b0),.o(cout0) );
x_lut4_0x6a5f tlib000064 ( .i0(inverta_dataa),.i1(datab),.i2(cin1),.i3(1'b0),.o(cout1) );
mx21 tlib000065 ( .z(cout), .a(cout0), .b(cout1), .sb(inverta) );
endmodule

module lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_6a5f ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_6a5f tlib000001 (  .dataa(dataa), .datab(datab), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_oa_sc_ct_c0f_c1f_6a5f (dataa,datab,cin,cin0,cin1,inverta,combout,cout,cout0,cout1);
input dataa, datab, cin, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000066 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x6a5f tlib000067 ( .i0(inverta_dataa),.i1(datab),.i2(cin),.i3(1'b1),.o(combout) );
x_lut4_0x6a5f tlib000068 ( .i0(inverta_dataa),.i1(datab),.i2(cin0),.i3(1'b0),.o(cout0) );
x_lut4_0x6a5f tlib000069 ( .i0(inverta_dataa),.i1(datab),.i2(cin1),.i3(1'b0),.o(cout1) );
x_lut4_0x6a5f tlib000070 ( .i0(inverta_dataa),.i1(datab),.i2(cin),.i3(1'b0),.o(cout) );
endmodule

module lcell_stratix_son_rof_pol_oa_sc_ct_c0f_c1f_6a5f ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, cin, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_ct_c0f_c1f_6a5f tlib000001 (  .dataa(dataa), .datab(datab), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x66aa ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst122429  ( .b(i1), .a(i3), .z(n36) );
xo2 inst122430  ( .b(n36), .a(i0), .z(o) );

endmodule


module lcell_async_stratix_oa_sd_cf_c0f_c1f_66aa ( dataa, datab, inverta, combout, cout, cout0, cout1 );
input dataa, datab, inverta ;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000015 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x66aa tlib000016 (  .i0(inverta_dataa), .i1(datab), .i3(1'b1), .o(combout) );
x_lut4_0x66aa tlib000017 (  .i0(inverta_dataa), .i1(datab), .i3(1'b0), .o(cout0) );
x_lut4_0x66aa tlib000018 (  .i0(inverta_dataa), .i1(datab), .i3(1'b0), .o(cout1) );
x_lut4_0x66aa tlib000019 (  .i0(inverta_dataa), .i1(datab), .i3(1'b0), .o(cout) );
endmodule

module lcell_stratix_son_rof_pol_oa_sd_cf_c0f_c1f_66aa ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sd_cf_c0f_c1f_66aa tlib000001 (  .dataa(dataa), .datab(datab), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xa0a0 ( i0, i2, o );

input i0, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst197634  ( .b(i0), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a0a0 ( dataa, datac, inverta, combout );
input dataa, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa0a0 tlib000004 (  .i0(inverta_dataa), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a0a0 ( dataa, datac, inverta, combout );

input dataa, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a0a0 tlib000001 (  .dataa(dataa), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x7fff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na4 inst156160  ( .d(i0), .c(i1), .b(i2), .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_7fff (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x7fff tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_7fff ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_7fff tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x5050 ( i0, i2, o );

input i0, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst094949  ( .b(n36), .a(i0), .zn(o) );
i1 inst094950  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_5050 ( dataa, inverta, qfbkin, combout );
input dataa, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5050 tlib000006 (  .i0(inverta_dataa), .i2(qfbkin), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_5050 ( clk, dataa, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_5050 tlib000001 (  .dataa(dataa), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_reg_stratix_sof_rof_pol (clk,aclr,aload,ena,datain,datac,devclrn,devpor,regout);
input clk,aclr,aload,ena,datain,datac,devclrn,devpor;
output regout;
supply0 VSS;
supply1 VDD;
dspbrs tlib000077 ( .q(regout),.c(clk),.d(regout),.rn(reset),.sd(datain),.se(ena),.sn(set) );
na2 tlib000078 ( .zn(set),.a(aload),.b(datac) );
an4 tlib000079 ( .z(reset),.a(devpor),.b(devclrn),.c(aclrn),.d(load0) );
i1 tlib000080 ( .zn(aclrn),.a(aclr) );
i1 tlib000081 ( .zn(aloadn),.a(aload) );
or2 tlib000082 ( .z(load0),.a(aloadn),.b(datac) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f ( clk, dataa, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f0f tlib000001 (  .dataa(dataa), .datac(datac), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x00ff ( i3, o );

input i3 ;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst001337  ( .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00ff ( dataa, datad, inverta, combout );
input dataa, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00ff tlib000004 (  .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00ff tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xcccd ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst251690  ( .b(i1), .a(n36), .z(o) );
no3 inst251691  ( .c(i2), .b(i3), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cccd (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcccd tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cccd ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cccd tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3f0f ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst073602  ( .b(i2), .a2(n35), .a1(i1), .zn(o) );
i1 inst073603  ( .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3f0f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3f0f tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3f0f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3f0f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xffff ( o );


output  o;

supply0 VSS;
supply1 VDD;

cvdd inst314430  ( .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ffff ( dataa, inverta, combout );
input dataa, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xffff tlib000004 (  .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff ( clk, dataa, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ffff tlib000001 (  .dataa(dataa), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0c0f ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst012897  ( .b(i2), .a2(n35), .a1(i3), .zn(o) );
i1 inst012898  ( .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0c0f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0c0f tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0c0f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0c0f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xffcc ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst314299  ( .b(i3), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ffcc ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xffcc tlib000004 (  .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ffcc ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ffcc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0000 ( o );


output  o;

supply0 VSS;
supply1 VDD;

cvss inst000628  ( .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0000 ( dataa, inverta, combout );
input dataa, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0000 tlib000004 (  .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ( clk, dataa, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0000 tlib000001 (  .dataa(dataa), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xfeff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or4 inst313651  ( .d(i1), .c(i2), .b(n35), .a(i0), .z(o) );
i1 inst313652  ( .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_feff (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfeff tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_feff ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_feff tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xfdff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst312573  ( .c(n35), .b(i0), .a(i3), .zn(o) );
no2 inst312574  ( .b(i1), .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_fdff (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfdff tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fdff ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_fdff tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xff00 ( i3, o );

input i3 ;
output  o;

supply0 VSS;
supply1 VDD;

b1 inst313653  ( .z(o),.a(i3) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff00 ( dataa, datad, inverta, combout );
input dataa, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff00 tlib000004 (  .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff00 tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x33cc ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst059644  ( .b(i1), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_oa_sd_cf_c0f_c1f_33cc ( dataa, datab, inverta, combout, cout, cout0, cout1 );
input dataa, datab, inverta ;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000015 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33cc tlib000016 (  .i1(datab), .i3(1'b1), .o(combout) );
x_lut4_0x33cc tlib000017 (  .i1(datab), .i3(1'b0), .o(cout0) );
x_lut4_0x33cc tlib000018 (  .i1(datab), .i3(1'b0), .o(cout1) );
x_lut4_0x33cc tlib000019 (  .i1(datab), .i3(1'b0), .o(cout) );
endmodule

module lcell_stratix_sof_rof_pol_oa_sd_cf_c0f_c1f_33cc ( clk, dataa, datab, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sd_cf_c0f_c1f_33cc tlib000001 (  .dataa(dataa), .datab(datab), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x3c3f ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst070125  ( .b(n36), .a(i3), .z(n35) );
mx21i inst070126  ( .sb(i2), .b(i1), .a(n35), .zn(o) );
i1 inst070127  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_oa_sc_cf_c0tx_c1tx_3c3f (dataa, datab, cin0, cin1, inverta, combout, cout, cout0, cout1);
input dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000060 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000061 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0x3c3f tlib000062 (  .i1(datab), .i2(cin_int), .i3(1'b1), .o(combout) );
x_lut4_0x3c3f tlib000063 (  .i1(datab), .i2(cin0), .i3(1'b0), .o(cout0) );
x_lut4_0x3c3f tlib000064 (  .i1(datab), .i2(cin1), .i3(1'b0), .o(cout1) );
mx21 tlib000065 ( .z(cout), .a(cout0), .b(cout1), .sb(inverta) );
endmodule

module lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_3c3f ( clk, dataa, datab, datac, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_3c3f tlib000001 (  .dataa(dataa), .datab(datab), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xc30c ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst240022  ( .b(i1), .a(i3), .z(n35) );
an2 inst240023  ( .b(i1), .a(i3), .z(n36) );
mx21 inst240024  ( .sb(i2), .b(n36), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_oa_sc_cf_c0tx_c1tx_c30c (dataa, datab, cin0, cin1, inverta, combout, cout, cout0, cout1);
input dataa, datab, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000060 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000061 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0xc30c tlib000062 (  .i1(datab), .i2(cin_int), .i3(1'b1), .o(combout) );
x_lut4_0xc30c tlib000063 (  .i1(datab), .i2(cin0), .i3(1'b0), .o(cout0) );
x_lut4_0xc30c tlib000064 (  .i1(datab), .i2(cin1), .i3(1'b0), .o(cout1) );
mx21 tlib000065 ( .z(cout), .a(cout0), .b(cout1), .sb(inverta) );
endmodule

module lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_c30c ( clk, dataa, datab, datac, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datab, datac, clk, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_c30c tlib000001 (  .dataa(dataa), .datab(datab), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x5a5f ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst106832  ( .b(n36), .a(i3), .z(n35) );
mx21i inst106833  ( .sb(i2), .b(i0), .a(n35), .zn(o) );
i1 inst106834  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_oa_sc_cf_c0tx_c1tx_5a5f ( dataa, cin0, cin1, inverta, combout, cout, cout0, cout1 );
input dataa, cin0, cin1, inverta ;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000060 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000061 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0x5a5f tlib000062 (  .i0(inverta_dataa), .i2(cin_int), .i3(1'b1), .o(combout) );
x_lut4_0x5a5f tlib000063 (  .i0(inverta_dataa), .i2(cin0), .i3(1'b0), .o(cout0) );
x_lut4_0x5a5f tlib000064 (  .i0(inverta_dataa), .i2(cin1), .i3(1'b0), .o(cout1) );
mx21 tlib000065 ( .z(cout), .a(cout0), .b(cout1), .sb(inverta) );
endmodule

module lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_5a5f ( clk, dataa, datac, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout, cout, cout0, cout1 );

input dataa, datac, clk, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor ;

output cout, cout0, cout1, regout, combout;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_5a5f tlib000001 (  .dataa(dataa), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xa5a5 ( i0, i2, o );

input i0, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

xn2 inst203527  ( .b(i0), .a(i2), .zn(o) );

endmodule


module lcell_async_stratix_on_sc_cf_c0tx_c1tx_a5a5 ( dataa, cin0, cin1, inverta, combout );
input dataa, cin0, cin1, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000010 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000011 ( .z(cin_int), .a(cin0), .b(cin1), .sb(inverta) );
x_lut4_0xa5a5 tlib000012 (  .i0(inverta_dataa), .i2(cin_int), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sc_cf_c0tx_c1tx_a5a5 ( clk, dataa, datac, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, ena, cin0, cin1, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sc_cf_c0tx_c1tx_a5a5 tlib000001 (  .dataa(dataa), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xcc00 ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst250954  ( .b(i1), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cc00 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcc00 tlib000004 (  .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cc00 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cc00 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfff0 ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst314402  ( .b(i3), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fff0 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfff0 tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fff0 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fff0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xffef ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or4 inst314400  ( .d(i1), .c(i3), .b(n35), .a(i0), .z(o) );
i1 inst314401  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ffef (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xffef tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ffef ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ffef tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0004 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no4 inst000633  ( .d(n35), .c(i0), .b(i2), .a(i3), .zn(o) );
i1 inst000634  ( .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0004 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0004 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0004 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0004 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x2022 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst035966  ( .b(i0), .a(n36), .z(o) );
aoi21 inst035967  ( .b(i1), .a2(n37), .a1(i3), .zn(n36) );
i1 inst035968  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2022 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2022 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2022 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2022 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x4000 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an4 inst074640  ( .d(n35), .c(i1), .b(i2), .a(i3), .z(o) );
i1 inst074641  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_4000 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4000 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4000 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_4000 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0040 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000776  ( .c(i0), .b(i3), .a(n35), .zn(o) );
na2 inst000777  ( .b(i1), .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0040 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0040 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0040 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0040 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x3300 ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst058930  ( .b(n36), .a(i1), .zn(o) );
i1 inst058931  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3300 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3300 tlib000004 (  .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3300 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3300 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x00aa ( i0, i3, o );

input i0, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst001096  ( .b(n36), .a(i3), .zn(o) );
i1 inst001097  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00aa ( dataa, datad, inverta, combout );
input dataa, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00aa tlib000004 (  .i0(inverta_dataa), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00aa ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00aa tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0fcc ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst016779  ( .sb(i3), .b(i2), .a(n36), .zn(o) );
i1 inst016780  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0fcc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0fcc tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0fcc ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0fcc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0faa ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst016654  ( .sb(i3), .b(i2), .a(n36), .zn(o) );
i1 inst016655  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0faa ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0faa tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0faa ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0faa tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x7722 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst144355  ( .sb(i0), .b(i1), .a(n36), .zn(o) );
i1 inst144356  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_7722 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x7722 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_7722 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_7722 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x33f0 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst059774  ( .sb(i3), .b(i1), .a(n36), .zn(o) );
i1 inst059775  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_33f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33f0 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_33f0 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_33f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x33aa ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst059524  ( .sb(i3), .b(i1), .a(n36), .zn(o) );
i1 inst059525  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_33aa ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33aa tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_33aa ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_33aa tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x88aa ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst166930  ( .b(n36), .a2(n35), .a1(i3), .zn(o) );
i1 inst166931  ( .a(i1), .zn(n35) );
i1 inst166932  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_88aa ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x88aa tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_88aa ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_88aa tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f00 ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f00 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xaaab ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst209577  ( .b(i0), .a(n36), .z(o) );
no3 inst209578  ( .c(i2), .b(i3), .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aaab (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaaab tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aaab ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aaab tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x33ff ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst059818  ( .b(i1), .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_33ff ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33ff tlib000004 (  .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_33ff ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_33ff tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf7ff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na4 inst305505  ( .d(n35), .c(i0), .b(i1), .a(i3), .zn(o) );
i1 inst305506  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_f7ff (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf7ff tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f7ff ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_f7ff tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xff7f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na4 inst314051  ( .d(n35), .c(i0), .b(i1), .a(i2), .zn(o) );
i1 inst314052  ( .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_ff7f (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff7f tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_ff7f ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_ff7f tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0010 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no4 inst000654  ( .d(n35), .c(i0), .b(i1), .a(i3), .zn(o) );
i1 inst000655  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0010 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0010 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0010 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0010 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x00c0 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst001161  ( .c(i2), .b(n36), .a(i1), .z(o) );
i1 inst001162  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00c0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00c0 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00c0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00c0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfffb ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or4 inst314424  ( .d(i2), .c(i3), .b(n35), .a(i0), .z(o) );
i1 inst314425  ( .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fffb (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfffb tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fffb ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fffb tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0080 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an4 inst000964  ( .d(n35), .c(i0), .b(i1), .a(i2), .z(o) );
i1 inst000965  ( .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0080 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0080 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0080 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0080 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x1000 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst016947  ( .c(i0), .b(i1), .a(n35), .zn(o) );
na2 inst016948  ( .b(i2), .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_1000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x1000 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_1000 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_1000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x5500 ( i0, i3, o );

input i0, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst100408  ( .b(n36), .a(i0), .zn(o) );
i1 inst100409  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5500 ( dataa, datad, inverta, combout );
input dataa, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5500 tlib000004 (  .i0(inverta_dataa), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5500 ( dataa, datad, inverta, combout );

input dataa, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5500 tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3f0c ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst073592  ( .sb(i1), .b(i2), .a(n36), .zn(o) );
i1 inst073593  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3f0c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3f0c tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_3f0c ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3f0c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x55cc ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst101120  ( .sb(i3), .b(i0), .a(n36), .zn(o) );
i1 inst101121  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_55cc ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x55cc tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_55cc ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_55cc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x2e2e ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst053427  ( .sb(i1), .b(i2), .a(n36), .zn(o) );
i1 inst053428  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2e2e ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2e2e tlib000004 (  .i0(inverta_dataa), .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2e2e ( clk, dataa, datab, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2e2e tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x7744 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst144506  ( .sb(i1), .b(i0), .a(n36), .zn(o) );
i1 inst144507  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_7744 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x7744 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_7744 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_7744 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xc0cc ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst237319  ( .b(n36), .a2(n35), .a1(i3), .zn(o) );
i1 inst237320  ( .a(i2), .zn(n35) );
i1 inst237321  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_c0cc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc0cc tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c0cc ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_c0cc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x00f0 ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst001302  ( .b(n36), .a(i3), .zn(o) );
i1 inst001303  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00f0 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00f0 tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00f0 ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00f0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x30fc ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst056704  ( .sb(i1), .b(i3), .a(n36), .zn(o) );
i1 inst056705  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_30fc (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x30fc tlib000006 (  .i1(datab), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_30fc ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_30fc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0333 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst003481  ( .b(i1), .a2(i2), .a1(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0333 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0333 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0333 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0333 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x9099 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst176572  ( .b(n36), .a2(n35), .a1(i3), .zn(o) );
xo2 inst176573  ( .b(i0), .a(i1), .z(n36) );
i1 inst176574  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_9099 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x9099 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_9099 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_9099 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x82c3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst159437  ( .b(n36), .a2(n35), .a1(i3), .zn(o) );
xo2 inst159438  ( .b(i1), .a(i2), .z(n36) );
i1 inst159439  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_82c3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x82c3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_82c3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_82c3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sq_cx_c0x_c1x_0faa ( dataa, datad, inverta, qfbkin, combout );
input dataa, datad, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0faa tlib000006 (  .i0(inverta_dataa), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0faa ( clk, dataa, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0faa tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x000c ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000647  ( .c(i2), .b(i3), .a(n36), .zn(o) );
i1 inst000648  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_000c (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x000c tlib000006 (  .i1(datab), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_000c ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_000c tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_on_sq_cx_c0x_c1x_3f0c (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3f0c tlib000006 (  .i1(datab), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_3f0c tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x01ab ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst001974  ( .sb(i0), .b(i3), .a(n35), .zn(o) );
or2 inst001975  ( .b(i1), .a(i2), .z(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_01ab (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x01ab tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_01ab ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_01ab tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_on_sq_cx_c0x_c1x_0fcc (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0fcc tlib000006 (  .i1(datab), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0fcc ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0fcc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x4ecc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst093125  ( .b(i0), .a(i3), .z(n36) );
mx21i inst093126  ( .sb(n36), .b(i2), .a(n37), .zn(o) );
i1 inst093127  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_4ecc (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4ecc tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4ecc ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_4ecc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xee03 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst293912  ( .b(i1), .a(i0), .zn(n36) );
mx21i inst293913  ( .sb(i3), .b(n36), .a(n37), .zn(o) );
or2 inst293914  ( .b(i2), .a(i1), .z(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_ee03 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xee03 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_ee03 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_ee03 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x46ce ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst082726  ( .b(i0), .a(i3), .z(n36) );
mx21i inst082727  ( .sb(i1), .b(n36), .a(n37), .zn(o) );
or2 inst082728  ( .b(n38), .a(i2), .z(n37) );
i1 inst082729  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_46ce (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x46ce tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_46ce ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_46ce tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x5555 ( i0, o );

input i0 ;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst100692  ( .a(i0), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5555 ( dataa, inverta, combout );
input dataa, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5555 tlib000004 (  .i0(inverta_dataa), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_5555 ( clk, dataa, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5555 tlib000001 (  .dataa(dataa), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xefcd ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst295955  ( .b(n36), .a(i1), .z(o) );
mx21i inst295956  ( .sb(i0), .b(n37), .a(i2), .zn(n36) );
i1 inst295957  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_efcd (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xefcd tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_efcd ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_efcd tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x27aa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst044920  ( .b(i3), .a(i1), .z(n36) );
mx21i inst044921  ( .sb(i0), .b(n36), .a(n37), .zn(o) );
or2 inst044922  ( .b(n38), .a(i2), .z(n37) );
i1 inst044923  ( .a(i3), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_27aa (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x27aa tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_27aa ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_27aa tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x770a ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst144246  ( .b(i0), .a(i1), .z(n36) );
mx21i inst144247  ( .sb(i3), .b(n36), .a(n37), .zn(o) );
or2 inst144248  ( .b(n38), .a(i2), .z(n37) );
i1 inst144249  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_770a (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x770a tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_770a ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_770a tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xeecf ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst294827  ( .b(n36), .a(i1), .z(o) );
mx21i inst294828  ( .sb(i3), .b(n37), .a(i2), .zn(n36) );
i1 inst294829  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_eecf (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xeecf tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_eecf ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_eecf tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0200 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst002274  ( .c(i1), .b(i2), .a(n35), .zn(o) );
na2 inst002275  ( .b(i0), .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0200 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0200 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0200 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0200 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x04ae ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst004939  ( .sb(i0), .b(i3), .a(n35), .zn(o) );
na2 inst004940  ( .b(n36), .a(i1), .zn(n35) );
i1 inst004941  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_04ae (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x04ae tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_04ae ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_04ae tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x2e00 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst053234  ( .b(i3), .a(n36), .z(o) );
mx21i inst053235  ( .sb(i1), .b(i2), .a(n37), .zn(n36) );
i1 inst053236  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_2e00 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2e00 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_2e00 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_2e00 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xbf15 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst235450  ( .b(i1), .a(i2), .zn(n35) );
mx21 inst235451  ( .sb(i0), .b(i3), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_bf15 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbf15 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_bf15 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_bf15 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x5f0a ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst112640  ( .sb(i0), .b(i2), .a(n36), .zn(o) );
i1 inst112641  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_5f0a ( dataa, datad, inverta, qfbkin, combout );
input dataa, datad, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5f0a tlib000006 (  .i0(inverta_dataa), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_5f0a ( clk, dataa, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_5f0a tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x8b00 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst169648  ( .b(i3), .a(n36), .z(o) );
mx21i inst169649  ( .sb(i1), .b(n37), .a(i2), .zn(n36) );
i1 inst169650  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_8b00 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8b00 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8b00 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_8b00 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_on_sq_cx_c0x_c1x_0004 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0004 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0004 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0004 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0808 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst008463  ( .c(i1), .b(n36), .a(i0), .z(o) );
i1 inst008464  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0808 ( dataa, datab, inverta, qfbkin, combout );
input dataa, datab, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0808 tlib000006 (  .i0(inverta_dataa), .i1(datab), .i2(qfbkin), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0808 ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0808 tlib000001 (  .dataa(dataa), .datab(datab), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xcc0a ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst250987  ( .b(n36), .a(i2), .zn(n35) );
mx21 inst250988  ( .sb(i3), .b(i1), .a(n35), .z(o) );
i1 inst250989  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_cc0a (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcc0a tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_cc0a ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_cc0a tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x4c08 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst089615  ( .b(i1), .a(n36), .z(o) );
mx21i inst089616  ( .sb(i0), .b(i2), .a(n37), .zn(n36) );
i1 inst089617  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_4c08 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4c08 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4c08 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_4c08 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0c00 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst012854  ( .c(i3), .b(n36), .a(i1), .z(o) );
i1 inst012855  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0c00 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0c00 tlib000006 (  .i1(datab), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0c00 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0c00 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0a4e ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst011005  ( .sb(i0), .b(i2), .a(n35), .zn(o) );
na2 inst011006  ( .b(n36), .a(i1), .zn(n35) );
i1 inst011007  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0a4e (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0a4e tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0a4e ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0a4e tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xaf11 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst214794  ( .b(i1), .a(i0), .zn(n36) );
na2 inst214795  ( .b(n38), .a(i2), .zn(n37) );
mx21 inst214796  ( .sb(i3), .b(n37), .a(n36), .z(o) );
i1 inst214797  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_af11 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaf11 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_af11 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_af11 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x8c9d ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst171610  ( .b(i3), .a(i0), .zn(n36) );
na2 inst171611  ( .b(n38), .a(i2), .zn(n37) );
mx21 inst171612  ( .sb(i1), .b(n37), .a(n36), .z(o) );
i1 inst171613  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_8c9d (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8c9d tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8c9d ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_8c9d tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xaa1b ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst209051  ( .b(i1), .a(i3), .zn(n36) );
na2 inst209052  ( .b(n38), .a(i2), .zn(n37) );
mx21 inst209053  ( .sb(i0), .b(n37), .a(n36), .z(o) );
i1 inst209054  ( .a(i3), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_aa1b (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaa1b tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_aa1b ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_aa1b tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x8a9b ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst169190  ( .b(i3), .a(i1), .zn(n36) );
na2 inst169191  ( .b(n38), .a(i2), .zn(n37) );
mx21 inst169192  ( .sb(i0), .b(n37), .a(n36), .z(o) );
i1 inst169193  ( .a(i1), .zn(n38) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_8a9b (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8a9b tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8a9b ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_8a9b tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0f88 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst016519  ( .sb(i3), .b(i2), .a(n35), .zn(o) );
na2 inst016520  ( .b(i0), .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_0f88 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0f88 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0f88 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_0f88 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x8b8b ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst170315  ( .sb(i1), .b(n36), .a(i2), .zn(o) );
i1 inst170316  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_8b8b ( dataa, datab, inverta, qfbkin, combout );
input dataa, datab, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8b8b tlib000006 (  .i0(inverta_dataa), .i1(datab), .i2(qfbkin), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8b8b ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_8b8b tlib000001 (  .dataa(dataa), .datab(datab), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0aff ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst011726  ( .b(i3), .a2(n35), .a1(i2), .zn(o) );
i1 inst011727  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0aff ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0aff tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0aff ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0aff tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xce00 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst253015  ( .b(i3), .a(n35), .z(o) );
aoi21 inst253016  ( .b(i1), .a2(n37), .a1(i0), .zn(n36) );
i1 inst253017  ( .a(i2), .zn(n37) );
i1 inst253018  ( .a(n36), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ce00 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xce00 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ce00 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ce00 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0003 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000632  ( .c(i2), .b(i3), .a(i1), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0003 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0003 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0003 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0003 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x1a4a ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst028825  ( .b(i1), .a(i3), .z(n35) );
mx21i inst028826  ( .sb(i0), .b(i2), .a(n36), .zn(o) );
na2 inst028827  ( .b(n35), .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_1a4a (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x1a4a tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_1a4a ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_1a4a tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0100 ( i0, i1, i2, i3, o ) ;

input   i0 ,i1 ,i2 ,i3 ;
output  o ;

supply0 VSS;
supply1 VDD;

no3 inst001338  ( .zn (o), .c (nx60), .b (i2), .a (nx62) );
i1 inst001339  ( .zn (nx60), .a (i3) );
or2 inst001340  ( .z (nx62), .b (i1), .a (i0) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0100 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0100 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0100 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0100 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0001 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no4 inst000629  ( .d(i0), .c(i1), .b(i2), .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0001 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0001 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0001 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0001 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x48c0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst085147  ( .b(n36), .a(i1), .z(o) );
an2 inst085148  ( .b(i0), .a(i3), .z(n37) );
xo2 inst085149  ( .b(n37), .a(i2), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_48c0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x48c0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_48c0 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_48c0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x4488 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst080062  ( .b(n36), .a(i1), .z(o) );
xo2 inst080063  ( .b(i0), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_4488 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4488 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_4488 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4488 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0020 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000691  ( .c(i1), .b(i3), .a(n35), .zn(o) );
na2 inst000692  ( .b(i0), .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0020 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0020 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0020 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0020 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0003 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0003 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_4000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4000 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_4000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0050 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000820  ( .c(i0), .b(i3), .a(n36), .zn(o) );
i1 inst000821  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0050 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0050 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0050 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0050 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xd0d0 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst256388  ( .b(n36), .a2(n35), .a1(i0), .zn(o) );
i1 inst256389  ( .a(i1), .zn(n35) );
i1 inst256390  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_d0d0 ( dataa, datab, inverta, qfbkin, combout );
input dataa, datab, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xd0d0 tlib000006 (  .i0(inverta_dataa), .i1(datab), .i2(qfbkin), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_d0d0 ( clk, dataa, datab, datac, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_d0d0 tlib000001 (  .dataa(dataa), .datab(datab), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x5fff ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst113687  ( .c(i3), .b(i0), .a(i2), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5fff ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5fff tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5fff ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5fff tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x000f ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst000653  ( .b(i2), .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_000f ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x000f tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_000f ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_000f tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x8000 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an4 inst156161  ( .d(i0), .c(i1), .b(i2), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_8000 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8000 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8000 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_8000 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_on_sq_cx_c0x_c1x_f000 ( dataa, datad, inverta, qfbkin, combout );
input dataa, datad, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf000 tlib000006 (  .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f000 ( clk, dataa, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_f000 tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xf0ff ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst297062  ( .b(n36), .a(i3), .zn(o) );
i1 inst297063  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f0ff ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf0ff tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f0ff ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f0ff tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00f0 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00f0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_000c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x000c tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_000c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_000c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0404 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst004244  ( .c(i0), .b(i2), .a(n36), .zn(o) );
i1 inst004245  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0404 ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0404 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0404 ( dataa, datab, datac, inverta, combout );

input dataa, datab, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0404 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbdbf ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst233644  ( .b(i0), .a(n37), .z(n36) );
na2 inst233645  ( .b(n39), .a(i3), .zn(n38) );
na2 inst233646  ( .b(i2), .a(i1), .zn(n39) );
mx21 inst233647  ( .sb(n36), .b(n38), .a(n39), .z(o) );
xn2 inst233648  ( .b(i2), .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bdbf (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbdbf tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bdbf ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bdbf tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf5ff ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst302943  ( .c(i3), .b(n36), .a(i0), .zn(o) );
i1 inst302944  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f5ff ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf5ff tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f5ff ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f5ff tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0300 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst003315  ( .c(i1), .b(i2), .a(n36), .zn(o) );
i1 inst003316  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0300 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0300 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0300 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0300 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xd1f3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst257771  ( .b(i0), .a(i3), .zn(n35) );
mx21 inst257772  ( .sb(i1), .b(i2), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_d1f3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xd1f3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_d1f3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_d1f3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x77f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst145244  ( .b(i0), .a(i1), .zn(n35) );
mx21 inst145245  ( .sb(i3), .b(n35), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_77f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x77f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_77f0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_77f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xcfca ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst255186  ( .b(i3), .a(i0), .z(n35) );
mx21 inst255187  ( .sb(i2), .b(i1), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cfca (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcfca tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cfca ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cfca tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2a4c ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst048350  ( .sb(i0), .b(i2), .a(i3), .zn(n35) );
an2 inst048351  ( .b(i0), .a(i3), .z(n36) );
mx21 inst048352  ( .sb(i1), .b(n35), .a(n36), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2a4c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2a4c tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2a4c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2a4c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0220 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst002377  ( .c(n37), .b(i1), .a(n36), .zn(o) );
xn2 inst002378  ( .b(i2), .a(i3), .zn(n37) );
i1 inst002379  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0220 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0220 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0220 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0220 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbbb1 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst230946  ( .b(i3), .a(i2), .zn(n35) );
mx21i inst230947  ( .sb(i0), .b(n35), .a(i1), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bbb1 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbbb1 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bbb1 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bbb1 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xeac0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst289750  ( .a(n36), .zn(o) );
aoi22 inst289751  ( .b2(i1), .b1(i2), .a2(i0), .a1(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_eac0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xeac0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_eac0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_eac0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x55aa ( i0, i3, o );

input i0, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst101000  ( .b(i0), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_55aa ( dataa, datad, inverta, combout );
input dataa, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x55aa tlib000004 (  .i0(inverta_dataa), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_55aa ( dataa, datad, inverta, combout );

input dataa, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_55aa tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xada8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst213056  ( .b(i2), .a(i1), .zn(n36) );
mx21i inst213057  ( .sb(i0), .b(n36), .a(n37), .zn(o) );
na2 inst213058  ( .b(n38), .a(i3), .zn(n37) );
i1 inst213059  ( .a(i2), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ada8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xada8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ada8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ada8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x5fc0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst113421  ( .b(i2), .a(i0), .z(n36) );
mx21i inst113422  ( .sb(i3), .b(n36), .a(n37), .zn(o) );
na2 inst113423  ( .b(i1), .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5fc0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5fc0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5fc0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5fc0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_1000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_1000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaaef ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst209817  ( .b(i0), .a(n35), .z(o) );
aoi21 inst209818  ( .b(i3), .a2(n36), .a1(i2), .zn(n35) );
i1 inst209819  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aaef (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaaef tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aaef ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aaef tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2600 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst042856  ( .b(i3), .a(n36), .z(o) );
no2 inst042857  ( .b(i2), .a(i0), .zn(n37) );
mx21 inst042858  ( .sb(i1), .b(n37), .a(i0), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2600 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2600 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2600 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2600 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x2828 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst045527  ( .b(n36), .a(i0), .z(o) );
xo2 inst045528  ( .b(i1), .a(i2), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2828 ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2828 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2828 ( dataa, datab, datac, inverta, combout );

input dataa, datab, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2828 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0430 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst004403  ( .b(n37), .a(n36), .zn(o) );
no2 inst004404  ( .b(i0), .a(i2), .zn(n38) );
xo2 inst004405  ( .b(i1), .a(i3), .z(n36) );
mx21i inst004406  ( .sb(i1), .b(n38), .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0430 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0430 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0430 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0430 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbaaa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst229727  ( .a(n36), .zn(o) );
aoi31 inst229728  ( .b(i0), .a3(i3), .a2(n37), .a1(i2), .zn(n36) );
i1 inst229729  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_baaa (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbaaa tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_baaa ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_baaa tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xec33 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst291587  ( .b(n37), .a2(i0), .a1(i2), .zn(n36) );
i1 inst291588  ( .a(i3), .zn(n37) );
mx21i inst291589  ( .sb(i1), .b(n37), .a(n36), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ec33 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xec33 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ec33 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ec33 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_0c00 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0c00 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0c00 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0c00 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3033 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst055900  ( .b(i1), .a2(n35), .a1(i3), .zn(o) );
i1 inst055901  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3033 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3033 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3033 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3033 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa888 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst207131  ( .b(n36), .a(n35), .zn(o) );
aoi21 inst207132  ( .b(i1), .a2(i2), .a1(i3), .zn(n35) );
i1 inst207133  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a888 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa888 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a888 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a888 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xff33 ( i1, i3, o );

input i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst313806  ( .b(n36), .a(i1), .zn(o) );
i1 inst313807  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff33 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff33 tlib000004 (  .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff33 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff33 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_oa_sd_cf_c0f_c1f_55aa ( dataa, inverta, combout, cout, cout0, cout1 );
input dataa, inverta ;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000015 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x55aa tlib000016 (  .i0(inverta_dataa), .i3(1'b1), .o(combout) );
x_lut4_0x55aa tlib000017 (  .i0(inverta_dataa), .i3(1'b0), .o(cout0) );
x_lut4_0x55aa tlib000018 (  .i0(inverta_dataa), .i3(1'b0), .o(cout1) );
x_lut4_0x55aa tlib000019 (  .i0(inverta_dataa), .i3(1'b0), .o(cout) );
endmodule

module lcell_stratix_oa_sd_cf_c0f_c1f_55aa ( dataa, inverta, combout, cout, cout0, cout1 );

input dataa, inverta ;

output cout, cout0, cout1, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sd_cf_c0f_c1f_55aa tlib000001 (  .dataa(dataa), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

endmodule

module x_lut4_0xa000 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst197025  ( .c(i3), .b(i0), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_a000 ( dataa, datad, inverta, qfbkin, combout );
input dataa, datad, inverta, qfbkin ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa000 tlib000006 (  .i0(inverta_dataa), .i2(qfbkin), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_a000 ( clk, dataa, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_a000 tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_oa_sc_cf_c0tx_c1tx_5a5f ( dataa, cin0, cin1, inverta, combout, cout, cout0, cout1 );

input dataa, cin0, cin1, inverta ;

output cout, cout0, cout1, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_5a5f tlib000001 (  .dataa(dataa), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

endmodule

module lcell_stratix_oa_sc_cf_c0tx_c1tx_c30c ( dataa, datab, cin0, cin1, inverta, combout, cout, cout0, cout1 );

input dataa, datab, cin0, cin1, inverta ;

output cout, cout0, cout1, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_cf_c0tx_c1tx_c30c tlib000001 (  .dataa(dataa), .datab(datab), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

endmodule

module x_lut4_0x2aaa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst048798  ( .b(n36), .a(i0), .z(o) );
na3 inst048799  ( .c(i3), .b(i1), .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2aaa (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2aaa tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2aaa ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2aaa tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x70f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst136498  ( .b(n36), .a(i2), .z(o) );
na3 inst136499  ( .c(i3), .b(i0), .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_70f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x70f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_70f0 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_70f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_oa_sc_ct_c0f_c1f_c30c (dataa,datab,cin,cin0,cin1,inverta,combout,cout,cout0,cout1);
input dataa, datab, cin, cin0, cin1, inverta;
output combout, cout, cout0, cout1;
supply0 VSS;
supply1 VDD;
xo2 tlib000066 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc30c tlib000067 (  .i1(datab), .i2(cin), .i3(1'b1), .o(combout) );
x_lut4_0xc30c tlib000068 (  .i1(datab), .i2(cin0), .i3(1'b0), .o(cout0) );
x_lut4_0xc30c tlib000069 (  .i1(datab), .i2(cin1), .i3(1'b0), .o(cout1) );
x_lut4_0xc30c tlib000070 (  .i1(datab), .i2(cin), .i3(1'b0), .o(cout) );
endmodule

module lcell_stratix_oa_sc_ct_c0f_c1f_c30c ( dataa, datab, cin, cin0, cin1, inverta, combout, cout, cout0, cout1 );

input dataa, datab, cin, cin0, cin1, inverta ;

output cout, cout0, cout1, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_oa_sc_ct_c0f_c1f_c30c tlib000001 (  .dataa(dataa), .datab(datab), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout), .cout(cout), .cout0(cout0), .cout1(cout1) );

endmodule

module x_lut4_0x0ff0 ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst016907  ( .b(i2), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sc_ct_c0tx_c1tx_0ff0 ( dataa, datad, cin, cin0, cin1, inverta, combout );
input dataa, datad, cin, cin0, cin1, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000007 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
mx21 tlib000008 ( .z(cin_int), .a(cin0), .b(cin1), .sb(cin) );
x_lut4_0x0ff0 tlib000009 (  .i2(cin_int), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sc_ct_c0tx_c1tx_0ff0 ( dataa, datad, cin, cin0, cin1, inverta, combout );

input dataa, datad, cin, cin0, cin1, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sc_ct_c0tx_c1tx_0ff0 tlib000001 (  .dataa(dataa), .datad(datad), .cin(cin), .cin0(cin0), .cin1(cin1), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0504 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst005283  ( .c(n36), .b(i2), .a(i0), .zn(o) );
no2 inst005284  ( .b(i3), .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0504 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0504 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0504 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0504 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa022 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst197150  ( .b(i0), .a(n36), .z(o) );
mx21i inst197151  ( .sb(i3), .b(n37), .a(i1), .zn(n36) );
i1 inst197152  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a022 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa022 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a022 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a022 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbbab ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst230924  ( .b(i0), .a(n35), .z(o) );
aoi21 inst230925  ( .b(i1), .a2(n36), .a1(i2), .zn(n35) );
i1 inst230926  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bbab (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbbab tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bbab ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bbab tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0040 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0040 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0001 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0001 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xcac0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst249379  ( .b(i0), .a(i3), .z(n35) );
mx21 inst249380  ( .sb(i2), .b(i1), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cac0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcac0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cac0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cac0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0800 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an4 inst008436  ( .d(n35), .c(i0), .b(i1), .a(i3), .z(o) );
i1 inst008437  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0800 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0800 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0800 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0800 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x00af ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst001110  ( .b(i3), .a2(n35), .a1(i2), .zn(o) );
i1 inst001111  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00af ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00af tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00af ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00af tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf1f3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst298180  ( .b(i2), .a(n35), .z(o) );
aoi21 inst298181  ( .b(i1), .a2(i0), .a1(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f1f3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf1f3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f1f3 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f1f3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x3000 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst055707  ( .c(i3), .b(n36), .a(i2), .z(o) );
i1 inst055708  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3000 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x5000 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst094630  ( .c(i3), .b(n36), .a(i2), .z(o) );
i1 inst094631  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5000 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5000 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5000 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5000 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xc888 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst246686  ( .b(n36), .a(n35), .zn(o) );
aoi21 inst246687  ( .b(i0), .a2(i2), .a1(i3), .zn(n35) );
i1 inst246688  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_c888 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc888 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c888 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_c888 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x00df ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi31 inst001253  ( .b(i3), .a3(i2), .a2(n36), .a1(i0), .zn(o) );
i1 inst001254  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00df (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00df tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00df ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00df tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xee0f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst293956  ( .b(i1), .a(i0), .zn(n35) );
mx21i inst293957  ( .sb(i3), .b(n35), .a(i2), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ee0f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xee0f tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ee0f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ee0f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xdccc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst272106  ( .a(n36), .zn(o) );
aoi31 inst272107  ( .b(i1), .a3(i3), .a2(n37), .a1(i2), .zn(n36) );
i1 inst272108  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_dccc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xdccc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_dccc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_dccc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3fff ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst074639  ( .c(i3), .b(i1), .a(i2), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3fff (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3fff tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3fff ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3fff tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_8000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x8000 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_8000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_8000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x008b ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst000999  ( .b(n36), .a(i3), .zn(o) );
mx21i inst001000  ( .sb(i1), .b(i0), .a(n37), .zn(n36) );
i1 inst001001  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_008b (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x008b tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_008b ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_008b tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf3d3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst300411  ( .c(i2), .b(n36), .a(i0), .zn(n35) );
mx21 inst300412  ( .sb(i1), .b(i2), .a(n35), .z(o) );
i1 inst300413  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f3d3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf3d3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f3d3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f3d3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_0200 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0200 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0200 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0200 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xc505 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst242237  ( .sb(i2), .b(n35), .a(i0), .zn(o) );
na2 inst242238  ( .b(i1), .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_c505 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc505 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_c505 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_c505 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf1fb ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst298207  ( .b(n36), .a(i2), .z(o) );
mx21i inst298208  ( .sb(i0), .b(i3), .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f1fb (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf1fb tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f1fb ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f1fb tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfb01 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst309136  ( .b(i0), .a(i2), .zn(n36) );
mx21i inst309137  ( .sb(n36), .b(i1), .a(n37), .zn(o) );
i1 inst309138  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fb01 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfb01 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_fb01 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fb01 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xc8cd ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst246985  ( .b(i0), .a(i2), .zn(n36) );
mx21i inst246986  ( .sb(n36), .b(i3), .a(n37), .zn(o) );
i1 inst246987  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_c8cd (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc8cd tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c8cd ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_c8cd tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xd700 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst264555  ( .b(n36), .a2(n35), .a1(i0), .zn(o) );
i1 inst264556  ( .a(i3), .zn(n36) );
xo2 inst264557  ( .b(i1), .a(i2), .z(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_d700 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xd700 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_d700 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_d700 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xa8ab ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst207282  ( .b(i1), .a(i2), .zn(n36) );
mx21i inst207283  ( .sb(n36), .b(i3), .a(n37), .zn(o) );
i1 inst207284  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a8ab (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa8ab tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a8ab ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a8ab tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xe0f1 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst277080  ( .b(i0), .a(i1), .zn(n36) );
mx21i inst277081  ( .sb(n36), .b(i3), .a(n37), .zn(o) );
i1 inst277082  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_e0f1 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xe0f1 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_e0f1 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_e0f1 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xf0f4 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst297031  ( .a(n36), .zn(o) );
aoi21 inst297032  ( .b(i2), .a2(i1), .a1(n37), .zn(n36) );
no2 inst297033  ( .b(i0), .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f0f4 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf0f4 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f0f4 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f0f4 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x05cc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst006020  ( .b(i0), .a(i2), .zn(n35) );
mx21 inst006021  ( .sb(i3), .b(n35), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_05cc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x05cc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_05cc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_05cc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xe232 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst278618  ( .b(i0), .a2(n37), .a1(i2), .zn(n36) );
i1 inst278619  ( .a(i3), .zn(n37) );
mx21i inst278620  ( .sb(i1), .b(n38), .a(n36), .zn(o) );
na2 inst278621  ( .b(i2), .a(i3), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_e232 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xe232 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_e232 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_e232 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0fee ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst016903  ( .b(i1), .a(i0), .zn(n35) );
mx21i inst016904  ( .sb(i3), .b(i2), .a(n35), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0fee (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0fee tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0fee ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0fee tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0a0c ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst010749  ( .b(n36), .a(i2), .zn(o) );
mx21i inst010750  ( .sb(i3), .b(i0), .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0a0c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0a0c tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0a0c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0a0c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x30c0 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst056472  ( .b(n36), .a(i2), .z(o) );
xo2 inst056473  ( .b(i1), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_30c0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x30c0 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_30c0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_30c0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x4022 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst074778  ( .b(n37), .a(n36), .z(o) );
na2 inst074779  ( .b(n39), .a(i2), .zn(n38) );
i1 inst074780  ( .a(i0), .zn(n39) );
xn2 inst074781  ( .b(i3), .a(i1), .zn(n37) );
mx21i inst074782  ( .sb(i1), .b(n38), .a(n39), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_4022 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4022 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_4022 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4022 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf3a3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst300211  ( .b(i3), .a(i0), .zn(n35) );
mx21i inst300212  ( .sb(i2), .b(n35), .a(i1), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f3a3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf3a3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f3a3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f3a3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa808 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst206593  ( .b(i0), .a(n36), .z(o) );
mx21 inst206594  ( .sb(i2), .b(i3), .a(i1), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a808 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa808 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a808 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a808 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfcb8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst311137  ( .b(i3), .a(i0), .z(n35) );
mx21 inst311138  ( .sb(i1), .b(n35), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fcb8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfcb8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fcb8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fcb8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0b0f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi31 inst011775  ( .b(i2), .a3(i3), .a2(n36), .a1(i1), .zn(o) );
i1 inst011776  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0b0f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0b0f tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0b0f ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0b0f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x2030 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst036016  ( .b(i2), .a(n36), .z(o) );
aoi21 inst036017  ( .b(i1), .a2(n37), .a1(i3), .zn(n36) );
i1 inst036018  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2030 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2030 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2030 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2030 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf400 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst300578  ( .b(i3), .a(n35), .z(o) );
aoi21 inst300579  ( .b(i2), .a2(n37), .a1(i1), .zn(n36) );
i1 inst300580  ( .a(i0), .zn(n37) );
i1 inst300581  ( .a(n36), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f400 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf400 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f400 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f400 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0f8f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst016545  ( .b(n36), .a(i2), .zn(o) );
i1 inst016546  ( .a(i3), .zn(n37) );
na3 inst016547  ( .c(i1), .b(n37), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0f8f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0f8f tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f8f ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f8f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0a00 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst010715  ( .c(i3), .b(n36), .a(i0), .z(o) );
i1 inst010716  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0a00 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0a00 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0a00 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0a00 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_0080 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0080 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0080 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0080 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xffbf ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst314260  ( .c(n35), .b(i1), .a(i2), .zn(o) );
no2 inst314261  ( .b(i0), .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ffbf (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xffbf tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ffbf ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ffbf tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0101 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst001341  ( .c(i1), .b(i2), .a(i0), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0101 ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0101 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0101 ( dataa, datab, datac, inverta, combout );

input dataa, datab, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0101 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0f0e ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst016095  ( .b(n36), .a(i2), .zn(o) );
no3 inst016096  ( .c(i1), .b(i3), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0f0e (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0f0e tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0f0e ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0f0e tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x4a40 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst087191  ( .sb(i0), .b(n37), .a(n36), .zn(o) );
na2 inst087192  ( .b(n38), .a(i3), .zn(n37) );
na2 inst087193  ( .b(i1), .a(i2), .zn(n36) );
i1 inst087194  ( .a(i2), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_4a40 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4a40 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_4a40 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4a40 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_a000 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa000 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a000 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a000 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaaaa ( i0, o );

input i0 ;
output  o;

supply0 VSS;
supply1 VDD;

b1 inst209576  ( .z(o),.a(i0) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aaaa ( dataa, inverta, combout );
input dataa, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaaaa tlib000004 (  .i0(inverta_dataa), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_aaaa ( clk, dataa, datac, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aaaa tlib000001 (  .dataa(dataa), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0555 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst005558  ( .b(i0), .a2(i2), .a1(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0555 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0555 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0555 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0555 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0008 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000639  ( .c(i2), .b(i3), .a(n35), .zn(o) );
na2 inst000640  ( .b(i0), .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0008 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0008 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0008 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0008 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x6444 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst119393  ( .sb(i1), .b(i0), .a(n35), .zn(o) );
na3 inst119394  ( .c(i3), .b(i2), .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_6444 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x6444 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_6444 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_6444 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2200 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst038113  ( .c(i3), .b(n36), .a(i0), .z(o) );
i1 inst038114  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2200 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2200 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2200 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2200 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xfffe ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or4 inst314429  ( .d(i2), .c(i3), .b(i0), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_fffe (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfffe tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fffe ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_fffe tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x33f3 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst059784  ( .b(i1), .a2(n35), .a1(i3), .zn(o) );
i1 inst059785  ( .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_33f3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33f3 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_33f3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_33f3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x9966 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst188253  ( .b(n36), .a(i0), .z(o) );
xo2 inst188254  ( .b(i1), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_9966 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x9966 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_9966 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_9966 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_55aa ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_55aa tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x0a0a ( i0, i2, o );

input i0, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst010744  ( .b(n36), .a(i2), .zn(o) );
i1 inst010745  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0a0a ( dataa, datac, inverta, combout );
input dataa, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0a0a tlib000004 (  .i0(inverta_dataa), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0a0a ( dataa, datac, inverta, combout );

input dataa, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0a0a tlib000001 (  .dataa(dataa), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf3e2 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst300478  ( .b(i3), .a(i0), .z(n35) );
mx21 inst300479  ( .sb(i1), .b(i2), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f3e2 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf3e2 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f3e2 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f3e2 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0x30ba ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai22 inst056453  ( .b2(n37), .b1(i3), .a2(n36), .a1(i1), .zn(o) );
i1 inst056454  ( .a(i0), .zn(n37) );
i1 inst056455  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_30ba (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x30ba tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_30ba ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_30ba tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00c0 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00c0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xb8f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst227556  ( .b(i1), .a(i3), .z(n36) );
mx21 inst227557  ( .sb(n36), .b(i0), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_b8f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xb8f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_b8f0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_b8f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xee22 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21 inst294038  ( .sb(i1), .b(i3), .a(i0), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ee22 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xee22 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_ee22 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ee22 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0020 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0020 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0080 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0080 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff9f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na3 inst314166  ( .c(i2), .b(n37), .a(n36), .zn(o) );
xo2 inst314167  ( .b(i0), .a(i1), .z(n36) );
i1 inst314168  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff9f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff9f tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff9f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff9f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf00f ( i2, i3, o );

input i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xn2 inst296206  ( .b(i2), .a(i3), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f00f ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf00f tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f00f ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f00f tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xc000 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst236555  ( .c(i3), .b(i1), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_c000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc000 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_c000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_c000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x4051 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst074971  ( .b(n36), .a(i0), .zn(o) );
mx21i inst074972  ( .sb(i1), .b(i2), .a(n37), .zn(n36) );
i1 inst074973  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_4051 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4051 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_4051 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4051 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x33b3 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst059556  ( .b(n36), .a(i1), .zn(o) );
i1 inst059557  ( .a(i3), .zn(n37) );
na3 inst059558  ( .c(i2), .b(n37), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_33b3 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x33b3 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_33b3 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_33b3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x00a0 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst001067  ( .c(i2), .b(n36), .a(i0), .z(o) );
i1 inst001068  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00a0 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00a0 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00a0 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00a0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00aa ( dataa, datad, inverta, combout );

input dataa, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00aa tlib000001 (  .dataa(dataa), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xd9c8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst268134  ( .b(i0), .a(i2), .zn(n36) );
mx21i inst268135  ( .sb(i1), .b(n36), .a(n37), .zn(o) );
na2 inst268136  ( .b(n38), .a(i3), .zn(n37) );
i1 inst268137  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_d9c8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xd9c8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_d9c8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_d9c8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x20ec ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst036861  ( .sb(i1), .b(i3), .a(n35), .zn(o) );
na2 inst036862  ( .b(i0), .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_20ec (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x20ec tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_20ec ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_20ec tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaacc ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21 inst209685  ( .sb(i3), .b(i0), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aacc ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaacc tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_aacc ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aacc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_7744 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_7744 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xb000 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst215880  ( .a(i1), .zn(n36) );
oai211 inst215881  ( .c(i2), .b(i3), .a2(n36), .a1(i0), .zn(n37) );
i1 inst215882  ( .a(n37), .zn(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_b000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xb000 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_b000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_b000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf4f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst301750  ( .a(n36), .zn(o) );
aoi31 inst301751  ( .b(i2), .a3(i3), .a2(n37), .a1(i1), .zn(n36) );
i1 inst301752  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f4f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf4f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f4f0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f4f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbfff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na4 inst236553  ( .d(n35), .c(i1), .b(i2), .a(i3), .zn(o) );
i1 inst236554  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bfff (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbfff tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bfff ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bfff tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3a0a ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst067465  ( .b(n36), .a(i1), .zn(n35) );
mx21 inst067466  ( .sb(i2), .b(n35), .a(i0), .z(o) );
i1 inst067467  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3a0a (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3a0a tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3a0a ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3a0a tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff88 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst314084  ( .a(n35), .zn(o) );
aoi21 inst314085  ( .b(i3), .a2(i0), .a1(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff88 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff88 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff88 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff88 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xee30 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst294099  ( .b(i1), .a(i0), .zn(n36) );
mx21i inst294100  ( .sb(i3), .b(n36), .a(n37), .zn(o) );
na2 inst294101  ( .b(n38), .a(i2), .zn(n37) );
i1 inst294102  ( .a(i1), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ee30 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xee30 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ee30 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ee30 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbbc0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst230993  ( .b(n37), .a(i0), .zn(n36) );
mx21i inst230994  ( .sb(i3), .b(n36), .a(n38), .zn(o) );
na2 inst230995  ( .b(i1), .a(i2), .zn(n38) );
i1 inst230996  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bbc0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbbc0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bbc0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bbc0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xb8e2 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst227479  ( .a(n36), .zn(o) );
aoi22 inst227480  ( .b2(n38), .b1(i0), .a2(n37), .a1(i2), .zn(n36) );
xo2 inst227481  ( .b(i1), .a(i3), .z(n37) );
xn2 inst227482  ( .b(i3), .a(i1), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_b8e2 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xb8e2 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_b8e2 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_b8e2 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xccf0 ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

mx21 inst251815  ( .sb(i3), .b(i1), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ccf0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xccf0 tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ccf0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ccf0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0088 ( i0, i1, i3, o );

input i0, i1, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

an3 inst000991  ( .c(i1), .b(n36), .a(i0), .z(o) );
i1 inst000992  ( .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0088 ( dataa, datab, datad, inverta, combout );
input dataa, datab, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0088 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0088 ( dataa, datab, datad, inverta, combout );

input dataa, datab, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0088 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa0aa ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst197669  ( .b(n36), .a2(n35), .a1(i3), .zn(o) );
i1 inst197670  ( .a(i2), .zn(n35) );
i1 inst197671  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a0aa ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa0aa tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a0aa ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a0aa tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfaca ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst308940  ( .b(i3), .a(i1), .z(n35) );
mx21 inst308941  ( .sb(i2), .b(n35), .a(i0), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_faca (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfaca tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_faca ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_faca tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xe6c4 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst284415  ( .b(n37), .a(i2), .zn(n36) );
mx21i inst284416  ( .sb(i1), .b(n36), .a(n38), .zn(o) );
na2 inst284417  ( .b(i0), .a(i3), .zn(n38) );
i1 inst284418  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_e6c4 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xe6c4 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_e6c4 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_e6c4 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaab8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst209621  ( .b(i1), .a(i3), .zn(n36) );
mx21 inst209622  ( .sb(n36), .b(i2), .a(i0), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aab8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaab8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aab8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aab8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xcf3f ( i1, i2, i3, o );

input i1, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst254516  ( .b(n36), .a(i2), .zn(o) );
xo2 inst254517  ( .b(i1), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cf3f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcf3f tlib000004 (  .i1(datab), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cf3f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cf3f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x5002 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst094635  ( .b(n37), .a(n36), .zn(o) );
no2 inst094636  ( .b(i2), .a(i1), .zn(n38) );
xo2 inst094637  ( .b(i2), .a(i3), .z(n36) );
mx21i inst094638  ( .sb(i0), .b(n38), .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5002 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5002 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5002 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5002 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaeaa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst214328  ( .a(n36), .zn(o) );
aoi31 inst214329  ( .b(i0), .a3(i3), .a2(n37), .a1(i1), .zn(n36) );
i1 inst214330  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aeaa (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaeaa tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aeaa ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aeaa tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0202 ( i0, i1, i2, o );

input i0, i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst002278  ( .c(i1), .b(i2), .a(n36), .zn(o) );
i1 inst002279  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0202 ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0202 tlib000004 (  .i0(inverta_dataa), .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0202 ( dataa, datab, datac, inverta, combout );

input dataa, datab, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0202 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0010 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0010 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff72 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst314009  ( .b(n36), .a(i3), .z(o) );
mx21i inst314010  ( .sb(i0), .b(i1), .a(n37), .zn(n36) );
i1 inst314011  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff72 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff72 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff72 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff72 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ce00 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ce00 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0567 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst005622  ( .a(i1), .zn(n36) );
no2 inst005623  ( .b(i1), .a(i3), .zn(n37) );
oai21 inst005624  ( .b(i2), .a2(n36), .a1(i3), .zn(n38) );
mx21 inst005625  ( .sb(i0), .b(n37), .a(n38), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0567 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0567 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0567 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0567 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xefee ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst296089  ( .b(n37), .a2(n36), .a1(i2), .zn(o) );
i1 inst296090  ( .a(i3), .zn(n36) );
no2 inst296091  ( .b(i0), .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_efee (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xefee tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_efee ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_efee tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xef1f ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst295126  ( .b(i2), .a(n36), .zn(o) );
or2 inst295127  ( .b(i0), .a(i1), .z(n37) );
xo2 inst295128  ( .b(i3), .a(n37), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ef1f (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xef1f tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ef1f ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ef1f tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xeeae ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst294686  ( .b(n35), .a(i0), .z(o) );
oai21 inst294687  ( .b(i1), .a2(n37), .a1(i3), .zn(n36) );
i1 inst294688  ( .a(i2), .zn(n37) );
i1 inst294689  ( .a(n36), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_eeae (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xeeae tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_eeae ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_eeae tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfdfc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst312566  ( .b(n37), .a2(n36), .a1(i0), .zn(o) );
i1 inst312567  ( .a(i3), .zn(n36) );
no2 inst312568  ( .b(i1), .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fdfc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfdfc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fdfc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fdfc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x545c ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst099678  ( .b(n37), .a2(n36), .a1(i0), .zn(o) );
no2 inst099679  ( .b(i3), .a(i2), .zn(n38) );
i1 inst099680  ( .a(i0), .zn(n39) );
i1 inst099681  ( .a(i2), .zn(n36) );
oai21 inst099682  ( .b(i1), .a2(n39), .a1(n38), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_545c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x545c tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_545c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_545c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfacc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst308945  ( .b(i2), .a(i0), .z(n35) );
mx21 inst308946  ( .sb(i3), .b(n35), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_facc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfacc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_facc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_facc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x1434 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst021378  ( .a(i2), .zn(n35) );
no2 inst021379  ( .b(i0), .a(i2), .zn(n36) );
aoi21 inst021380  ( .b(n35), .a2(i0), .a1(i3), .zn(n37) );
mx21 inst021381  ( .sb(i1), .b(n36), .a(n37), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_1434 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x1434 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_1434 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_1434 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x5808 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst103797  ( .sb(i0), .b(n37), .a(n36), .zn(o) );
na2 inst103798  ( .b(n38), .a(i1), .zn(n37) );
na2 inst103799  ( .b(i2), .a(i3), .zn(n36) );
i1 inst103800  ( .a(i2), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_5808 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x5808 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_5808 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_5808 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0caa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst013529  ( .b(n36), .a(i2), .zn(n35) );
mx21 inst013530  ( .sb(i3), .b(n35), .a(i0), .z(o) );
i1 inst013531  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0caa (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0caa tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0caa ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0caa tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xd080 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst256022  ( .b(i2), .a(n36), .z(o) );
mx21 inst256023  ( .sb(i0), .b(i1), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_d080 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xd080 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_d080 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_d080 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xef67 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst295463  ( .b(i1), .a(i0), .z(n36) );
na3 inst295464  ( .c(i2), .b(n39), .a(n38), .zn(n37) );
mx21 inst295465  ( .sb(n36), .b(i3), .a(n37), .z(o) );
i1 inst295466  ( .a(i1), .zn(n38) );
i1 inst295467  ( .a(i0), .zn(n39) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ef67 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xef67 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ef67 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ef67 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf0f8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst297041  ( .a(n36), .zn(o) );
aoi31 inst297042  ( .b(i2), .a3(i1), .a2(n37), .a1(i0), .zn(n36) );
i1 inst297043  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f0f8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf0f8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f0f8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f0f8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xffec ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst314395  ( .b(i0), .a(i2), .z(n36) );
or3 inst314396  ( .c(n36), .b(i1), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ffec (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xffec tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ffec ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ffec tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf1f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst298172  ( .a(n36), .zn(o) );
aoi21 inst298173  ( .b(i2), .a2(i3), .a1(n37), .zn(n36) );
no2 inst298174  ( .b(i0), .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f1f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf1f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f1f0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f1f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaea2 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst214297  ( .b(n37), .a(i2), .zn(n36) );
mx21 inst214298  ( .sb(n36), .b(i3), .a(i0), .z(o) );
i1 inst214299  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aea2 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaea2 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aea2 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aea2 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf8f0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst306635  ( .a(n36), .zn(o) );
aoi31 inst306636  ( .b(i2), .a3(i3), .a2(i0), .a1(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f8f0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf8f0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f8f0 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f8f0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xe040 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst276302  ( .b(i2), .a(n36), .z(o) );
mx21 inst276303  ( .sb(i0), .b(i3), .a(i1), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_e040 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xe040 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_e040 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_e040 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x00d5 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

aoi21 inst001223  ( .b(i3), .a2(n35), .a1(i0), .zn(o) );
na2 inst001224  ( .b(i1), .a(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00d5 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00d5 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00d5 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00d5 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfefa ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or3 inst313642  ( .c(n36), .b(i0), .a(i2), .z(o) );
an2 inst313643  ( .b(i1), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fefa (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfefa tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fefa ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fefa tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x08ff ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst009549  ( .b(n36), .a(i3), .zn(o) );
i1 inst009550  ( .a(i2), .zn(n37) );
na3 inst009551  ( .c(i1), .b(n37), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_08ff (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x08ff tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_08ff ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_08ff tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf888 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst306127  ( .a(n36), .zn(o) );
aoi22 inst306128  ( .b2(i2), .b1(i3), .a2(i0), .a1(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f888 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf888 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f888 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f888 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa8a0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst207244  ( .b(n36), .a(n35), .zn(o) );
aoi21 inst207245  ( .b(i2), .a2(i1), .a1(i3), .zn(n35) );
i1 inst207246  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a8a0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa8a0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a8a0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a8a0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf5e4 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst302854  ( .b(i3), .a(i1), .z(n35) );
mx21 inst302855  ( .sb(i0), .b(i2), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f5e4 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf5e4 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f5e4 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f5e4 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf9ca ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst307770  ( .b(n36), .a(n35), .zn(o) );
an2 inst307771  ( .b(i0), .a(n38), .z(n37) );
oai21 inst307772  ( .b(n38), .a2(i0), .a1(i1), .zn(n39) );
i1 inst307773  ( .a(i2), .zn(n38) );
oai21 inst307774  ( .b(i1), .a2(i2), .a1(i0), .zn(n36) );
mx21i inst307775  ( .sb(i3), .b(n39), .a(n37), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f9ca (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf9ca tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f9ca ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f9ca tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x05c0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst005975  ( .a(i3), .zn(n36) );
mx21i inst005976  ( .sb(i2), .b(n38), .a(n37), .zn(o) );
na2 inst005977  ( .b(n36), .a(i1), .zn(n38) );
or2 inst005978  ( .b(n36), .a(i0), .z(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_05c0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x05c0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_05c0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_05c0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2000 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an4 inst035828  ( .d(n35), .c(i0), .b(i2), .a(i3), .z(o) );
i1 inst035829  ( .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2000 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2000 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2000 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2000 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0311 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst003359  ( .b(n36), .a(i1), .zn(o) );
mx21 inst003360  ( .sb(i3), .b(i2), .a(i0), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0311 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0311 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0311 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0311 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xefa0 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst295753  ( .b(n37), .a(n36), .zn(o) );
i1 inst295754  ( .a(i2), .zn(n38) );
oai21 inst295755  ( .b(i3), .a2(n38), .a1(i1), .zn(n37) );
na2 inst295756  ( .b(i2), .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_efa0 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xefa0 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_efa0 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_efa0 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff80 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst314053  ( .a(n36), .zn(o) );
aoi31 inst314054  ( .b(i3), .a3(i2), .a2(i0), .a1(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff80 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff80 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff80 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff80 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xfdec ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst312512  ( .b(n36), .a(i1), .z(o) );
mx21 inst312513  ( .sb(i0), .b(i2), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fdec (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfdec tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fdec ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fdec tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfefc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst313646  ( .b(i0), .a(i3), .z(n36) );
or3 inst313647  ( .c(n36), .b(i1), .a(i2), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fefc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfefc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fefc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fefc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xe222 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst278544  ( .b(i2), .a(i3), .z(n35) );
mx21 inst278545  ( .sb(i1), .b(n35), .a(i0), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_e222 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xe222 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_e222 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_e222 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfaf0 ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst309088  ( .a(n35), .zn(o) );
aoi21 inst309089  ( .b(i2), .a2(i0), .a1(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_faf0 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfaf0 tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_faf0 ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_faf0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_a888 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a888 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfcac ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst311082  ( .b(i3), .a(i0), .z(n35) );
mx21 inst311083  ( .sb(i2), .b(n35), .a(i1), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fcac (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfcac tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_fcac ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fcac tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xf838 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst305748  ( .b(n37), .a(i3), .zn(n36) );
mx21i inst305749  ( .sb(i2), .b(n36), .a(n38), .zn(o) );
na2 inst305750  ( .b(i0), .a(i1), .zn(n38) );
i1 inst305751  ( .a(i1), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f838 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf838 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f838 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f838 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbbb8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst230971  ( .b(i3), .a(i2), .z(n35) );
mx21 inst230972  ( .sb(i1), .b(i0), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bbb8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbbb8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_bbb8 ( clk, dataa, datab, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bbb8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xbefc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst235348  ( .b(n37), .a(n36), .z(o) );
xo2 inst235349  ( .b(i1), .a(i2), .z(n36) );
mx21 inst235350  ( .sb(i3), .b(i0), .a(i1), .z(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_befc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbefc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_befc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_befc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xcd01 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst251867  ( .b(i0), .a(i2), .zn(n35) );
mx21 inst251868  ( .sb(i1), .b(i3), .a(n35), .z(o) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_cd01 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xcd01 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_cd01 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_cd01 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0002 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no4 inst000630  ( .d(n35), .c(i1), .b(i2), .a(i3), .zn(o) );
i1 inst000631  ( .a(i0), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0002 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0002 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0002 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0002 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x3830 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst064951  ( .sb(i2), .b(i1), .a(n35), .zn(o) );
na3 inst064952  ( .c(i3), .b(i0), .a(i1), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_3830 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x3830 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_3830 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_3830 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xbb05 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst230145  ( .b(i2), .a(i0), .zn(n36) );
na2 inst230146  ( .b(n38), .a(i1), .zn(n37) );
mx21 inst230147  ( .sb(i3), .b(n37), .a(n36), .z(o) );
i1 inst230148  ( .a(i0), .zn(n38) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_bb05 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xbb05 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_bb05 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_bb05 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x4ccc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst090532  ( .b(n36), .a(i1), .z(o) );
na3 inst090533  ( .c(i3), .b(i0), .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_4ccc (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x4ccc tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_4ccc ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_4ccc tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xfcee ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst311357  ( .b(n36), .a(i1), .z(o) );
mx21 inst311358  ( .sb(i3), .b(i2), .a(i0), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_fcee (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfcee tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_fcee ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_fcee tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x020e ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst002312  ( .b(n36), .a(i2), .zn(o) );
mx21i inst002313  ( .sb(i1), .b(n37), .a(i0), .zn(n36) );
i1 inst002314  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_020e (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x020e tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_020e ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_020e tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xaeee ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst214652  ( .a(n35), .zn(o) );
aoi21 inst214653  ( .b(i0), .a2(n36), .a1(i1), .zn(n35) );
na2 inst214654  ( .b(i2), .a(i3), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_aeee (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xaeee tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_aeee ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_aeee tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2e0c ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

mx21i inst053286  ( .sb(i1), .b(i2), .a(n35), .zn(o) );
na2 inst053287  ( .b(i0), .a(i3), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2e0c (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2e0c tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2e0c ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2e0c tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x00ea ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst001288  ( .b(n35), .a(i3), .zn(o) );
aoi21 inst001289  ( .b(i0), .a2(i1), .a1(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_00ea (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x00ea tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_00ea ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_00ea tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff13 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

or2 inst313702  ( .b(i3), .a(n35), .z(o) );
aoi21 inst313703  ( .b(i1), .a2(i0), .a1(i2), .zn(n35) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff13 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff13 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff13 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff13 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x08c8 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst009302  ( .b(i1), .a(n36), .z(o) );
mx21i inst009303  ( .sb(i2), .b(i3), .a(n37), .zn(n36) );
i1 inst009304  ( .a(i0), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_08c8 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x08c8 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_08c8 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_08c8 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xff08 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

i1 inst313671  ( .a(n36), .zn(o) );
aoi31 inst313672  ( .b(i3), .a3(i1), .a2(n37), .a1(i0), .zn(n36) );
i1 inst313673  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_ff08 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xff08 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_ff08 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_ff08 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x2cec ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst051740  ( .b(i2), .a(i3), .z(n36) );
mx21i inst051741  ( .sb(i1), .b(n36), .a(n37), .zn(o) );
na2 inst051742  ( .b(i0), .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_2cec (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x2cec tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_2cec ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_2cec tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x000a ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst000643  ( .c(i2), .b(i3), .a(n36), .zn(o) );
i1 inst000644  ( .a(i0), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_000a ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x000a tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_000a ( dataa, datac, datad, inverta, combout );

input dataa, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_000a tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0x0408 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no3 inst004253  ( .c(n37), .b(i2), .a(n36), .zn(o) );
xn2 inst004254  ( .b(i0), .a(i3), .zn(n37) );
i1 inst004255  ( .a(i1), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_0408 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0408 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_0408 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0408 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xb100 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst217084  ( .b(i3), .a(n36), .z(o) );
mx21i inst217085  ( .sb(i0), .b(n37), .a(i1), .zn(n36) );
i1 inst217086  ( .a(i2), .zn(n37) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_b100 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xb100 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_b100 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_b100 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xf5f4 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

oai21 inst302911  ( .b(n36), .a2(n35), .a1(i0), .zn(o) );
no2 inst302912  ( .b(i3), .a(i1), .zn(n35) );
i1 inst302913  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f5f4 (dataa, datab, datac, datad, inverta, combout);
input dataa, datab, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf5f4 tlib000004 ( .i0(inverta_dataa),.i1(datab),.i2(datac),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f5f4 ( dataa, datab, datac, datad, inverta, combout );

input dataa, datab, datac, datad, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f5f4 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

endmodule

module x_lut4_0xa55a ( i0, i2, i3, o );

input i0, i2, i3 ;
output  o;

supply0 VSS;
supply1 VDD;

xo2 inst203222  ( .b(n36), .a(i0), .z(o) );
xo2 inst203223  ( .b(i2), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_a55a ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xa55a tlib000004 (  .i0(inverta_dataa), .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a55a ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_a55a tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xb8cc ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst227366  ( .b(n37), .a(i0), .zn(n36) );
mx21i inst227367  ( .sb(i1), .b(n36), .a(n38), .zn(o) );
na2 inst227368  ( .b(i2), .a(i3), .zn(n38) );
i1 inst227369  ( .a(i3), .zn(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_b8cc (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xb8cc tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_b8cc ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_b8cc tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xfc11 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

no2 inst310367  ( .b(i2), .a(i1), .zn(n36) );
mx21i inst310368  ( .sb(i3), .b(n36), .a(n37), .zn(o) );
or2 inst310369  ( .b(i0), .a(i1), .z(n37) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_fc11 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xfc11 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fc11 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_fc11 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xc480 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst241649  ( .b(i1), .a(n36), .z(o) );
mx21 inst241650  ( .sb(i0), .b(i2), .a(i3), .z(n36) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_c480 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xc480 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_c480 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_c480 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xf780 ( i0, i1, i2, i3, o );

input   i0, i1, i2, i3;
output  o;

supply0 VSS;
supply1 VDD;

an2 inst304927  ( .b(i0), .a(i1), .z(n36) );
mx21 inst304928  ( .sb(n36), .b(i2), .a(i3), .z(o) );

endmodule


module lcell_async_stratix_on_sq_cx_c0x_c1x_f780 (dataa, datab, datad, inverta, qfbkin, combout);
input dataa, datab, datad, inverta, qfbkin;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000005 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf780 tlib000006 ( .i0(inverta_dataa),.i1(datab),.i2(qfbkin),.i3(datad),.o(combout) );
endmodule

module lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f780 ( clk, dataa, datab, datac, datad, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datab, datac, datad, clk, aclr, aload, sclr, sload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sq_cx_c0x_c1x_f780 tlib000001 (  .dataa(dataa), .datab(datab), .datad(datad), .inverta(inverta), .qfbkin(regout), .combout(combout) );

lcell_reg_stratix_son_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .sclr(sclr), .sload(sload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module lcell_async_stratix_on_sd_cx_c0x_c1x_0ff0 ( dataa, datac, datad, inverta, combout );
input dataa, datac, datad, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0x0ff0 tlib000004 (  .i2(datac), .i3(datad), .o(combout) );
endmodule

module lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0ff0 ( clk, dataa, datac, datad, aclr, aload, ena, inverta, devclrn, devpor, combout, regout );

input dataa, datac, datad, clk, aclr, aload, ena, inverta, devclrn, devpor ;

output regout, combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_0ff0 tlib000001 (  .dataa(dataa), .datac(datac), .datad(datad), .inverta(inverta), .combout(combout) );

lcell_reg_stratix_sof_rof_pol tlib000002 (  .clk(clk), .aclr(aclr), .aload(aload), .ena(ena), .datain(combout), .datac(datac), .devclrn(devclrn), .devpor(devpor), .regout(regout) );

endmodule

module x_lut4_0xf3f3 ( i1, i2, o );

input i1, i2 ;
output  o;

supply0 VSS;
supply1 VDD;

na2 inst300541  ( .b(n36), .a(i1), .zn(o) );
i1 inst300542  ( .a(i2), .zn(n36) );

endmodule


module lcell_async_stratix_on_sd_cx_c0x_c1x_f3f3 ( dataa, datab, datac, inverta, combout );
input dataa, datab, datac, inverta ;
output combout;
supply0 VSS;
supply1 VDD;
xo2 tlib000003 ( .z(inverta_dataa), .a(dataa), .b(inverta) );
x_lut4_0xf3f3 tlib000004 (  .i1(datab), .i2(datac), .o(combout) );
endmodule

module lcell_stratix_on_sd_cx_c0x_c1x_f3f3 ( dataa, datab, datac, inverta, combout );

input dataa, datab, datac, inverta ;

output combout ;
supply0 VSS;
supply1 VDD;
lcell_async_stratix_on_sd_cx_c0x_c1x_f3f3 tlib000001 (  .dataa(dataa), .datab(datab), .datac(datac), .inverta(inverta), .combout(combout) );

endmodule

module cdu ( PCF_INIT, POR, CLK_FPGA, CDU_CLK, PO14, PO13, PO0, CDU_EN, CA0, CA1, RESET_FPGA, CDU_RX, SDI_FPGA, PO1, PO2, SDA_INT, SCL_INT, SDA_IOM_PRIMARY, SCL_IOM_PRIMARY, SDA_IOM_SECONDARY, SCL_IOM_SECONDARY, PO5, PO6, PO3, PO4, SCK_FPGA, SDO_FPGA, CDU_MSG, FRAME_SYNC_FPGA, SLOT_SYNC_FPGA, LED_1_MR, LED_2_MR, IOM_SECONDARY_BUS_ENABLE, CDU_TX, UL_SYNC, CA_ADDR, SCK_MR, SDO_MR, EN_MR, COUPLER_SW_MR, DEBUG_LED1, DEBUG_LED2, DEBUG_LED3, DEBUG_LED4, DEBUG_LED5, DEBUG_LED6, DEBUG_LED7, DEBUG_LED8);
input PCF_INIT;
input POR;
input CLK_FPGA;
input CDU_CLK;
input PO14;
input PO13;
input PO0;
input CDU_EN;
input CA0;
input CA1;
input RESET_FPGA;
input CDU_RX;
input SDI_FPGA;
input PO1;
input PO2;
inout SDA_INT;
inout SCL_INT;
inout SDA_IOM_PRIMARY;
inout SCL_IOM_PRIMARY;
inout SDA_IOM_SECONDARY;
inout SCL_IOM_SECONDARY;
inout PO5;
inout PO6;
inout PO3;
inout PO4;
output SCK_FPGA;
output SDO_FPGA;
output CDU_MSG;
output FRAME_SYNC_FPGA;
output SLOT_SYNC_FPGA;
output LED_1_MR;
output LED_2_MR;
output IOM_SECONDARY_BUS_ENABLE;
output CDU_TX;
output UL_SYNC;
output CA_ADDR;
output SCK_MR;
output SDO_MR;
output EN_MR;
output COUPLER_SW_MR;
output DEBUG_LED1;
output DEBUG_LED2;
output DEBUG_LED3;
output DEBUG_LED4;
output DEBUG_LED5;
output DEBUG_LED6;
output DEBUG_LED7;
output DEBUG_LED8;
cvdd devclrn_inst ( .z(devclrn) );
por devpor_inst ( .zn(devpor_source) );
b1  devpor_to_ckbuf ( .z(devpor), .a(devpor_source) );
// tri0 devoe;
// initial $sdf_annotate("cdu_v.sdo");
TOPLEVEL CDU
            ( .CDU_CLK(CDU_CLK_acombout),
              .PO14(PO14_acombout),
              .PO13(PO13_acombout),
              .CDU_EN(CDU_EN_acombout),
              .RESET_FPGA(RESET_FPGA_acombout),
              .CDU_RX(CDU_RX_acombout),
              .SDI_FPGA(SDI_FPGA_acombout),
              .PO1(PO1_acombout),
              .PO2(PO2_acombout),
              .SDA_INT(SDA_INT_a0),
              .SCL_INT(SCL_INT_a0),
              .SDA_IOM_PRIMARY(SDA_IOM_PRIMARY_a0),
              .SCL_IOM_PRIMARY(SCL_IOM_PRIMARY_a0),
              .RESET_FPGA1(RESET_FPGA_a28),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .SCK(CDU_aSCK_a1),
              .SDO(CDU_aRECEIVE_BLOCK_aSDO),
              .SS_OUT_2(CDU_aRECEIVE_BLOCK_aSS_OUT_a2_a),
              .FRAME_SYNC(CDU_aRECEIVE_BLOCK_aFRAME_SYNC),
              .SLOT_SYNC(CDU_aRECEIVE_BLOCK_aSLOT_SYNC),
              .FAULT_LED(CDU_aLEDDRIVER_BLOCK_aFAULT_LED_a8),
              .OPERATIONAL_LED(CDU_aLEDDRIVER_BLOCK_aOPERATIONAL_LED_a8),
              .CDU_TX(CDU_aTRANSMIT_BLOCK_aCDU_TX_a1),
              .UL_SYNC(CDU_aRECEIVE_BLOCK_aUL_SYNC),
              .DATA_LATCH_7(CDU_aPCF_DEVICE_aDATA_LATCH_a7_a),
              .DATA_LATCH_6(CDU_aPCF_DEVICE_aDATA_LATCH_a6_a),
              .DATA_LATCH_5(CDU_aPCF_DEVICE_aDATA_LATCH_a5_a),
              .DATA_LATCH_4(CDU_aPCF_DEVICE_aDATA_LATCH_a4_a),
              .DATA_LATCH_3(CDU_aPCF_DEVICE_aDATA_LATCH_a3_a),
              .DATA_LATCH_2(CDU_aPCF_DEVICE_aDATA_LATCH_a2_a),
              .DATA_LATCH_1(CDU_aPCF_DEVICE_aDATA_LATCH_a1_a),
              .DATA_LATCH_0(CDU_aPCF_DEVICE_aDATA_LATCH_a0_a),
              .SDA_OUT(CDU_aI2C_DEVICE_aSDA_OUT_a1),
              .SDA_OUT1(CDU_aPCF_DEVICE_aSDA_OUT_a1),
              .DATA_LATCH_21(CDU_aI2C_DEVICE_aDATA_LATCH_a2_a),
              .DATA_LATCH_31(CDU_aI2C_DEVICE_aDATA_LATCH_a3_a) );

// atom is at PIN_18
stratix_input_0XXX0XXUUXX00000 CDU_CLK_aI
            ( .combout(CDU_CLK_acombout),
              .padio(CDU_CLK) );

// atom is at PIN_140
stratix_input_0XXX0XXUUXX00000 PO14_aI
            ( .combout(PO14_acombout),
              .padio(PO14) );

// atom is at PIN_141
stratix_input_0XXX0XXUUXX00000 PO13_aI
            ( .combout(PO13_acombout),
              .padio(PO13) );

// atom is at PIN_21
stratix_input_0XXX0XXUUXX00000 CDU_EN_aI
            ( .combout(CDU_EN_acombout),
              .padio(CDU_EN) );

// atom is at PIN_61
stratix_input_0XXX0XXUUXX00000 RESET_FPGA_aI
            ( .combout(RESET_FPGA_acombout),
              .padio(RESET_FPGA) );

// atom is at PIN_22
stratix_input_0XXX0XXUUXX00000 CDU_RX_aI
            ( .combout(CDU_RX_acombout),
              .padio(CDU_RX) );

// atom is at PIN_102
stratix_input_0XXX0XXUUXX00000 SDI_FPGA_aI
            ( .combout(SDI_FPGA_acombout),
              .padio(SDI_FPGA) );

// atom is at PIN_5
stratix_input_0XXX0XXUUXX00000 PO1_aI
            ( .combout(PO1_acombout),
              .padio(PO1) );

// atom is at PIN_27
stratix_input_0XXX0XXUUXX00000 PO2_aI
            ( .combout(PO2_acombout),
              .padio(PO2) );

// atom is at LC_X7_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_0f0f RESET_FPGA_a28_I
            ( .dataa( vdd ),
              .datac(RESET_FPGA_acombout),
              .inverta( vss ),
              .combout(RESET_FPGA_a28) );

// atom is at PIN_113
stratix_inout_U010X0XXX0XXUUXX00001101000000000000000 SDA_INT_aI
            ( .datain(CDU_aI2C_DEVICE_aSDA_OUT_a1),
              .combout(SDA_INT_a0),
              .padio(SDA_INT) );

// atom is at PIN_118
stratix_inout_1010X0XXX0XXUUXX00001101000000000000000 SCL_INT_aI
            ( .combout(SCL_INT_a0),
              .padio(SCL_INT) );

// atom is at PIN_132
stratix_inout_U010X0XXX0XXUUXX00001101000000000000000 SDA_IOM_PRIMARY_aI
            ( .datain(CDU_aPCF_DEVICE_aSDA_OUT_a1),
              .combout(SDA_IOM_PRIMARY_a0),
              .padio(SDA_IOM_PRIMARY) );

// atom is at PIN_133
stratix_inout_1010X0XXX0XXUUXX00001101000000000000000 SCL_IOM_PRIMARY_aI
            ( .combout(SCL_IOM_PRIMARY_a0),
              .padio(SCL_IOM_PRIMARY) );

// atom is at PIN_4
stratix_input_0XXX0XXUUXX00000 PO0_aI
            ( .combout(PO0_acombout),
              .padio(PO0) );

// atom is at PIN_42
stratix_input_0XXX0XXUUXX00000 CA1_aI
            ( .combout(CA1_acombout),
              .padio(CA1) );

// atom is at PIN_41
stratix_input_0XXX0XXUUXX00000 CA0_aI
            ( .combout(CA0_acombout),
              .padio(CA0) );

// atom is at LC_X2_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_f000 inst1_aI
            ( .dataa( vdd ),
              .datac(CA1_acombout),
              .datad(CA0_acombout),
              .inverta( vss ),
              .combout(inst1) );

// atom is at PIN_103
stratix_output_U010X0XXXXXUXX00000110000000000000000 SCK_FPGA_aI
            ( .datain(CDU_aSCK_a1),
              .padio(SCK_FPGA) );

// atom is at PIN_14
stratix_input_0XXX0XXUXXX00000 PCF_INIT_aI
            ( .padio(PCF_INIT) );

// atom is at PIN_80
stratix_output_U010X0XXXXXUXX00000110000000000000000 SDO_FPGA_aI
            ( .datain(CDU_aRECEIVE_BLOCK_aSDO),
              .padio(SDO_FPGA) );

// atom is at PIN_96
stratix_output_U010X0XXXXXUXX00000110000000000000000 CDU_MSG_aI
            ( .datain( not__CDU_aRECEIVE_BLOCK_aSS_OUT_a2_a ),
              .padio(CDU_MSG) );

// atom is at PIN_95
stratix_output_U010X0XXXXXUXX00000110000000000000000 FRAME_SYNC_FPGA_aI
            ( .datain(CDU_aRECEIVE_BLOCK_aFRAME_SYNC),
              .padio(FRAME_SYNC_FPGA) );

// atom is at PIN_77
stratix_output_U010X0XXXXXUXX00000110000000000000000 SLOT_SYNC_FPGA_aI
            ( .datain(CDU_aRECEIVE_BLOCK_aSLOT_SYNC),
              .padio(SLOT_SYNC_FPGA) );

// atom is at PIN_120
stratix_output_U010X0XXXXXUXX00000110000000000000000 LED_1_MR_aI
            ( .datain(CDU_aLEDDRIVER_BLOCK_aFAULT_LED_a8),
              .padio(LED_1_MR) );

// atom is at PIN_121
stratix_output_U010X0XXXXXUXX00000110000000000000000 LED_2_MR_aI
            ( .datain(CDU_aLEDDRIVER_BLOCK_aOPERATIONAL_LED_a8),
              .padio(LED_2_MR) );

// atom is at PIN_131
stratix_output_U010X0XXXXXUXX00000110000000000000000 IOM_SECONDARY_BUS_ENABLE_aI
            ( .datain(PO0_acombout),
              .padio(IOM_SECONDARY_BUS_ENABLE) );

// atom is at PIN_23
stratix_output_U010X0XXXXXUXX00000110000000000000000 CDU_TX_aI
            ( .datain(CDU_aTRANSMIT_BLOCK_aCDU_TX_a1),
              .padio(CDU_TX) );

// atom is at PIN_130
stratix_output_U010X0XXXXXUXX00000110000000000000000 UL_SYNC_aI
            ( .datain(CDU_aRECEIVE_BLOCK_aUL_SYNC),
              .padio(UL_SYNC) );

// atom is at PIN_3
stratix_output_U010X0XXXXXUXX00000110000000000000000 CA_ADDR_aI
            ( .datain(inst1),
              .padio(CA_ADDR) );

// atom is at PIN_78
stratix_output_0010X0XXXXXUXX00000110000000000000000 SCK_MR_aI
            ( .padio(SCK_MR) );

// atom is at PIN_79
stratix_output_0010X0XXXXXUXX00000110000000000000000 SDO_MR_aI
            ( .padio(SDO_MR) );

// atom is at PIN_86
stratix_output_0010X0XXXXXUXX00000110000000000000000 EN_MR_aI
            ( .padio(EN_MR) );

// atom is at PIN_88
stratix_output_0010X0XXXXXUXX00000110000000000000000 COUPLER_SW_MR_aI
            ( .padio(COUPLER_SW_MR) );

// atom is at PIN_37
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a8_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a7_a ),
              .padio(DEBUG_LED8) );

// atom is at PIN_38
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a7_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a6_a ),
              .padio(DEBUG_LED7) );

// atom is at PIN_39
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a6_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a5_a ),
              .padio(DEBUG_LED6) );

// atom is at PIN_32
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a5_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a4_a ),
              .padio(DEBUG_LED5) );

// atom is at PIN_31
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a4_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a3_a ),
              .padio(DEBUG_LED4) );

// atom is at PIN_30
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a3_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a2_a ),
              .padio(DEBUG_LED3) );

// atom is at PIN_29
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a2_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a1_a ),
              .padio(DEBUG_LED2) );

// atom is at PIN_28
stratix_output_U010X0XXXXXUXX00000110000000000000000 DEBUG_LED_a1_a_aI
            ( .datain( not__CDU_aPCF_DEVICE_aDATA_LATCH_a0_a ),
              .padio(DEBUG_LED1) );

// atom is at PIN_75
stratix_input_0XXX0XXUXXX00000 POR_aI
            ( .padio(POR) );

// atom is at PIN_20
stratix_input_0XXX0XXUXXX00000 CLK_FPGA_aI
            ( .padio(CLK_FPGA) );

// atom is at PIN_58
stratix_inout_1010X0XXX0XXUXXX00001101000000000000000 SDA_IOM_SECONDARY_aI
            ( .padio(SDA_IOM_SECONDARY) );

// atom is at PIN_59
stratix_inout_1010X0XXX0XXUXXX00001101000000000000000 SCL_IOM_SECONDARY_aI
            ( .padio(SCL_IOM_SECONDARY) );

// atom is at PIN_12
stratix_inout_U010X0XXX0XXUXXX00001101000000000000000 PO5_aI
            ( .datain(CA1_acombout),
              .padio(PO5) );

// atom is at PIN_15
stratix_inout_U010X0XXX0XXUXXX00001101000000000000000 PO6_aI
            ( .datain(CA0_acombout),
              .padio(PO6) );

// atom is at PIN_6
stratix_inout_U010X0XXX0XXUXXX00001101000000000000000 PO3_aI
            ( .datain( not__CDU_aI2C_DEVICE_aDATA_LATCH_a2_a ),
              .padio(PO3) );

// atom is at PIN_7
stratix_inout_U010X0XXX0XXUXXX00001101000000000000000 PO4_aI
            ( .datain( not__CDU_aI2C_DEVICE_aDATA_LATCH_a3_a ),
              .padio(PO4) );

endmodule
module TOPLEVEL ( CDU_CLK, PO14, PO13, CDU_EN, RESET_FPGA, CDU_RX, SDI_FPGA, PO1, PO2, SDA_INT, SCL_INT, SDA_IOM_PRIMARY, SCL_IOM_PRIMARY, RESET_FPGA1, devclrn, devpor, devoe, SCK, SDO, SS_OUT_2, FRAME_SYNC, SLOT_SYNC, FAULT_LED, OPERATIONAL_LED, CDU_TX, UL_SYNC, DATA_LATCH_7, DATA_LATCH_6, DATA_LATCH_5, DATA_LATCH_4, DATA_LATCH_3, DATA_LATCH_2, DATA_LATCH_1, DATA_LATCH_0, SDA_OUT, SDA_OUT1, DATA_LATCH_21, DATA_LATCH_31);
input CDU_CLK;
input PO14;
input PO13;
input CDU_EN;
input RESET_FPGA;
input CDU_RX;
input SDI_FPGA;
input PO1;
input PO2;
input SDA_INT;
input SCL_INT;
input SDA_IOM_PRIMARY;
input SCL_IOM_PRIMARY;
input RESET_FPGA1;
input devclrn;
input devpor;
input devoe;
output SCK;
output SDO;
output SS_OUT_2;
output FRAME_SYNC;
output SLOT_SYNC;
output FAULT_LED;
output OPERATIONAL_LED;
output CDU_TX;
output UL_SYNC;
output DATA_LATCH_7;
output DATA_LATCH_6;
output DATA_LATCH_5;
output DATA_LATCH_4;
output DATA_LATCH_3;
output DATA_LATCH_2;
output DATA_LATCH_1;
output DATA_LATCH_0;
output SDA_OUT;
output SDA_OUT1;
output DATA_LATCH_21;
output DATA_LATCH_31;
TRANSMIT TRANSMIT_BLOCK
            ( .safe_q_2(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a2_a),
              .safe_q_4(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a4_a),
              .safe_q_3(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a3_a),
              .safe_q_5(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a5_a),
              .safe_q_0(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a0_a),
              .safe_q_1(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a1_a),
              .SLOT_STATE_0(RECEIVE_BLOCK_aSLOT_STATE_a0_a),
              .SLOT_STATE_1(RECEIVE_BLOCK_aSLOT_STATE_a1_a),
              .SLOT_STATE_2(RECEIVE_BLOCK_aSLOT_STATE_a2_a),
              .BYTE_LATCH(TRANSMIT_BLOCK_aBYTE_LATCH_a4917),
              .LINK_LATCH_7(PICDATA_BLOCK_aLINK_LATCH_a7_a),
              .BYTE_LATCH1(TRANSMIT_BLOCK_aBYTE_LATCH_a1423),
              .BYTE_LATCH3(TRANSMIT_BLOCK_aBYTE_LATCH_a4920),
              .BYTE_LATCH4(TRANSMIT_BLOCK_aBYTE_LATCH_a4921),
              .BYTE_LATCH5(TRANSMIT_BLOCK_aBYTE_LATCH_a4922),
              .BYTE_LATCH6(TRANSMIT_BLOCK_aBYTE_LATCH_a4924),
              .RX_STATE_0(RECEIVE_BLOCK_aRX_STATE_a0_a_a2080),
              .TS_COUNT_2(RECEIVE_BLOCK_aTS_COUNT_a2_a),
              .TS_COUNT_1(RECEIVE_BLOCK_aTS_COUNT_a1_a),
              .TS_COUNT_0(RECEIVE_BLOCK_aTS_COUNT_a0_a),
              .START_SPI(RECEIVE_BLOCK_aSTART_SPI_a25),
              .reduce_nor10(RECEIVE_BLOCK_areduce_nor_a17),
              .SLOT_STATE_11(RECEIVE_BLOCK_aSLOT_STATE_a1_a_a599),
              .BYTE_LATCH_65(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1516),
              .BYTE_LATCH_67(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1507),
              .reduce_nor11(RECEIVE_BLOCK_areduce_nor_a190),
              .BYTE_LATCH_5(TRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1518),
              .BYTE_LATCH_51(TRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1511),
              .BYTE_LATCH_4(TRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1513),
              .LINK_LATCH_4(PICDATA_BLOCK_aLINK_LATCH_a4_a),
              .BYTE_LATCH_41(TRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1515),
              .Mux5(TRANSMIT_BLOCK_aMux_a13263),
              .Mux6(TRANSMIT_BLOCK_aMux_a13266),
              .Mux7(TRANSMIT_BLOCK_aMux_a13267),
              .Mux9(TRANSMIT_BLOCK_aMux_a13272),
              .Mux10(TRANSMIT_BLOCK_aMux_a13273),
              .ISSM_LATCH_2(PICDATA_BLOCK_aISSM_LATCH_a2_a),
              .Mux12(TRANSMIT_BLOCK_aMux_a13285),
              .Mux13(TRANSMIT_BLOCK_aMux_a13286),
              .Mux14(TRANSMIT_BLOCK_aMux_a13287),
              .Mux15(TRANSMIT_BLOCK_aMux_a13290),
              .Mux17(TRANSMIT_BLOCK_aMux_a13299),
              .Mux18(TRANSMIT_BLOCK_aMux_a13300),
              .Mux20(TRANSMIT_BLOCK_aMux_a13304),
              .Mux21(TRANSMIT_BLOCK_aMux_a13305),
              .Mux22(TRANSMIT_BLOCK_aMux_a13306),
              .Mux24(TRANSMIT_BLOCK_aMux_a13316),
              .Mux26(TRANSMIT_BLOCK_aMux_a13318),
              .Mux27(TRANSMIT_BLOCK_aMux_a13319),
              .CLK(CDU_CLK),
              .CDU_EN(CDU_EN),
              .RESET(RESET_FPGA),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .CDU_TX(CDU_TX),
              .reduce_nor(TRANSMIT_BLOCK_areduce_nor_a175),
              .BYTE_LATCH_6(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a),
              .reduce_nor1(TRANSMIT_BLOCK_areduce_nor_a176),
              .TX_STATE_0(TRANSMIT_BLOCK_aTX_STATE_a0_a),
              .TX_STATE_2(TRANSMIT_BLOCK_aTX_STATE_a2_a),
              .BYTE_LATCH2(TRANSMIT_BLOCK_aBYTE_LATCH_a4918),
              .reduce_nor2(TRANSMIT_BLOCK_areduce_nor_a178),
              .reduce_nor3(TRANSMIT_BLOCK_areduce_nor_a179),
              .TX_STATE_1(TRANSMIT_BLOCK_aTX_STATE_a1_a),
              .reduce_nor4(TRANSMIT_BLOCK_areduce_nor_a7),
              .reduce_nor5(TRANSMIT_BLOCK_areduce_nor_a8),
              .reduce_nor6(TRANSMIT_BLOCK_areduce_nor_a180),
              .reduce_nor7(TRANSMIT_BLOCK_areduce_nor_a11),
              .reduce_nor8(TRANSMIT_BLOCK_areduce_nor_a181),
              .BYTE_LATCH_61(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4925),
              .Mux(TRANSMIT_BLOCK_aMux_a2422),
              .reduce_nor9(TRANSMIT_BLOCK_areduce_nor_a182),
              .BYTE_LATCH_62(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4935),
              .BYTE_LATCH_63(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4936),
              .BYTE_LATCH_64(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4937),
              .BYTE_LATCH_66(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4938),
              .Mux1(TRANSMIT_BLOCK_aMux_a13244),
              .Mux2(TRANSMIT_BLOCK_aMux_a13253),
              .Mux3(TRANSMIT_BLOCK_aMux_a13259),
              .LATCH_3(TRANSMIT_BLOCK_aCRC_BLOCK_aLATCH_a3_a),
              .Mux4(TRANSMIT_BLOCK_aMux_a13262),
              .Mux8(TRANSMIT_BLOCK_aMux_a13269),
              .Mux11(TRANSMIT_BLOCK_aMux_a13283),
              .BYTE_LATCH_0(TRANSMIT_BLOCK_aBYTE_LATCH_a0_a),
              .Mux16(TRANSMIT_BLOCK_aMux_a13298),
              .Mux19(TRANSMIT_BLOCK_aMux_a13302),
              .Mux23(TRANSMIT_BLOCK_aMux_a13314),
              .Mux25(TRANSMIT_BLOCK_aMux_a13317),
              .BYTE_LATCH_68(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4951) );

RECEIVE  RECEIVE_BLOCK
            ( .safe_q_2(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a2_a),
              .safe_q_4(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a4_a),
              .safe_q_6(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a6_a),
              .safe_q_7(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a7_a),
              .safe_q_8(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a8_a),
              .safe_q_3(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a3_a),
              .safe_q_5(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a5_a),
              .safe_q_0(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a0_a),
              .safe_q_1(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a1_a),
              .reduce_nor(TRANSMIT_BLOCK_areduce_nor_a175),
              .reduce_nor1(TRANSMIT_BLOCK_areduce_nor_a176),
              .reduce_nor2(TRANSMIT_BLOCK_areduce_nor_a178),
              .reduce_nor3(TRANSMIT_BLOCK_areduce_nor_a180),
              .Mux(TRANSMIT_BLOCK_aMux_a2422),
              .Mux1(RECEIVE_BLOCK_aMux_a6652),
              .SHIFT_REG_22(PICDATA_BLOCK_aSHIFT_REG_a22_a),
              .SHIFT_REG_21(PICDATA_BLOCK_aSHIFT_REG_a21_a),
              .SHIFT_REG_20(PICDATA_BLOCK_aSHIFT_REG_a20_a),
              .SHIFT_REG_0(PICDATA_BLOCK_aSHIFT_REG_a0_a),
              .Mux2(RECEIVE_BLOCK_aMux_a6677),
              .Mux3(RECEIVE_BLOCK_aMux_a6680),
              .Mux4(RECEIVE_BLOCK_aMux_a6684),
              .Mux5(TRANSMIT_BLOCK_aMux_a13259),
              .CLK(CDU_CLK),
              .CDU_EN(CDU_EN),
              .RESET(RESET_FPGA),
              .CDU_RX(CDU_RX),
              .PO1(PO1),
              .PO2(PO2),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .FIRST_ISSM(RECEIVE_BLOCK_aFIRST_ISSM),
              .SPI_ENABLE(RECEIVE_BLOCK_aSPI_ENABLE),
              .SDO(SDO),
              .SS_OUT_2(SS_OUT_2),
              .FRAME_SYNC(FRAME_SYNC),
              .SLOT_SYNC(SLOT_SYNC),
              .UL_SYNC(UL_SYNC),
              .SLOT_STATE_0(RECEIVE_BLOCK_aSLOT_STATE_a0_a),
              .SLOT_STATE_1(RECEIVE_BLOCK_aSLOT_STATE_a1_a),
              .SLOT_STATE_2(RECEIVE_BLOCK_aSLOT_STATE_a2_a),
              .RX_STATE_0(RECEIVE_BLOCK_aRX_STATE_a0_a_a2080),
              .TS_COUNT_2(RECEIVE_BLOCK_aTS_COUNT_a2_a),
              .TS_COUNT_1(RECEIVE_BLOCK_aTS_COUNT_a1_a),
              .TS_COUNT_0(RECEIVE_BLOCK_aTS_COUNT_a0_a),
              .safe_q_01(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a0_a),
              .safe_q_11(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a1_a),
              .safe_q_21(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a2_a),
              .reduce_nor4(RECEIVE_BLOCK_areduce_nor_a187),
              .reduce_nor5(RECEIVE_BLOCK_areduce_nor_a188),
              .START_SPI1(RECEIVE_BLOCK_aSTART_SPI_a25),
              .CDU_RX_LATCH(RECEIVE_BLOCK_aCDU_RX_LATCH),
              .reduce_nor6(RECEIVE_BLOCK_areduce_nor_a17),
              .SLOT_STATE_11(RECEIVE_BLOCK_aSLOT_STATE_a1_a_a599),
              .reduce_nor7(RECEIVE_BLOCK_areduce_nor_a190),
              .ISSM_LATCH_23(PICDATA_BLOCK_aISSM_LATCH_a23_a_a121),
              .LINK_LATCH_7(PICDATA_BLOCK_aLINK_LATCH_a7_a_a0),
              .LATCH_CSSM_DATA(RECEIVE_BLOCK_aLATCH_CSSM_DATA),
              .SS(RECEIVE_BLOCK_aSS) );

BITCOUNT BITCOUNT_BLOCK
            ( .reduce_nor(TRANSMIT_BLOCK_areduce_nor_a182),
              .CLK(CDU_CLK),
              .CDU_EN(CDU_EN),
              .RESET(RESET_FPGA),
              .RESET_FPGA(RESET_FPGA1),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .safe_q_2(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a2_a),
              .safe_q_4(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a4_a),
              .safe_q_6(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a6_a),
              .safe_q_7(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a7_a),
              .safe_q_8(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a8_a),
              .safe_q_3(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a3_a),
              .safe_q_5(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a5_a),
              .safe_q_0(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a0_a),
              .safe_q_1(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a1_a) );

I2C1     PCF_DEVICE
            ( .RESET(RESET_FPGA),
              .SDA_IN(SDA_IOM_PRIMARY),
              .SCL_IN(SCL_IOM_PRIMARY),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .DATA_LATCH_7(DATA_LATCH_7),
              .DATA_LATCH_6(DATA_LATCH_6),
              .DATA_LATCH_5(DATA_LATCH_5),
              .DATA_LATCH_4(DATA_LATCH_4),
              .DATA_LATCH_3(DATA_LATCH_3),
              .DATA_LATCH_2(DATA_LATCH_2),
              .DATA_LATCH_1(DATA_LATCH_1),
              .DATA_LATCH_0(DATA_LATCH_0),
              .SDA_OUT(SDA_OUT1) );

I2C      I2C_DEVICE
            ( .RESET(POR_a0),
              .RESET_FPGA(RESET_FPGA),
              .PO1(PO1),
              .PO2(PO2),
              .SDA_IN(SDA_INT),
              .SCL_IN(SCL_INT),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .DATA_LATCH_5(I2C_DEVICE_aDATA_LATCH_a5_a),
              .DATA_LATCH_4(I2C_DEVICE_aDATA_LATCH_a4_a),
              .DATA_LATCH_7(I2C_DEVICE_aDATA_LATCH_a7_a),
              .DATA_LATCH_6(I2C_DEVICE_aDATA_LATCH_a6_a),
              .SDA_OUT(SDA_OUT),
              .DATA_LATCH_2(DATA_LATCH_21),
              .DATA_LATCH_3(DATA_LATCH_31) );

PICDATA  PICDATA_BLOCK
            ( .safe_q_0(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a0_a),
              .safe_q_1(BITCOUNT_BLOCK_aCOUNT_rtl_0_aauto_generated_asafe_q_a1_a),
              .SLOT_STATE_0(RECEIVE_BLOCK_aSLOT_STATE_a0_a),
              .SLOT_STATE_1(RECEIVE_BLOCK_aSLOT_STATE_a1_a),
              .BYTE_LATCH_6(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a),
              .reduce_nor(TRANSMIT_BLOCK_areduce_nor_a176),
              .TX_STATE_0(TRANSMIT_BLOCK_aTX_STATE_a0_a),
              .TX_STATE_2(TRANSMIT_BLOCK_aTX_STATE_a2_a),
              .BYTE_LATCH2(TRANSMIT_BLOCK_aBYTE_LATCH_a4918),
              .reduce_nor1(TRANSMIT_BLOCK_areduce_nor_a178),
              .reduce_nor2(TRANSMIT_BLOCK_areduce_nor_a179),
              .TX_STATE_1(TRANSMIT_BLOCK_aTX_STATE_a1_a),
              .reduce_nor3(TRANSMIT_BLOCK_areduce_nor_a7),
              .reduce_nor4(TRANSMIT_BLOCK_areduce_nor_a8),
              .reduce_nor5(TRANSMIT_BLOCK_areduce_nor_a180),
              .reduce_nor6(TRANSMIT_BLOCK_areduce_nor_a11),
              .reduce_nor7(TRANSMIT_BLOCK_areduce_nor_a181),
              .BYTE_LATCH_61(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4925),
              .safe_q_01(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a0_a),
              .safe_q_11(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a1_a),
              .safe_q_2(RECEIVE_BLOCK_aISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a2_a),
              .reduce_nor8(TRANSMIT_BLOCK_areduce_nor_a182),
              .reduce_nor9(RECEIVE_BLOCK_areduce_nor_a187),
              .reduce_nor10(RECEIVE_BLOCK_areduce_nor_a188),
              .CDU_RX_LATCH(RECEIVE_BLOCK_aCDU_RX_LATCH),
              .BYTE_LATCH_62(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4935),
              .BYTE_LATCH_63(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4936),
              .BYTE_LATCH_64(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4937),
              .BYTE_LATCH_66(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4938),
              .ISSM_LATCH_23(PICDATA_BLOCK_aISSM_LATCH_a23_a_a121),
              .Mux1(TRANSMIT_BLOCK_aMux_a13244),
              .LINK_LATCH_71(PICDATA_BLOCK_aLINK_LATCH_a7_a_a0),
              .Mux2(TRANSMIT_BLOCK_aMux_a13253),
              .LATCH_CSSM_DATA(RECEIVE_BLOCK_aLATCH_CSSM_DATA),
              .SS(RECEIVE_BLOCK_aSS),
              .LATCH_3(TRANSMIT_BLOCK_aCRC_BLOCK_aLATCH_a3_a),
              .Mux6(TRANSMIT_BLOCK_aMux_a13262),
              .Mux10(TRANSMIT_BLOCK_aMux_a13269),
              .Mux13(TRANSMIT_BLOCK_aMux_a13283),
              .BYTE_LATCH_0(TRANSMIT_BLOCK_aBYTE_LATCH_a0_a),
              .Mux18(TRANSMIT_BLOCK_aMux_a13298),
              .Mux21(TRANSMIT_BLOCK_aMux_a13302),
              .Mux25(TRANSMIT_BLOCK_aMux_a13314),
              .Mux27(TRANSMIT_BLOCK_aMux_a13317),
              .BYTE_LATCH_68(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a4951),
              .CLK(CDU_CLK),
              .RESET_FPGA(RESET_FPGA),
              .SDI_FPGA(SDI_FPGA),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .BYTE_LATCH(TRANSMIT_BLOCK_aBYTE_LATCH_a4917),
              .LINK_LATCH_7(PICDATA_BLOCK_aLINK_LATCH_a7_a),
              .BYTE_LATCH1(TRANSMIT_BLOCK_aBYTE_LATCH_a1423),
              .BYTE_LATCH3(TRANSMIT_BLOCK_aBYTE_LATCH_a4920),
              .BYTE_LATCH4(TRANSMIT_BLOCK_aBYTE_LATCH_a4921),
              .BYTE_LATCH5(TRANSMIT_BLOCK_aBYTE_LATCH_a4922),
              .BYTE_LATCH6(TRANSMIT_BLOCK_aBYTE_LATCH_a4924),
              .Mux(RECEIVE_BLOCK_aMux_a6652),
              .BYTE_LATCH_65(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1516),
              .BYTE_LATCH_67(TRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1507),
              .SHIFT_REG_22(PICDATA_BLOCK_aSHIFT_REG_a22_a),
              .SHIFT_REG_21(PICDATA_BLOCK_aSHIFT_REG_a21_a),
              .SHIFT_REG_20(PICDATA_BLOCK_aSHIFT_REG_a20_a),
              .SHIFT_REG_0(PICDATA_BLOCK_aSHIFT_REG_a0_a),
              .Mux3(RECEIVE_BLOCK_aMux_a6677),
              .BYTE_LATCH_5(TRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1518),
              .BYTE_LATCH_51(TRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1511),
              .Mux4(RECEIVE_BLOCK_aMux_a6680),
              .BYTE_LATCH_4(TRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1513),
              .LINK_LATCH_4(PICDATA_BLOCK_aLINK_LATCH_a4_a),
              .BYTE_LATCH_41(TRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1515),
              .Mux5(RECEIVE_BLOCK_aMux_a6684),
              .Mux7(TRANSMIT_BLOCK_aMux_a13263),
              .Mux8(TRANSMIT_BLOCK_aMux_a13266),
              .Mux9(TRANSMIT_BLOCK_aMux_a13267),
              .Mux11(TRANSMIT_BLOCK_aMux_a13272),
              .Mux12(TRANSMIT_BLOCK_aMux_a13273),
              .ISSM_LATCH_2(PICDATA_BLOCK_aISSM_LATCH_a2_a),
              .Mux14(TRANSMIT_BLOCK_aMux_a13285),
              .Mux15(TRANSMIT_BLOCK_aMux_a13286),
              .Mux16(TRANSMIT_BLOCK_aMux_a13287),
              .Mux17(TRANSMIT_BLOCK_aMux_a13290),
              .Mux19(TRANSMIT_BLOCK_aMux_a13299),
              .Mux20(TRANSMIT_BLOCK_aMux_a13300),
              .Mux22(TRANSMIT_BLOCK_aMux_a13304),
              .Mux23(TRANSMIT_BLOCK_aMux_a13305),
              .Mux24(TRANSMIT_BLOCK_aMux_a13306),
              .Mux26(TRANSMIT_BLOCK_aMux_a13316),
              .Mux28(TRANSMIT_BLOCK_aMux_a13318),
              .Mux29(TRANSMIT_BLOCK_aMux_a13319) );

LEDDRIVER LEDDRIVER_BLOCK
            ( .DATA_LATCH_5(I2C_DEVICE_aDATA_LATCH_a5_a),
              .DATA_LATCH_4(I2C_DEVICE_aDATA_LATCH_a4_a),
              .RESET(POR_a0),
              .DATA_LATCH_7(I2C_DEVICE_aDATA_LATCH_a7_a),
              .DATA_LATCH_6(I2C_DEVICE_aDATA_LATCH_a6_a),
              .PO14(PO14),
              .PO13(PO13),
              .RESET_FPGA(RESET_FPGA),
              .SDA_INT(SDA_INT),
              .CLK(SCL_INT),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .FAULT_LED(FAULT_LED),
              .OPERATIONAL_LED(OPERATIONAL_LED) );

// atom is at LC_X10_Y7_N5
lcell_stratix_on_sd_cx_c0x_c1x_0f00 POR_a0_I
            ( .dataa( vdd ),
              .datac(RESET_FPGA),
              .datad(SDA_INT),
              .inverta( vss ),
              .combout(POR_a0) );

// atom is at LC_X8_Y6_N0
lcell_stratix_on_sd_cx_c0x_c1x_ff0c SCK_a1_I
            ( .dataa( vdd ),
              .datab(RECEIVE_BLOCK_aFIRST_ISSM),
              .datac(RECEIVE_BLOCK_aSPI_ENABLE),
              .datad(CDU_CLK),
              .inverta( vss ),
              .combout(SCK) );

endmodule
module BITCOUNT ( reduce_nor, CLK, CDU_EN, RESET, RESET_FPGA, devclrn, devpor, devoe, safe_q_2, safe_q_4, safe_q_6, safe_q_7, safe_q_8, safe_q_3, safe_q_5, safe_q_0, safe_q_1);
input reduce_nor;
input CLK;
input CDU_EN;
input RESET;
input RESET_FPGA;
input devclrn;
input devpor;
input devoe;
output safe_q_2;
output safe_q_4;
output safe_q_6;
output safe_q_7;
output safe_q_8;
output safe_q_3;
output safe_q_5;
output safe_q_0;
output safe_q_1;
// atom is at LC_X6_Y4_N2
i1  inst_1
            ( .a( CLK ),
              .zn( not__CLK ) );
i1  inst_2
            ( .a( RESET ),
              .zn( not__RESET ) );
lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_a60a COUNT_rtl_0_aauto_generated_acounter_cella2
            ( .clk( not__CLK ),
              .dataa(safe_q_2),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella1_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella1_aCOUTCOUT1_4),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_2),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella2_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella2_aCOUTCOUT1_4) );

// atom is at LC_X6_Y4_N4
lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_a60a COUNT_rtl_0_aauto_generated_acounter_cella4
            ( .clk( not__CLK ),
              .dataa(safe_q_4),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella3_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella3_aCOUTCOUT1_2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_4),
              .cout(COUNT_rtl_0_aauto_generated_acounter_cella4_aCOUT) );

// atom is at LC_X6_Y4_N6
lcell_stratix_son_rof_pol_oa_sc_ct_c0tx_c1tx_a60a COUNT_rtl_0_aauto_generated_acounter_cella6
            ( .clk( not__CLK ),
              .dataa(safe_q_6),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin(COUNT_rtl_0_aauto_generated_acounter_cella4_aCOUT),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella5_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella5_aCOUTCOUT1_4),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_6),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella6_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella6_aCOUTCOUT1_4) );

// atom is at LC_X6_Y4_N7
lcell_stratix_son_rof_pol_oa_sc_ct_c0tx_c1tx_6a5f COUNT_rtl_0_aauto_generated_acounter_cella7
            ( .clk( not__CLK ),
              .dataa(safe_q_7),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin(COUNT_rtl_0_aauto_generated_acounter_cella4_aCOUT),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella6_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella6_aCOUTCOUT1_4),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_7),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella7_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella7_aCOUTCOUT1_4) );

// atom is at LC_X6_Y4_N8
lcell_stratix_son_rof_pol_on_sc_ct_c0tx_c1tx_a5aa COUNT_rtl_0_aauto_generated_acounter_cella8
            ( .clk( not__CLK ),
              .dataa(safe_q_8),
              .datac(RESET_FPGA),
              .datad(reduce_or_a0),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin(COUNT_rtl_0_aauto_generated_acounter_cella4_aCOUT),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella7_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella7_aCOUTCOUT1_4),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_8) );

// atom is at LC_X6_Y4_N3
lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_6a5f COUNT_rtl_0_aauto_generated_acounter_cella3
            ( .clk( not__CLK ),
              .dataa(safe_q_3),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella2_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella2_aCOUTCOUT1_4),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_3),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella3_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella3_aCOUTCOUT1_2) );

// atom is at LC_X6_Y4_N5
lcell_stratix_son_rof_pol_oa_sc_ct_c0f_c1f_6a5f COUNT_rtl_0_aauto_generated_acounter_cella5
            ( .clk( not__CLK ),
              .dataa(safe_q_5),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin(COUNT_rtl_0_aauto_generated_acounter_cella4_aCOUT),
              .cin0( vss ),
              .cin1( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_5),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella5_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella5_aCOUTCOUT1_4) );

// atom is at LC_X6_Y4_N0
lcell_stratix_son_rof_pol_oa_sd_cf_c0f_c1f_66aa COUNT_rtl_0_aauto_generated_acounter_cella0
            ( .clk( not__CLK ),
              .dataa(safe_q_0),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_0),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella0_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella0_aCOUTCOUT1_5) );

// atom is at LC_X6_Y4_N1
lcell_stratix_son_rof_pol_oa_sc_cf_c0tx_c1tx_6a5f COUNT_rtl_0_aauto_generated_acounter_cella1
            ( .clk( not__CLK ),
              .dataa(safe_q_1),
              .datab(reduce_or_a0),
              .datac(RESET_FPGA),
              .aclr(START_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( not__RESET ),
              .ena( vdd ),
              .cin0(COUNT_rtl_0_aauto_generated_acounter_cella0_aCOUT),
              .cin1(COUNT_rtl_0_aauto_generated_acounter_cella0_aCOUTCOUT1_5),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_1),
              .cout0(COUNT_rtl_0_aauto_generated_acounter_cella1_aCOUT),
              .cout1(COUNT_rtl_0_aauto_generated_acounter_cella1_aCOUTCOUT1_4) );

// atom is at LC_X7_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_a0a0 reduce_or_a14_I
            ( .dataa(safe_q_8),
              .datac(safe_q_6),
              .inverta( vss ),
              .combout(reduce_or_a14) );

// atom is at LC_X7_Y4_N8
lcell_stratix_on_sd_cx_c0x_c1x_7fff reduce_or_a0_I
            ( .dataa(safe_q_5),
              .datab(safe_q_7),
              .datac(reduce_nor),
              .datad(reduce_or_a14),
              .inverta( vss ),
              .combout(reduce_or_a0) );

// atom is at LC_X10_Y4_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_5050 LATCH_ENABLE_aI
            ( .clk(CLK),
              .dataa(CDU_EN),
              .datac(CDU_EN),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(START_a0) );

endmodule
module I2C ( RESET, RESET_FPGA, PO1, PO2, SDA_IN, SCL_IN, devclrn, devpor, devoe, DATA_LATCH_5, DATA_LATCH_4, DATA_LATCH_7, DATA_LATCH_6, SDA_OUT, DATA_LATCH_2, DATA_LATCH_3);
input RESET;
input RESET_FPGA;
input PO1;
input PO2;
input SDA_IN;
input SCL_IN;
input devclrn;
input devpor;
input devoe;
output DATA_LATCH_5;
output DATA_LATCH_4;
output DATA_LATCH_7;
output DATA_LATCH_6;
output SDA_OUT;
output DATA_LATCH_2;
output DATA_LATCH_3;
// atom is at LC_X4_Y7_N2
i1  inst_1
            ( .a( SCL_IN ),
              .zn( not__SCL_IN ) );
i1  inst_2
            ( .a( SDA_IN ),
              .zn( not__SDA_IN ) );
i1  inst_3
            ( .a( START_CONDITION ),
              .zn( not__START_CONDITION ) );
i1  inst_4
            ( .a( RESET ),
              .zn( not__RESET ) );
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a5_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a6_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_5) );

// atom is at LC_X4_Y7_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a4_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a5_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_4) );

// atom is at LC_X4_Y7_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a7_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a8_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_7) );

// atom is at LC_X4_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a6_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a7_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_6) );

// atom is at LC_X11_Y7_N0
lcell_stratix_on_sd_cx_c0x_c1x_cccd SDA_OUT_a1_I
            ( .dataa(TXDATA_SR_a7_a),
              .datab(I2C_ERROR),
              .datac(ADDR_ACK),
              .datad(DATA_ACK),
              .inverta( vss ),
              .combout(SDA_OUT) );

// atom is at LC_X4_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a2_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a3_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_2) );

// atom is at LC_X4_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a3_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a4_a),
              .aclr(RESET),
              .aload( vss ),
              .ena(DATA_LATCH_a5_a_a2),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_3) );

// atom is at LC_X10_Y7_N4
lcell_stratix_on_sd_cx_c0x_c1x_3f0f START_CONDITION_a0_I
            ( .dataa( vdd ),
              .datab(RESET_FPGA),
              .datac(SCL_IN),
              .datad(SDA_IN),
              .inverta( vss ),
              .combout(START_CONDITION_a0) );

// atom is at LC_X12_Y7_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff START_CONDITION_aI
            ( .clk( not__SDA_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(START_CONDITION_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(START_CONDITION) );

// atom is at LC_X10_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_0c0f comb_a1_I
            ( .dataa( vdd ),
              .datab(RESET_FPGA),
              .datac(SCL_IN),
              .datad(SDA_IN),
              .inverta( vss ),
              .combout(comb_a1) );

// atom is at LC_X10_Y7_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff STOP_CONDITION_aI
            ( .clk(SDA_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(comb_a1),
              .aload(RESET),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(STOP_CONDITION) );

// atom is at LC_X10_Y7_N7
lcell_stratix_on_sd_cx_c0x_c1x_ffcc CONTROL_a0_I
            ( .dataa( vdd ),
              .datab(START_CONDITION),
              .datad(STOP_CONDITION),
              .inverta( vss ),
              .combout(CONTROL_a0) );

// atom is at LC_X3_Y7_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a7_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a6_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a7_a) );

// atom is at LC_X3_Y7_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_feff RXDATA_SR_a6_a_aI
            ( .clk(SCL_IN),
              .dataa(RXDATA_SR_a5_a),
              .datab(RXDATA_SR_a4_a),
              .datac(RXDATA_SR_a5_a),
              .datad(RXDATA_SR_a7_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a98),
              .regout(RXDATA_SR_a6_a) );

// atom is at LC_X3_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff RXDATA_SR_a0_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SDA_IN),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a0_a) );

// atom is at LC_X3_Y7_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a1_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a0_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a1_a) );

// atom is at LC_X3_Y7_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fdff RXDATA_SR_a2_a_aI
            ( .clk(SCL_IN),
              .dataa(RXDATA_SR_a3_a),
              .datab(reduce_nor_a98),
              .datac(RXDATA_SR_a1_a),
              .datad(RXDATA_SR_a1_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a4),
              .regout(RXDATA_SR_a2_a) );

// atom is at LC_X3_Y7_N8
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a3_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a2_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a3_a) );

// atom is at LC_X3_Y7_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 RXDATA_SR_a4_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a3_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a4_a) );

// atom is at LC_X3_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 RXDATA_SR_a5_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a4_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a5_a) );

// atom is at LC_X9_Y7_N0
lcell_stratix_sof_rof_pol_oa_sd_cf_c0f_c1f_33cc BIT_COUNT_rtl_3_aauto_generated_acounter_cella0
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .cout0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella0_aCOUT),
              .cout1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella0_aCOUTCOUT1_3) );

// atom is at LC_X9_Y7_N1
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_3c3f BIT_COUNT_rtl_3_aauto_generated_acounter_cella1
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a1_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella0_aCOUT),
              .cin1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella0_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a1_a),
              .cout0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella1_aCOUT),
              .cout1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella1_aCOUTCOUT1_1) );

// atom is at LC_X9_Y7_N2
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_c30c BIT_COUNT_rtl_3_aauto_generated_acounter_cella2
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a2_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella1_aCOUT),
              .cin1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella1_aCOUTCOUT1_1),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a2_a),
              .cout0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella2_aCOUT),
              .cout1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella2_aCOUTCOUT1_3) );

// atom is at LC_X9_Y7_N3
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_5a5f BIT_COUNT_rtl_3_aauto_generated_acounter_cella3
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella2_aCOUT),
              .cin1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella2_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .cout0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella3_aCOUT),
              .cout1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella3_aCOUTCOUT1_3) );

// atom is at LC_X9_Y7_N4
lcell_stratix_sof_rof_pol_on_sc_cf_c0tx_c1tx_a5a5 BIT_COUNT_rtl_3_aauto_generated_acounter_cella4
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_3_aauto_generated_acounter_cella3_aCOUT),
              .cin1(BIT_COUNT_rtl_3_aauto_generated_acounter_cella3_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a) );

// atom is at LC_X9_Y7_N7
lcell_stratix_on_sd_cx_c0x_c1x_cc00 reduce_nor_a100_I
            ( .dataa( vdd ),
              .datab(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a1_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a2_a),
              .inverta( vss ),
              .combout(reduce_nor_a100) );

// atom is at LC_X9_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_7fff reduce_nor_a0_I
            ( .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a),
              .datab(reduce_nor_a100),
              .datac(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .inverta( vss ),
              .combout(reduce_nor_a0) );

// atom is at LC_X7_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_fff0 reduce_nor_a99_I
            ( .dataa( vdd ),
              .datac(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a1_a),
              .inverta( vss ),
              .combout(reduce_nor_a99) );

// atom is at LC_X9_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_ffef reduce_nor_a3_I
            ( .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .datab(reduce_nor_a99),
              .datac(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a2_a),
              .inverta( vss ),
              .combout(reduce_nor_a3) );

// atom is at LC_X8_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f RXDATA_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(reduce_nor_a3),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_BYTE) );

// atom is at LC_X9_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0004 ADDR_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a),
              .datab(reduce_nor_a100),
              .datac(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_BYTE) );

// atom is at LC_X10_Y7_N8
lcell_stratix_on_sd_cx_c0x_c1x_2022 ADDR_DETECTED_a0_I
            ( .dataa(ADDR_BYTE),
              .datab(reduce_nor_a4),
              .datac(RESET_FPGA),
              .datad(SDA_IN),
              .inverta( vss ),
              .combout(ADDR_DETECTED_a0) );

// atom is at LC_X3_Y7_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff ADDR_DETECTED_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(ADDR_DETECTED_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_DETECTED) );

// atom is at LC_X3_Y7_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4000 ADDR_RNW_aI
            ( .clk( not__SCL_IN ),
              .dataa(CONTROL_a0),
              .datab(RXDATA_BYTE),
              .datac(RXDATA_SR_a0_a),
              .datad(ADDR_DETECTED),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ADDR_DETECTED_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(DATA_LATCH_a5_a_a2),
              .regout(ADDR_RNW) );

// atom is at LC_X2_Y7_N2
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a8_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a7_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a8_a) );

// atom is at LC_X9_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0040 TXDATA_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a4_a),
              .datab(reduce_nor_a100),
              .datac(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a0_a),
              .datad(BIT_COUNT_rtl_3_aauto_generated_asafe_q_a3_a),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_BYTE) );

// atom is at LC_X5_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_3300 DATA_TX_a0_I
            ( .dataa( vdd ),
              .datab(ADDR_RNW),
              .datad(ADDR_DETECTED),
              .inverta( vss ),
              .combout(DATA_TX_a0) );

// atom is at LC_X11_Y7_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00aa TXDATA_SR_a0_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_BYTE),
              .datac( vdd ),
              .datad(PO1),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a0_a) );

// atom is at LC_X11_Y7_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0fcc TXDATA_SR_a1_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(TXDATA_SR_a0_a),
              .datac(PO2),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a1_a) );

// atom is at LC_X11_Y7_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0faa TXDATA_SR_a2_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_SR_a1_a),
              .datac(DATA_LATCH_2),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a2_a) );

// atom is at LC_X11_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_7722 TXDATA_SR_a3_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_BYTE),
              .datab(DATA_LATCH_3),
              .datac( vdd ),
              .datad(TXDATA_SR_a2_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a3_a) );

// atom is at LC_X11_Y7_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0faa TXDATA_SR_a4_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_SR_a3_a),
              .datac(DATA_LATCH_4),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a4_a) );

// atom is at LC_X11_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_33f0 TXDATA_SR_a5_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(DATA_LATCH_5),
              .datac(TXDATA_SR_a4_a),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a5_a) );

// atom is at LC_X11_Y7_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_33aa TXDATA_SR_a6_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_SR_a5_a),
              .datab(DATA_LATCH_6),
              .datac( vdd ),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a6_a) );

// atom is at LC_X11_Y7_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0fcc TXDATA_SR_a7_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(TXDATA_SR_a6_a),
              .datac(DATA_LATCH_7),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a7_a) );

// atom is at LC_X11_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff I2C_ERROR_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(reduce_nor_a0),
              .aclr( vss ),
              .aload( vss ),
              .ena( not__START_CONDITION ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(I2C_ERROR) );

// atom is at LC_X10_Y7_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_88aa ADDR_ACK_aI
            ( .clk( not__SCL_IN ),
              .dataa(ADDR_BYTE),
              .datab(ADDR_ACK),
              .datac( vdd ),
              .datad(reduce_nor_a4),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( not__RESET ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_ACK) );

// atom is at LC_X12_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f00 DATA_ACK_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(reduce_nor_a3),
              .datad(ADDR_RNW),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_ACK) );

endmodule
module I2C1 ( RESET, SDA_IN, SCL_IN, devclrn, devpor, devoe, DATA_LATCH_7, DATA_LATCH_6, DATA_LATCH_5, DATA_LATCH_4, DATA_LATCH_3, DATA_LATCH_2, DATA_LATCH_1, DATA_LATCH_0, SDA_OUT);
input RESET;
input SDA_IN;
input SCL_IN;
input devclrn;
input devpor;
input devoe;
output DATA_LATCH_7;
output DATA_LATCH_6;
output DATA_LATCH_5;
output DATA_LATCH_4;
output DATA_LATCH_3;
output DATA_LATCH_2;
output DATA_LATCH_1;
output DATA_LATCH_0;
output SDA_OUT;
// atom is at LC_X1_Y6_N2
i1  inst_1
            ( .a( SCL_IN ),
              .zn( not__SCL_IN ) );
i1  inst_2
            ( .a( RESET ),
              .zn( not__RESET ) );
i1  inst_3
            ( .a( SDA_IN ),
              .zn( not__SDA_IN ) );
i1  inst_4
            ( .a( START_CONDITION ),
              .zn( not__START_CONDITION ) );
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a7_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a8_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_7) );

// atom is at LC_X1_Y6_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a6_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a7_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_6) );

// atom is at LC_X1_Y6_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f0f DATA_LATCH_a5_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(RXDATA_SR_a6_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_5) );

// atom is at LC_X1_Y6_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a4_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a5_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_4) );

// atom is at LC_X1_Y6_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a3_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a4_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_3) );

// atom is at LC_X1_Y6_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a2_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a3_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_2) );

// atom is at LC_X1_Y6_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a1_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a2_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_1) );

// atom is at LC_X1_Y6_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff DATA_LATCH_a0_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a1_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(DATA_LATCH_a7_a_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_LATCH_0) );

// atom is at LC_X6_Y7_N5
lcell_stratix_on_sd_cx_c0x_c1x_aaab SDA_OUT_a1_I
            ( .dataa(I2C_ERROR),
              .datab(TXDATA_SR_a7_a),
              .datac(ADDR_ACK),
              .datad(DATA_ACK),
              .inverta( vss ),
              .combout(SDA_OUT) );

// atom is at LC_X7_Y7_N2
lcell_stratix_on_sd_cx_c0x_c1x_3300 comb_a1_I
            ( .dataa( vdd ),
              .datab(SCL_IN),
              .datad(RESET),
              .inverta( vss ),
              .combout(comb_a1) );

// atom is at LC_X5_Y6_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff STOP_CONDITION_aI
            ( .clk(SDA_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(comb_a1),
              .aload( not__RESET ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(STOP_CONDITION) );

// atom is at LC_X7_Y7_N3
lcell_stratix_on_sd_cx_c0x_c1x_33ff START_CONDITION_a0_I
            ( .dataa( vdd ),
              .datab(SCL_IN),
              .datad(RESET),
              .inverta( vss ),
              .combout(START_CONDITION_a0) );

// atom is at LC_X7_Y7_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff START_CONDITION_aI
            ( .clk( not__SDA_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(START_CONDITION_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(START_CONDITION) );

// atom is at LC_X5_Y7_N4
lcell_stratix_on_sd_cx_c0x_c1x_fff0 CONTROL_a0_I
            ( .dataa( vdd ),
              .datac(STOP_CONDITION),
              .datad(START_CONDITION),
              .inverta( vss ),
              .combout(CONTROL_a0) );

// atom is at LC_X2_Y6_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff RXDATA_SR_a0_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SDA_IN),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a0_a) );

// atom is at LC_X2_Y6_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a1_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a0_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a1_a) );

// atom is at LC_X2_Y6_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a2_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a1_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a2_a) );

// atom is at LC_X2_Y6_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f7ff RXDATA_SR_a6_a_aI
            ( .clk(SCL_IN),
              .dataa(RXDATA_SR_a5_a),
              .datab(RXDATA_SR_a4_a),
              .datac(RXDATA_SR_a5_a),
              .datad(RXDATA_SR_a7_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a98),
              .regout(RXDATA_SR_a6_a) );

// atom is at LC_X2_Y6_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_ff7f RXDATA_SR_a3_a_aI
            ( .clk(SCL_IN),
              .dataa(RXDATA_SR_a2_a),
              .datab(RXDATA_SR_a1_a),
              .datac(RXDATA_SR_a2_a),
              .datad(reduce_nor_a98),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a4),
              .regout(RXDATA_SR_a3_a) );

// atom is at LC_X2_Y6_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 RXDATA_SR_a4_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a3_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a4_a) );

// atom is at LC_X1_Y6_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 RXDATA_SR_a5_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(RXDATA_SR_a4_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a5_a) );

// atom is at LC_X2_Y6_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a7_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a6_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a7_a) );

// atom is at LC_X1_Y6_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 RXDATA_SR_a8_a_aI
            ( .clk(SCL_IN),
              .dataa( vdd ),
              .datac(RXDATA_SR_a7_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_SR_a8_a) );

// atom is at LC_X6_Y7_N0
lcell_stratix_sof_rof_pol_oa_sd_cf_c0f_c1f_33cc BIT_COUNT_rtl_2_aauto_generated_acounter_cella0
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .cout0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella0_aCOUT),
              .cout1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella0_aCOUTCOUT1_3) );

// atom is at LC_X6_Y7_N1
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_3c3f BIT_COUNT_rtl_2_aauto_generated_acounter_cella1
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a1_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella0_aCOUT),
              .cin1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella0_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a1_a),
              .cout0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella1_aCOUT),
              .cout1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella1_aCOUTCOUT1_1) );

// atom is at LC_X6_Y7_N2
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_c30c BIT_COUNT_rtl_2_aauto_generated_acounter_cella2
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a2_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella1_aCOUT),
              .cin1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella1_aCOUTCOUT1_1),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a2_a),
              .cout0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella2_aCOUT),
              .cout1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella2_aCOUTCOUT1_3) );

// atom is at LC_X6_Y7_N3
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_5a5f BIT_COUNT_rtl_2_aauto_generated_acounter_cella3
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella2_aCOUT),
              .cin1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella2_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .cout0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella3_aCOUT),
              .cout1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella3_aCOUTCOUT1_3) );

// atom is at LC_X6_Y7_N4
lcell_stratix_sof_rof_pol_on_sc_cf_c0tx_c1tx_a5a5 BIT_COUNT_rtl_2_aauto_generated_acounter_cella4
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a),
              .datac( vdd ),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena(reduce_nor_a0),
              .cin0(BIT_COUNT_rtl_2_aauto_generated_acounter_cella3_aCOUT),
              .cin1(BIT_COUNT_rtl_2_aauto_generated_acounter_cella3_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a) );

// atom is at LC_X6_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_cc00 reduce_nor_a100_I
            ( .dataa( vdd ),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a2_a),
              .datad(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a1_a),
              .inverta( vss ),
              .combout(reduce_nor_a100) );

// atom is at LC_X6_Y7_N7
lcell_stratix_on_sd_cx_c0x_c1x_7fff reduce_nor_a0_I
            ( .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .datac(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a),
              .datad(reduce_nor_a100),
              .inverta( vss ),
              .combout(reduce_nor_a0) );

// atom is at LC_X7_Y7_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0010 ADDR_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a),
              .datac(reduce_nor_a100),
              .datad(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_BYTE) );

// atom is at LC_X2_Y7_N5
lcell_stratix_on_sd_cx_c0x_c1x_00c0 ADDR_DETECTED_a0_I
            ( .dataa( vdd ),
              .datab(ADDR_BYTE),
              .datac(RESET),
              .datad(reduce_nor_a4),
              .inverta( vss ),
              .combout(ADDR_DETECTED_a0) );

// atom is at LC_X2_Y6_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff ADDR_DETECTED_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(ADDR_DETECTED_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_DETECTED) );

// atom is at LC_X6_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_fff0 reduce_nor_a99_I
            ( .dataa( vdd ),
              .datac(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .datad(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a1_a),
              .inverta( vss ),
              .combout(reduce_nor_a99) );

// atom is at LC_X7_Y7_N1
lcell_stratix_on_sd_cx_c0x_c1x_fffb reduce_nor_a3_I
            ( .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a),
              .datac(reduce_nor_a99),
              .datad(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a2_a),
              .inverta( vss ),
              .combout(reduce_nor_a3) );

// atom is at LC_X7_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff RXDATA_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(reduce_nor_a3),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RXDATA_BYTE) );

// atom is at LC_X2_Y6_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0080 ADDR_RNW_aI
            ( .clk( not__SCL_IN ),
              .dataa(ADDR_DETECTED),
              .datab(RXDATA_BYTE),
              .datac(RXDATA_SR_a0_a),
              .datad(CONTROL_a0),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ADDR_DETECTED_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(DATA_LATCH_a7_a_a0),
              .regout(ADDR_RNW) );

// atom is at LC_X6_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff I2C_ERROR_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(reduce_nor_a0),
              .aclr( vss ),
              .aload( vss ),
              .ena( not__START_CONDITION ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(I2C_ERROR) );

// atom is at LC_X7_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_1000 TXDATA_BYTE_aI
            ( .clk( not__SCL_IN ),
              .dataa(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a3_a),
              .datab(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a4_a),
              .datac(reduce_nor_a100),
              .datad(BIT_COUNT_rtl_2_aauto_generated_asafe_q_a0_a),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_BYTE) );

// atom is at LC_X2_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_5500 DATA_TX_a0_I
            ( .dataa(ADDR_RNW),
              .datad(ADDR_DETECTED),
              .inverta( vss ),
              .combout(DATA_TX_a0) );

// atom is at LC_X1_Y7_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f00 TXDATA_SR_a0_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(DATA_LATCH_0),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a0_a) );

// atom is at LC_X1_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_3f0c TXDATA_SR_a1_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(TXDATA_BYTE),
              .datac(DATA_LATCH_1),
              .datad(TXDATA_SR_a0_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a1_a) );

// atom is at LC_X1_Y7_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_55cc TXDATA_SR_a2_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(DATA_LATCH_2),
              .datab(TXDATA_SR_a1_a),
              .datac( vdd ),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a2_a) );

// atom is at LC_X1_Y7_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_33f0 TXDATA_SR_a3_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(DATA_LATCH_3),
              .datac(TXDATA_SR_a2_a),
              .datad(TXDATA_BYTE),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a3_a) );

// atom is at LC_X1_Y7_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2e2e TXDATA_SR_a4_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(TXDATA_SR_a3_a),
              .datab(TXDATA_BYTE),
              .datac(DATA_LATCH_4),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a4_a) );

// atom is at LC_X1_Y7_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_7744 TXDATA_SR_a5_a_aI
            ( .clk( not__SCL_IN ),
              .dataa(DATA_LATCH_5),
              .datab(TXDATA_BYTE),
              .datac( vdd ),
              .datad(TXDATA_SR_a4_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a5_a) );

// atom is at LC_X1_Y7_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_3f0c TXDATA_SR_a6_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(TXDATA_BYTE),
              .datac(DATA_LATCH_6),
              .datad(TXDATA_SR_a5_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a6_a) );

// atom is at LC_X1_Y7_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_3f0c TXDATA_SR_a7_a_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(TXDATA_BYTE),
              .datac(DATA_LATCH_7),
              .datad(TXDATA_SR_a6_a),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(DATA_TX_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TXDATA_SR_a7_a) );

// atom is at LC_X2_Y7_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c0cc ADDR_ACK_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datab(ADDR_BYTE),
              .datac(ADDR_ACK),
              .datad(reduce_nor_a4),
              .aclr(CONTROL_a0),
              .aload( vss ),
              .ena(RESET),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ADDR_ACK) );

// atom is at LC_X7_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00f0 DATA_ACK_aI
            ( .clk( not__SCL_IN ),
              .dataa( vdd ),
              .datac(ADDR_RNW),
              .datad(reduce_nor_a3),
              .aclr(START_CONDITION),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(DATA_ACK) );

endmodule
module LEDDRIVER ( DATA_LATCH_5, DATA_LATCH_4, RESET, DATA_LATCH_7, DATA_LATCH_6, PO14, PO13, RESET_FPGA, SDA_INT, CLK, devclrn, devpor, devoe, FAULT_LED, OPERATIONAL_LED);
input DATA_LATCH_5;
input DATA_LATCH_4;
input RESET;
input DATA_LATCH_7;
input DATA_LATCH_6;
input PO14;
input PO13;
input RESET_FPGA;
input SDA_INT;
input CLK;
input devclrn;
input devpor;
input devoe;
output FAULT_LED;
output OPERATIONAL_LED;
// atom is at LC_X4_Y7_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_30fc LED2_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(LED_SELECT),
              .datac(DATA_LATCH_5),
              .datad(PO14),
              .aclr( vss ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LED2_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(FAULT_LED) );

// atom is at LC_X5_Y7_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_30fc LED1_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(LED_SELECT),
              .datac(DATA_LATCH_7),
              .datad(PO13),
              .aclr( vss ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LED1_a0),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(OPERATIONAL_LED) );

// atom is at LC_X5_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_0333 LED_SELECT_a18_I
            ( .dataa( vdd ),
              .datab(LED_SELECT),
              .datac(PO14),
              .datad(PO13),
              .inverta( vss ),
              .combout(LED_SELECT_a18) );

// atom is at LC_X5_Y7_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff LED_SELECT_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(RESET),
              .aload( vss ),
              .ena(LED_SELECT_a18),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LED_SELECT) );

// atom is at LC_X4_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_9099 LED2_a0_I
            ( .dataa(DATA_LATCH_4),
              .datab(DATA_LATCH_5),
              .datac(RESET_FPGA),
              .datad(SDA_INT),
              .inverta( vss ),
              .combout(LED2_a0) );

// atom is at LC_X4_Y7_N4
lcell_stratix_on_sd_cx_c0x_c1x_82c3 LED1_a0_I
            ( .dataa(RESET_FPGA),
              .datab(DATA_LATCH_6),
              .datac(DATA_LATCH_7),
              .datad(SDA_INT),
              .inverta( vss ),
              .combout(LED1_a0) );

endmodule
module PICDATA ( safe_q_0, safe_q_1, SLOT_STATE_0, SLOT_STATE_1, BYTE_LATCH_6, reduce_nor, TX_STATE_0, TX_STATE_2, BYTE_LATCH2, reduce_nor1, reduce_nor2, TX_STATE_1, reduce_nor3, reduce_nor4, reduce_nor5, reduce_nor6, reduce_nor7, BYTE_LATCH_61, safe_q_01, safe_q_11, safe_q_2, reduce_nor8, reduce_nor9, reduce_nor10, CDU_RX_LATCH, BYTE_LATCH_62, BYTE_LATCH_63, BYTE_LATCH_64, BYTE_LATCH_66, ISSM_LATCH_23, Mux1, LINK_LATCH_71, Mux2, LATCH_CSSM_DATA, SS, LATCH_3, Mux6, Mux10, Mux13, BYTE_LATCH_0, Mux18, Mux21, Mux25, Mux27, BYTE_LATCH_68, CLK, RESET_FPGA, SDI_FPGA, devclrn, devpor, devoe, BYTE_LATCH, LINK_LATCH_7, BYTE_LATCH1, BYTE_LATCH3, BYTE_LATCH4, BYTE_LATCH5, BYTE_LATCH6, Mux, BYTE_LATCH_65, BYTE_LATCH_67, SHIFT_REG_22, SHIFT_REG_21, SHIFT_REG_20, SHIFT_REG_0, Mux3, BYTE_LATCH_5, BYTE_LATCH_51, Mux4, BYTE_LATCH_4, LINK_LATCH_4, BYTE_LATCH_41, Mux5, Mux7, Mux8, Mux9, Mux11, Mux12, ISSM_LATCH_2, Mux14, Mux15, Mux16, Mux17, Mux19, Mux20, Mux22, Mux23, Mux24, Mux26, Mux28, Mux29);
input safe_q_0;
input safe_q_1;
input SLOT_STATE_0;
input SLOT_STATE_1;
input BYTE_LATCH_6;
input reduce_nor;
input TX_STATE_0;
input TX_STATE_2;
input BYTE_LATCH2;
input reduce_nor1;
input reduce_nor2;
input TX_STATE_1;
input reduce_nor3;
input reduce_nor4;
input reduce_nor5;
input reduce_nor6;
input reduce_nor7;
input BYTE_LATCH_61;
input safe_q_01;
input safe_q_11;
input safe_q_2;
input reduce_nor8;
input reduce_nor9;
input reduce_nor10;
input CDU_RX_LATCH;
input BYTE_LATCH_62;
input BYTE_LATCH_63;
input BYTE_LATCH_64;
input BYTE_LATCH_66;
input ISSM_LATCH_23;
input Mux1;
input LINK_LATCH_71;
input Mux2;
input LATCH_CSSM_DATA;
input SS;
input LATCH_3;
input Mux6;
input Mux10;
input Mux13;
input BYTE_LATCH_0;
input Mux18;
input Mux21;
input Mux25;
input Mux27;
input BYTE_LATCH_68;
input CLK;
input RESET_FPGA;
input SDI_FPGA;
input devclrn;
input devpor;
input devoe;
output BYTE_LATCH;
output LINK_LATCH_7;
output BYTE_LATCH1;
output BYTE_LATCH3;
output BYTE_LATCH4;
output BYTE_LATCH5;
output BYTE_LATCH6;
output Mux;
output BYTE_LATCH_65;
output BYTE_LATCH_67;
output SHIFT_REG_22;
output SHIFT_REG_21;
output SHIFT_REG_20;
output SHIFT_REG_0;
output Mux3;
output BYTE_LATCH_5;
output BYTE_LATCH_51;
output Mux4;
output BYTE_LATCH_4;
output LINK_LATCH_4;
output BYTE_LATCH_41;
output Mux5;
output Mux7;
output Mux8;
output Mux9;
output Mux11;
output Mux12;
output ISSM_LATCH_2;
output Mux14;
output Mux15;
output Mux16;
output Mux17;
output Mux19;
output Mux20;
output Mux22;
output Mux23;
output Mux24;
output Mux26;
output Mux28;
output Mux29;
// atom is at LC_X10_Y3_N1
i1  inst_1
            ( .a( RESET_FPGA ),
              .zn( not__RESET_FPGA ) );
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0faa ISSM_LATCH_a23_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_6),
              .datac(SHIFT_REG_a23_a),
              .datad(reduce_nor),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH) );

// atom is at LC_X9_Y4_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_000c LINK_LATCH_a7_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(safe_q_0),
              .datac(SHIFT_REG_a7_a),
              .datad(safe_q_1),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH1),
              .regout(LINK_LATCH_7) );

// atom is at LC_X10_Y3_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c ISSM_LATCH_a15_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor2),
              .datac(SHIFT_REG_a12_a),
              .datad(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4919),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH3) );

// atom is at LC_X7_Y4_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c CSSM_LATCH_a39_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor),
              .datac(SHIFT_REG_a39_a),
              .datad(BYTE_LATCH_6),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH4) );

// atom is at LC_X12_Y1_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_01ab CSSM_LATCH_a23_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor3),
              .datab(reduce_nor4),
              .datac(SHIFT_REG_a23_a),
              .datad(CSSM_LATCH_a31_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH5) );

// atom is at LC_X11_Y3_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0fcc CSSM_LATCH_a15_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4923),
              .datac(SHIFT_REG_a15_a),
              .datad(reduce_nor7),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH6) );

// atom is at LC_X5_Y4_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4ecc CSS_ALLOC_LATCH_a3_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor9),
              .datab(CDU_RX_LATCH),
              .datac(LINK_LATCH_7),
              .datad(reduce_nor10),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux) );

// atom is at LC_X9_Y4_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_ee03 LINK_LATCH_a6_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1505),
              .datab(BYTE_LATCH_68),
              .datac(SHIFT_REG_a6_a),
              .datad(BYTE_LATCH_62),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_65),
              .regout(LINK_LATCH_a6_a) );

// atom is at LC_X10_Y2_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_46ce CSSM_LATCH_a30_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_66),
              .datab(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1506),
              .datac(SHIFT_REG_a30_a),
              .datad(CSSM_LATCH_a14_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_67) );

// atom is at LC_X10_Y1_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a22_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_21),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_22) );

// atom is at LC_X10_Y1_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a21_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_20),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_21) );

// atom is at LC_X10_Y1_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a20_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a19_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_20) );

// atom is at LC_X11_Y5_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_5555 SHIFT_REG_a0_a_aI
            ( .clk(CLK),
              .dataa(SDI_FPGA),
              .datac( vdd ),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_0) );

// atom is at LC_X7_Y5_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_efcd CSS_ALLOC_LATCH_a2_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_1),
              .datac(LINK_LATCH_a6_a),
              .datad(safe_q_2),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux3) );

// atom is at LC_X9_Y4_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_ee03 LINK_LATCH_a5_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1509),
              .datab(BYTE_LATCH_68),
              .datac(SHIFT_REG_a5_a),
              .datad(BYTE_LATCH_62),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_5),
              .regout(LINK_LATCH_a5_a) );

// atom is at LC_X10_Y2_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_27aa CSSM_LATCH_a5_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1510),
              .datab(CSSM_LATCH_a13_a),
              .datac(SHIFT_REG_a5_a),
              .datad(BYTE_LATCH_61),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_51) );

// atom is at LC_X7_Y5_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_efcd CSS_ALLOC_LATCH_a1_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_1),
              .datac(LINK_LATCH_a5_a),
              .datad(safe_q_11),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux4) );

// atom is at LC_X8_Y4_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_46ce CSSM_LATCH_a36_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_63),
              .datab(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1512),
              .datac(SHIFT_REG_a36_a),
              .datad(ISSM_LATCH_a12_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_4) );

// atom is at LC_X9_Y4_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LINK_LATCH_a4_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a4_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LINK_LATCH_4) );

// atom is at LC_X10_Y2_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_770a CSSM_LATCH_a28_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_66),
              .datab(CSSM_LATCH_a12_a),
              .datac(SHIFT_REG_a28_a),
              .datad(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1514),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_41) );

// atom is at LC_X9_Y4_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_eecf CSS_ALLOC_LATCH_a0_a_aI
            ( .clk(CLK),
              .dataa(safe_q_01),
              .datab(SLOT_STATE_1),
              .datac(LINK_LATCH_4),
              .datad(SLOT_STATE_0),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LINK_LATCH_71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux5) );

// atom is at LC_X11_Y6_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0200 CSSM_LATCH_a35_a_aI
            ( .clk(CLK),
              .dataa(Mux6),
              .datab(TX_STATE_2),
              .datac(SHIFT_REG_a35_a),
              .datad(Mux1),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux7) );

// atom is at LC_X12_Y1_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_01ab CSSM_LATCH_a19_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor3),
              .datab(reduce_nor4),
              .datac(SHIFT_REG_a19_a),
              .datad(CSSM_LATCH_a27_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux8) );

// atom is at LC_X12_Y2_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_04ae CSSM_LATCH_a3_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor7),
              .datab(reduce_nor5),
              .datac(SHIFT_REG_a3_a),
              .datad(CSSM_LATCH_a11_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux9) );

// atom is at LC_X11_Y5_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_2e00 ISSM_LATCH_a11_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aMux_a13271),
              .datab(reduce_nor2),
              .datac(SHIFT_REG_a8_a),
              .datad(Mux10),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux11) );

// atom is at LC_X11_Y5_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0200 ISSM_LATCH_a19_a_aI
            ( .clk(CLK),
              .dataa(TX_STATE_0),
              .datab(TX_STATE_2),
              .datac(SHIFT_REG_a16_a),
              .datad(Mux6),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux12) );

// atom is at LC_X11_Y3_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff ISSM_LATCH_a2_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_2) );

// atom is at LC_X11_Y3_N6
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_bf15 ISSM_LATCH_a18_a_aI
            ( .clk(CLK),
              .dataa(TX_STATE_2),
              .datab(TX_STATE_0),
              .datac(SHIFT_REG_a15_a),
              .datad(a_aCDU_aTRANSMIT_BLOCK_aMux_a13284),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux14) );

// atom is at LC_X12_Y1_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_01ab CSSM_LATCH_a18_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor3),
              .datab(reduce_nor4),
              .datac(SHIFT_REG_a18_a),
              .datad(CSSM_LATCH_a26_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux15) );

// atom is at LC_X12_Y2_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_04ae CSSM_LATCH_a2_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor7),
              .datab(reduce_nor5),
              .datac(SHIFT_REG_a2_a),
              .datad(CSSM_LATCH_a10_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux16) );

// atom is at LC_X11_Y6_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0200 CSSM_LATCH_a34_a_aI
            ( .clk(CLK),
              .dataa(Mux6),
              .datab(TX_STATE_2),
              .datac(SHIFT_REG_a34_a),
              .datad(Mux1),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux17) );

// atom is at LC_X11_Y3_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c ISSM_LATCH_a9_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor2),
              .datac(SHIFT_REG_a6_a),
              .datad(Mux18),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux19) );

// atom is at LC_X11_Y4_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_5f0a ISSM_LATCH_a17_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor),
              .datac(SHIFT_REG_a14_a),
              .datad(BYTE_LATCH_0),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux20) );

// atom is at LC_X12_Y3_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8b00 CSSM_LATCH_a17_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aMux_a13303),
              .datab(reduce_nor4),
              .datac(SHIFT_REG_a17_a),
              .datad(Mux21),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux22) );

// atom is at LC_X8_Y4_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0004 CSSM_LATCH_a33_a_aI
            ( .clk(CLK),
              .dataa(TX_STATE_1),
              .datab(reduce_nor),
              .datac(SHIFT_REG_a33_a),
              .datad(TX_STATE_2),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux23) );

// atom is at LC_X12_Y3_N6
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0808 CSSM_LATCH_a25_a_aI
            ( .clk(CLK),
              .dataa(TX_STATE_2),
              .datab(TX_STATE_1),
              .datac(SHIFT_REG_a25_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux24) );

// atom is at LC_X11_Y4_N6
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_cc0a ISSM_LATCH_a16_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor),
              .datab(a_aCDU_aTRANSMIT_BLOCK_aMux_a13315),
              .datac(SHIFT_REG_a13_a),
              .datad(TX_STATE_2),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux26) );

// atom is at LC_X12_Y3_N3
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_4c08 CSSM_LATCH_a24_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor3),
              .datab(Mux2),
              .datac(SHIFT_REG_a24_a),
              .datad(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4950),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux28) );

// atom is at LC_X8_Y4_N3
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0c00 CSSM_LATCH_a32_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor),
              .datac(SHIFT_REG_a32_a),
              .datad(Mux27),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux29) );

// atom is at LC_X10_Y1_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a23_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_22),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a23_a) );

// atom is at LC_X12_Y2_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a1_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_0),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a1_a) );

// atom is at LC_X12_Y2_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a2_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a1_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a2_a) );

// atom is at LC_X12_Y2_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a3_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a2_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a3_a) );

// atom is at LC_X10_Y1_N2
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a4_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a3_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a4_a) );

// atom is at LC_X10_Y1_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a5_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a4_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a5_a) );

// atom is at LC_X9_Y4_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a6_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a5_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a6_a) );

// atom is at LC_X9_Y4_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a7_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a6_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a7_a) );

// atom is at LC_X12_Y3_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a8_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a7_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a8_a) );

// atom is at LC_X11_Y5_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a9_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a8_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a9_a) );

// atom is at LC_X11_Y2_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a10_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a9_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a10_a) );

// atom is at LC_X11_Y2_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a11_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a10_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a11_a) );

// atom is at LC_X11_Y2_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a12_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a11_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a12_a) );

// atom is at LC_X10_Y3_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_5f0a ISSM_LATCH_a7_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor1),
              .datac(SHIFT_REG_a4_a),
              .datad(BYTE_LATCH2),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4919) );

// atom is at LC_X10_Y1_N9
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a24_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a23_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a24_a) );

// atom is at LC_X12_Y3_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a25_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a24_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a25_a) );

// atom is at LC_X12_Y3_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a26_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a25_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a26_a) );

// atom is at LC_X12_Y1_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a27_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a26_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a27_a) );

// atom is at LC_X12_Y1_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a28_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a27_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a28_a) );

// atom is at LC_X10_Y2_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a29_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a28_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a29_a) );

// atom is at LC_X10_Y2_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a30_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a29_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a30_a) );

// atom is at LC_X8_Y4_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a31_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a30_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a31_a) );

// atom is at LC_X8_Y4_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a32_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a31_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a32_a) );

// atom is at LC_X8_Y4_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a33_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a32_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a33_a) );

// atom is at LC_X9_Y4_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a34_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a33_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a34_a) );

// atom is at LC_X11_Y6_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a35_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a34_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a35_a) );

// atom is at LC_X7_Y4_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a36_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a35_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a36_a) );

// atom is at LC_X7_Y4_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a37_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a36_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a37_a) );

// atom is at LC_X7_Y4_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a38_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a37_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a38_a) );

// atom is at LC_X7_Y4_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a39_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a38_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a39_a) );

// atom is at LC_X12_Y1_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a31_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a31_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a31_a) );

// atom is at LC_X11_Y3_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0a4e CSSM_LATCH_a7_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor5),
              .datab(BYTE_LATCH_6),
              .datac(SHIFT_REG_a7_a),
              .datad(reduce_nor6),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4923) );

// atom is at LC_X11_Y2_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a13_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a12_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a13_a) );

// atom is at LC_X11_Y2_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a14_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a13_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a14_a) );

// atom is at LC_X11_Y2_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 SHIFT_REG_a15_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a14_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a15_a) );

// atom is at LC_X11_Y2_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a16_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a15_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a16_a) );

// atom is at LC_X11_Y2_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a17_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a16_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a17_a) );

// atom is at LC_X12_Y1_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a18_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a17_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a18_a) );

// atom is at LC_X12_Y1_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SHIFT_REG_a19_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a18_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(SS),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SHIFT_REG_a19_a) );

// atom is at LC_X11_Y1_N8
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_LATCH_a22_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a19_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a22_a) );

// atom is at LC_X11_Y1_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_af11 ISSM_LATCH_a6_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_63),
              .datab(ISSM_LATCH_a22_a),
              .datac(SHIFT_REG_a3_a),
              .datad(BYTE_LATCH_64),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1504) );

// atom is at LC_X11_Y2_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_LATCH_a14_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a11_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a14_a) );

// atom is at LC_X11_Y1_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_46ce CSSM_LATCH_a38_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_63),
              .datab(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1504),
              .datac(SHIFT_REG_a38_a),
              .datad(ISSM_LATCH_a14_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1505) );

// atom is at LC_X10_Y1_N8
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a22_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_22),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a22_a) );

// atom is at LC_X10_Y2_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8c9d CSSM_LATCH_a6_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_66),
              .datab(BYTE_LATCH_61),
              .datac(SHIFT_REG_a6_a),
              .datad(CSSM_LATCH_a22_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a6_a_a1506) );

// atom is at LC_X10_Y2_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 CSSM_LATCH_a14_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a14_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a14_a) );

// atom is at LC_X11_Y1_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 ISSM_LATCH_a21_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a18_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a21_a) );

// atom is at LC_X11_Y1_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_aa1b CSSM_LATCH_a37_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_63),
              .datab(ISSM_LATCH_a21_a),
              .datac(SHIFT_REG_a37_a),
              .datad(BYTE_LATCH_64),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1508) );

// atom is at LC_X11_Y1_N2
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_LATCH_a13_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a10_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a13_a) );

// atom is at LC_X11_Y1_N3
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_27aa ISSM_LATCH_a5_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1508),
              .datab(ISSM_LATCH_a13_a),
              .datac(SHIFT_REG_a2_a),
              .datad(BYTE_LATCH_64),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1509) );

// atom is at LC_X10_Y1_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a21_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_21),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a21_a) );

// atom is at LC_X10_Y2_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8a9b CSSM_LATCH_a29_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_66),
              .datab(BYTE_LATCH_61),
              .datac(SHIFT_REG_a29_a),
              .datad(CSSM_LATCH_a21_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a5_a_a1510) );

// atom is at LC_X10_Y2_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 CSSM_LATCH_a13_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a13_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a13_a) );

// atom is at LC_X11_Y1_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_LATCH_a20_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a17_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a20_a) );

// atom is at LC_X11_Y1_N6
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_af11 ISSM_LATCH_a4_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_63),
              .datab(ISSM_LATCH_a20_a),
              .datac(SHIFT_REG_a1_a),
              .datad(BYTE_LATCH_64),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1512) );

// atom is at LC_X11_Y5_N9
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_LATCH_a12_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a9_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_LATCH_a12_a) );

// atom is at LC_X10_Y3_N0
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a12_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a12_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a12_a) );

// atom is at LC_X10_Y1_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 CSSM_LATCH_a20_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_20),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a20_a) );

// atom is at LC_X10_Y2_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8c9d CSSM_LATCH_a4_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_66),
              .datab(BYTE_LATCH_61),
              .datac(SHIFT_REG_a4_a),
              .datad(CSSM_LATCH_a20_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4_a_a1514) );

// atom is at LC_X12_Y1_N8
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a27_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a27_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a27_a) );

// atom is at LC_X12_Y2_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a11_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a11_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a11_a) );

// atom is at LC_X11_Y5_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0f88 ISSM_LATCH_a3_a_aI
            ( .clk(CLK),
              .dataa(LATCH_3),
              .datab(reduce_nor8),
              .datac(SHIFT_REG_0),
              .datad(reduce_nor1),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aMux_a13271) );

// atom is at LC_X11_Y3_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c ISSM_LATCH_a10_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor2),
              .datac(SHIFT_REG_a7_a),
              .datad(Mux13),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aMux_a13284) );

// atom is at LC_X12_Y1_N9
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a26_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a26_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a26_a) );

// atom is at LC_X11_Y1_N0
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a10_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a10_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a10_a) );

// atom is at LC_X12_Y2_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 CSSM_LATCH_a9_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SHIFT_REG_a9_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a9_a) );

// atom is at LC_X12_Y2_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_04ae CSSM_LATCH_a1_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor7),
              .datab(reduce_nor5),
              .datac(SHIFT_REG_a1_a),
              .datad(CSSM_LATCH_a9_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aMux_a13303) );

// atom is at LC_X11_Y3_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_3f0c ISSM_LATCH_a8_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor2),
              .datac(SHIFT_REG_a5_a),
              .datad(Mux25),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(ISSM_LATCH_23),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aMux_a13315) );

// atom is at LC_X12_Y2_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 CSSM_LATCH_a8_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SHIFT_REG_a8_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CSSM_LATCH_a8_a) );

// atom is at LC_X12_Y2_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_04ae CSSM_LATCH_a0_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor7),
              .datab(reduce_nor5),
              .datac(SHIFT_REG_0),
              .datad(CSSM_LATCH_a8_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4949) );

// atom is at LC_X12_Y3_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8b8b CSSM_LATCH_a16_a_aI
            ( .clk(CLK),
              .dataa(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4949),
              .datab(reduce_nor4),
              .datac(SHIFT_REG_a16_a),
              .aclr( not__RESET_FPGA ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(LATCH_CSSM_DATA),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(a_aCDU_aTRANSMIT_BLOCK_aBYTE_LATCH_a4950) );

endmodule
module RECEIVE ( safe_q_2, safe_q_4, safe_q_6, safe_q_7, safe_q_8, safe_q_3, safe_q_5, safe_q_0, safe_q_1, reduce_nor, reduce_nor1, reduce_nor2, reduce_nor3, Mux, Mux1, SHIFT_REG_22, SHIFT_REG_21, SHIFT_REG_20, SHIFT_REG_0, Mux2, Mux3, Mux4, Mux5, CLK, CDU_EN, RESET, CDU_RX, PO1, PO2, devclrn, devpor, devoe, FIRST_ISSM, SPI_ENABLE, SDO, SS_OUT_2, FRAME_SYNC, SLOT_SYNC, UL_SYNC, SLOT_STATE_0, SLOT_STATE_1, SLOT_STATE_2, RX_STATE_0, TS_COUNT_2, TS_COUNT_1, TS_COUNT_0, safe_q_01, safe_q_11, safe_q_21, reduce_nor4, reduce_nor5, START_SPI1, CDU_RX_LATCH, reduce_nor6, SLOT_STATE_11, reduce_nor7, ISSM_LATCH_23, LINK_LATCH_7, LATCH_CSSM_DATA, SS);
input safe_q_2;
input safe_q_4;
input safe_q_6;
input safe_q_7;
input safe_q_8;
input safe_q_3;
input safe_q_5;
input safe_q_0;
input safe_q_1;
input reduce_nor;
input reduce_nor1;
input reduce_nor2;
input reduce_nor3;
input Mux;
input Mux1;
input SHIFT_REG_22;
input SHIFT_REG_21;
input SHIFT_REG_20;
input SHIFT_REG_0;
input Mux2;
input Mux3;
input Mux4;
input Mux5;
input CLK;
input CDU_EN;
input RESET;
input CDU_RX;
input PO1;
input PO2;
input devclrn;
input devpor;
input devoe;
output FIRST_ISSM;
output SPI_ENABLE;
output SDO;
output SS_OUT_2;
output FRAME_SYNC;
output SLOT_SYNC;
output UL_SYNC;
output SLOT_STATE_0;
output SLOT_STATE_1;
output SLOT_STATE_2;
output RX_STATE_0;
output TS_COUNT_2;
output TS_COUNT_1;
output TS_COUNT_0;
output safe_q_01;
output safe_q_11;
output safe_q_21;
output reduce_nor4;
output reduce_nor5;
output START_SPI1;
output CDU_RX_LATCH;
output reduce_nor6;
output SLOT_STATE_11;
output reduce_nor7;
output ISSM_LATCH_23;
output LINK_LATCH_7;
output LATCH_CSSM_DATA;
output SS;
i1  inst_1
            ( .a( RESET ),
              .zn( not__RESET ) );
i1  inst_2
            ( .a( CLK ),
              .zn( not__CLK ) );
CRC_8    CRC_BLOCK
            ( .CDU_EN_DELAY(CDU_EN_DELAY),
              .CLK(CLK),
              .CDU_EN(CDU_EN),
              .RESET_FPGA(RESET),
              .CDU_RX(CDU_RX),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .CRC_BIT(CRC_BIT_a46),
              .CRC_BIT1(CRC_BIT_a47) );

// atom is at LC_X1_Y4_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_5555 CDU_EN_DELAY_aI
            ( .clk(CLK),
              .dataa(CDU_EN),
              .datac( vdd ),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(CDU_EN_DELAY) );

// atom is at LC_X8_Y6_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff FIRST_ISSM_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a19),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(FIRST_ISSM) );

// atom is at LC_X8_Y6_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0aff SPI_ENABLE_aI
            ( .clk(CLK),
              .dataa(SPI_ENABLE),
              .datac(END_SPI),
              .datad(SPI_ENABLE_a67),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SPI_ENABLE) );

// atom is at LC_X4_Y4_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff SDO_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(BYTE_LATCH_a7_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SDO) );

// atom is at LC_X3_Y6_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SS_OUT_a2_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SS_OUT_a1_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SS_OUT_2) );

// atom is at LC_X12_Y4_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff FRAME_SYNC_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(SLOT_STATE_0),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(TS_COUNT_a2_a_a71),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(FRAME_SYNC) );

// atom is at LC_X12_Y6_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ce00 SLOT_SYNC_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_1),
              .datab(SLOT_SYNC),
              .datac(SLOT_STATE_2),
              .datad(SET_SYNC),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SLOT_SYNC) );

// atom is at LC_X7_Y6_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0003 UL_SYNC_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(UL_SYNC_INT_a71),
              .datac(UL_SYNC_INT_a72),
              .datad(UL_SYNC_INT_a73),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(UL_SYNC) );

// atom is at LC_X4_Y5_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_1a4a SLOT_STATE_a0_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_a593),
              .datab(CDU_RX),
              .datac(reduce_nor_a189),
              .datad(SLOT_BIT),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SLOT_STATE_0) );

// atom is at LC_X4_Y5_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0100 SLOT_STATE_a1_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_2),
              .datab(SLOT_STATE_1),
              .datac(SLOT_STATE_0),
              .datad(SLOT_BIT),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(SLOT_STATE_a1_a_a597),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SLOT_STATE_1) );

// atom is at LC_X4_Y5_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0001 SLOT_STATE_a2_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_2),
              .datab(SLOT_STATE_1),
              .datac(SLOT_STATE_0),
              .datad(SLOT_BIT),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(SLOT_STATE_a1_a_a597),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SLOT_STATE_2) );

// atom is at LC_X5_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_00c0 RX_STATE_a0_a_a2080_I
            ( .dataa( vdd ),
              .datab(safe_q_8),
              .datac(safe_q_6),
              .datad(safe_q_7),
              .inverta( vss ),
              .combout(RX_STATE_0) );

// atom is at LC_X9_Y6_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_48c0 TS_COUNT_a2_a_aI
            ( .clk(CLK),
              .dataa(TS_COUNT_0),
              .datab(TS_COUNT_a72),
              .datac(TS_COUNT_2),
              .datad(TS_COUNT_1),
              .aclr( vss ),
              .aload( vss ),
              .ena(TS_COUNT_a2_a_aadv_mux_opt_ce_319),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TS_COUNT_2) );

// atom is at LC_X9_Y6_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_4488 TS_COUNT_a1_a_aI
            ( .clk(CLK),
              .dataa(TS_COUNT_1),
              .datab(TS_COUNT_a72),
              .datac( vdd ),
              .datad(TS_COUNT_0),
              .aclr( vss ),
              .aload( vss ),
              .ena(TS_COUNT_a2_a_aadv_mux_opt_ce_319),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TS_COUNT_1) );

// atom is at LC_X9_Y6_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0020 TS_COUNT_a0_a_aI
            ( .clk(CLK),
              .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(TS_COUNT_0),
              .aclr( vss ),
              .aload( vss ),
              .ena(TS_COUNT_a2_a_aadv_mux_opt_ce_319),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TS_COUNT_0) );

// atom is at LC_X7_Y6_N0
lcell_stratix_sof_rof_pol_oa_sd_cf_c0f_c1f_33cc ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella0
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(safe_q_01),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a20),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_01),
              .cout0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella0_aCOUT),
              .cout1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella0_aCOUTCOUT1_3) );

// atom is at LC_X7_Y6_N1
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_3c3f ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella1
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(safe_q_11),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a20),
              .cin0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella0_aCOUT),
              .cin1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella0_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_11),
              .cout0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella1_aCOUT),
              .cout1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella1_aCOUTCOUT1_1) );

// atom is at LC_X7_Y6_N2
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_c30c ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella2
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(safe_q_21),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a20),
              .cin0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella1_aCOUT),
              .cin1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella1_aCOUTCOUT1_1),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(safe_q_21),
              .cout0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella2_aCOUT),
              .cout1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella2_aCOUTCOUT1_3) );

// atom is at LC_X4_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_0003 reduce_nor_a187_I
            ( .dataa( vdd ),
              .datab(safe_q_2),
              .datac(safe_q_0),
              .datad(safe_q_1),
              .inverta( vss ),
              .combout(reduce_nor4) );

// atom is at LC_X5_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_4000 reduce_nor_a188_I
            ( .dataa(safe_q_7),
              .datab(safe_q_8),
              .datac(safe_q_6),
              .datad(Mux_a6645),
              .inverta( vss ),
              .combout(reduce_nor5) );

// atom is at LC_X3_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_0050 START_SPI_a25_I
            ( .dataa(SLOT_STATE_0),
              .datac(SLOT_STATE_2),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(START_SPI1) );

// atom is at LC_X4_Y4_N4
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_d0d0 CDU_RX_LATCH_aI
            ( .clk(CLK),
              .dataa(RX_STATE_a1_a),
              .datab(RX_STATE_a0_a),
              .datac(CDU_RX),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux_a6647),
              .regout(CDU_RX_LATCH) );

// atom is at LC_X6_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_5fff reduce_nor_a17_I
            ( .dataa(Mux_a6645),
              .datac(reduce_nor1),
              .datad(RX_STATE_0),
              .inverta( vss ),
              .combout(reduce_nor6) );

// atom is at LC_X9_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_0f00 SLOT_STATE_a1_a_a599_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(SLOT_STATE_11) );

// atom is at LC_X3_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_000f reduce_nor_a190_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_0),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(reduce_nor7) );

// atom is at LC_X10_Y4_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_8000 LATCH_ISSM_DATA_aI
            ( .clk( not__CLK ),
              .dataa(SHIFT_REG_21),
              .datab(SHIFT_REG_20),
              .datac(ISSM_TEMP_a1_a),
              .datad(SHIFT_REG_22),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(ISSM_LATCH_23) );

// atom is at LC_X7_Y5_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f000 LATCH_LINK_DATA_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(LINK_TEMP_a1_a),
              .datad(SHIFT_REG_0),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(LINK_LATCH_7) );

// atom is at LC_X7_Y5_N8
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LATCH_CSSM_DATA_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(PIC_CSSM_DATA),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_CSSM_DATA) );

// atom is at LC_X8_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_f0ff SS_aI
            ( .dataa( vdd ),
              .datac(SPI_ENABLE),
              .datad(FIRST_ISSM),
              .inverta( vss ),
              .combout(SS) );

// atom is at LC_X3_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_00f0 FRAME_SYNC_a31_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_2),
              .inverta( vss ),
              .combout(FRAME_SYNC_a31) );

// atom is at LC_X2_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_000c Mux_a6666_I
            ( .dataa( vdd ),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6666) );

// atom is at LC_X5_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_0404 Mux_a6663_I
            ( .dataa(safe_q_4),
              .datab(safe_q_2),
              .datac(safe_q_0),
              .inverta( vss ),
              .combout(Mux_a6663) );

// atom is at LC_X6_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_bdbf RX_STATE_a0_a_a2083_I
            ( .dataa(safe_q_3),
              .datab(safe_q_1),
              .datac(SLOT_STATE_1),
              .datad(RX_STATE_0),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2083) );

// atom is at LC_X6_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_00c0 RX_STATE_a0_a_a2015_I
            ( .dataa( vdd ),
              .datab(safe_q_5),
              .datac(Mux_a6663),
              .datad(RX_STATE_a0_a_a2083),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2015) );

// atom is at LC_X6_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_f5ff reduce_nor_a8_I
            ( .dataa(reduce_nor4),
              .datac(safe_q_3),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(reduce_nor_a8) );

// atom is at LC_X6_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_0300 Mux_a6645_I
            ( .dataa( vdd ),
              .datab(safe_q_4),
              .datac(safe_q_3),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(Mux_a6645) );

// atom is at LC_X5_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_d1f3 RX_STATE_a0_a_a2081_I
            ( .dataa(reduce_nor4),
              .datab(SLOT_STATE_1),
              .datac(reduce_nor_a8),
              .datad(Mux_a6645),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2081) );

// atom is at LC_X5_Y4_N3
lcell_stratix_on_sd_cx_c0x_c1x_77f0 RX_STATE_a0_a_a2082_I
            ( .dataa(reduce_nor4),
              .datab(reduce_nor5),
              .datac(RX_STATE_a0_a_a2081),
              .datad(reduce_nor7),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2082) );

// atom is at LC_X3_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_cfca RX_STATE_a0_a_a2066_I
            ( .dataa(reduce_nor7),
              .datab(reduce_nor2),
              .datac(RX_STATE_a1_a),
              .datad(RX_STATE_a0_a_a2082),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2066) );

// atom is at LC_X3_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_2a4c RX_STATE_a0_a_a2067_I
            ( .dataa(RX_STATE_a0_a),
              .datab(RX_STATE_a1_a),
              .datac(RX_STATE_a0_a_a2015),
              .datad(RX_STATE_a0_a_a2066),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2067) );

// atom is at LC_X3_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_0220 RX_STATE_a0_a_a2085_I
            ( .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_1),
              .datac(RX_STATE_a1_a),
              .datad(RX_STATE_a0_a),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2085) );

// atom is at LC_X3_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_bbb1 RX_STATE_a0_a_a2084_I
            ( .dataa(RX_STATE_a0_a),
              .datab(reduce_nor3),
              .datac(reduce_nor7),
              .datad(RX_STATE_a0_a_a2082),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2084) );

// atom is at LC_X3_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_eac0 RX_STATE_a0_a_a2086_I
            ( .dataa(RX_STATE_a0_a_a2067),
              .datab(RX_STATE_a0_a_a2085),
              .datac(RX_STATE_a0_a_a2084),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2086) );

// atom is at LC_X3_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_55aa Mux_a790_I
            ( .dataa(RX_STATE_a0_a),
              .datad(RX_STATE_a1_a),
              .inverta( vss ),
              .combout(Mux_a790) );

// atom is at LC_X6_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_7fff reduce_nor_a15_I
            ( .dataa(reduce_nor4),
              .datab(safe_q_4),
              .datac(safe_q_3),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor_a15) );

// atom is at LC_X3_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_ada8 RX_STATE_a0_a_a2032_I
            ( .dataa(RX_STATE_a0_a),
              .datab(reduce_nor_a15),
              .datac(RX_STATE_a2_a),
              .datad(reduce_nor6),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2032) );

// atom is at LC_X3_Y4_N3
lcell_stratix_on_sd_cx_c0x_c1x_5fc0 RX_STATE_a0_a_a2038_I
            ( .dataa(RX_STATE_a0_a_a2015),
              .datab(RX_STATE_a0_a_a2082),
              .datac(RX_STATE_a2_a),
              .datad(RX_STATE_a0_a_a2032),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2038) );

// atom is at LC_X3_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_1000 RX_STATE_a0_a_a2039_I
            ( .dataa(SLOT_STATE_1),
              .datab(SLOT_STATE_0),
              .datac(Mux_a790),
              .datad(RX_STATE_a0_a_a2038),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2039) );

// atom is at LC_X2_Y4_N8
lcell_stratix_on_sd_cx_c0x_c1x_aaef RX_STATE_a0_a_a2087_I
            ( .dataa(Mux),
              .datab(RX_STATE_a2_a),
              .datac(RX_STATE_a0_a_a2086),
              .datad(RX_STATE_a0_a_a2039),
              .inverta( vss ),
              .combout(RX_STATE_a0_a_a2087) );

// atom is at LC_X2_Y4_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2600 RX_STATE_a2_a_aI
            ( .clk( not__CLK ),
              .dataa(RX_STATE_a1_a),
              .datab(RX_STATE_a0_a),
              .datac(SLOT_STATE_0),
              .datad(Mux_a6666),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(RX_STATE_a0_a_a2087),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RX_STATE_a2_a) );

// atom is at LC_X2_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_000c Mux_a6659_I
            ( .dataa( vdd ),
              .datab(RX_STATE_a0_a),
              .datac(RX_STATE_a1_a),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6659) );

// atom is at LC_X2_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_2828 Mux_a6660_I
            ( .dataa(Mux_a6659),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .inverta( vss ),
              .combout(Mux_a6660) );

// atom is at LC_X2_Y4_N3
lcell_stratix_on_sd_cx_c0x_c1x_0430 Mux_a6661_I
            ( .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6661) );

// atom is at LC_X2_Y4_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_baaa RX_STATE_a1_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a6660),
              .datab(RX_STATE_a0_a),
              .datac(RX_STATE_a1_a),
              .datad(Mux_a6661),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(RX_STATE_a0_a_a2087),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RX_STATE_a1_a) );

// atom is at LC_X2_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_ec33 Mux_a6664_I
            ( .dataa(SLOT_STATE_0),
              .datab(SLOT_STATE_1),
              .datac(RX_STATE_a1_a),
              .datad(SLOT_STATE_2),
              .inverta( vss ),
              .combout(Mux_a6664) );

// atom is at LC_X2_Y4_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0003 RX_STATE_a0_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datab(RX_STATE_a0_a),
              .datac(Mux_a6664),
              .datad(RX_STATE_a2_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(RX_STATE_a0_a_a2087),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(RX_STATE_a0_a) );

// atom is at LC_X3_Y6_N8
lcell_stratix_on_sd_cx_c0x_c1x_0c00 SET_SYNC_a29_I
            ( .dataa( vdd ),
              .datab(RX_STATE_a0_a),
              .datac(RX_STATE_a2_a),
              .datad(RX_STATE_a1_a),
              .inverta( vss ),
              .combout(SET_SYNC_a29) );

// atom is at LC_X5_Y6_N2
lcell_stratix_on_sd_cx_c0x_c1x_4000 Mux_a6440_I
            ( .dataa(safe_q_0),
              .datab(SET_SYNC_a29),
              .datac(safe_q_1),
              .datad(Mux_a6645),
              .inverta( vss ),
              .combout(Mux_a6440) );

// atom is at LC_X3_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_3033 Mux_a876_I
            ( .dataa( vdd ),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(Mux_a876) );

// atom is at LC_X5_Y6_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a888 PIC_ISSM_DATA_aI
            ( .clk( not__CLK ),
              .dataa(FRAME_SYNC_a31),
              .datab(PIC_ISSM_DATA),
              .datac(safe_q_2),
              .datad(Mux_a6440),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(Mux_a876),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(PIC_ISSM_DATA) );

// atom is at LC_X7_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_ff33 ISS_DET_a0_I
            ( .dataa( vdd ),
              .datab(RESET),
              .datad(PIC_ISSM_DATA),
              .inverta( vss ),
              .combout(ISS_DET_a0) );

// atom is at LC_X8_Y7_N1
lcell_stratix_oa_sd_cf_c0f_c1f_55aa add_a118_I
            ( .dataa(ISS_BIT_COUNT_a0_a),
              .inverta( vss ),
              .combout(add_a118),
              .cout0(add_a118COUT),
              .cout1(add_a118COUTCOUT1_136) );

// atom is at LC_X8_Y6_N9
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_a000 ISS_BIT_COUNT_a0_a_aI
            ( .clk(CLK),
              .dataa(ISS_BIT_COUNT_a1_a),
              .datac(add_a118),
              .datad(reduce_nor_a185),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a20),
              .regout(ISS_BIT_COUNT_a0_a) );

// atom is at LC_X8_Y7_N2
lcell_stratix_oa_sc_cf_c0tx_c1tx_5a5f add_a119_I
            ( .dataa(ISS_BIT_COUNT_a1_a),
              .cin0(add_a118COUT),
              .cin1(add_a118COUTCOUT1_136),
              .inverta( vss ),
              .combout(add_a119),
              .cout0(add_a119COUT),
              .cout1(add_a119COUTCOUT1_138) );

// atom is at LC_X8_Y6_N2
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0c00 ISS_BIT_COUNT_a1_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datab(reduce_nor_a185),
              .datac(add_a119),
              .datad(ISS_BIT_COUNT_a0_a),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a19),
              .regout(ISS_BIT_COUNT_a1_a) );

// atom is at LC_X8_Y7_N3
lcell_stratix_oa_sc_cf_c0tx_c1tx_c30c add_a120_I
            ( .dataa( vdd ),
              .datab(ISS_BIT_COUNT_a2_a),
              .cin0(add_a119COUT),
              .cin1(add_a119COUTCOUT1_138),
              .inverta( vss ),
              .combout(add_a120),
              .cout0(add_a120COUT),
              .cout1(add_a120COUTCOUT1_139) );

// atom is at LC_X8_Y7_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2aaa ISS_BIT_COUNT_a2_a_aI
            ( .clk(CLK),
              .dataa(add_a120),
              .datab(reduce_nor_a185),
              .datac(ISS_BIT_COUNT_a0_a),
              .datad(ISS_BIT_COUNT_a1_a),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISS_BIT_COUNT_a2_a) );

// atom is at LC_X8_Y7_N4
lcell_stratix_oa_sc_cf_c0tx_c1tx_5a5f add_a121_I
            ( .dataa(ISS_BIT_COUNT_a3_a),
              .cin0(add_a120COUT),
              .cin1(add_a120COUTCOUT1_139),
              .inverta( vss ),
              .combout(add_a121),
              .cout(add_a121COUT) );

// atom is at LC_X8_Y6_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_70f0 ISS_BIT_COUNT_a3_a_aI
            ( .clk(CLK),
              .dataa(ISS_BIT_COUNT_a1_a),
              .datab(reduce_nor_a185),
              .datac(add_a121),
              .datad(ISS_BIT_COUNT_a0_a),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISS_BIT_COUNT_a3_a) );

// atom is at LC_X8_Y7_N5
lcell_stratix_oa_sc_ct_c0f_c1f_c30c add_a122_I
            ( .dataa( vdd ),
              .datab(ISS_BIT_COUNT_a4_a),
              .cin(add_a121COUT),
              .cin0( vss ),
              .cin1( vdd ),
              .inverta( vss ),
              .combout(add_a122),
              .cout0(add_a122COUT),
              .cout1(add_a122COUTCOUT1_141) );

// atom is at LC_X8_Y7_N6
lcell_stratix_on_sc_ct_c0tx_c1tx_0ff0 add_a123_I
            ( .dataa( vdd ),
              .datad(ISS_BIT_COUNT_a5_a),
              .cin(add_a121COUT),
              .cin0(add_a122COUT),
              .cin1(add_a122COUTCOUT1_141),
              .inverta( vss ),
              .combout(add_a123) );

// atom is at LC_X8_Y7_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2aaa ISS_BIT_COUNT_a5_a_aI
            ( .clk(CLK),
              .dataa(add_a123),
              .datab(reduce_nor_a185),
              .datac(ISS_BIT_COUNT_a0_a),
              .datad(ISS_BIT_COUNT_a1_a),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISS_BIT_COUNT_a5_a) );

// atom is at LC_X8_Y7_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_0200 ISS_BIT_COUNT_a4_a_aI
            ( .clk(CLK),
              .dataa(ISS_BIT_COUNT_a3_a),
              .datab(ISS_BIT_COUNT_a2_a),
              .datac(add_a122),
              .datad(ISS_BIT_COUNT_a5_a),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(reduce_nor_a185),
              .regout(ISS_BIT_COUNT_a4_a) );

// atom is at LC_X4_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_0504 Mux_a6672_I
            ( .dataa(END_UPLINK),
              .datab(SLOT_STATE_0),
              .datac(RX_STATE_a1_a),
              .datad(reduce_nor_a15),
              .inverta( vss ),
              .combout(Mux_a6672) );

// atom is at LC_X4_Y6_N2
lcell_stratix_on_sd_cx_c0x_c1x_a022 Mux_a6673_I
            ( .dataa(RX_STATE_a1_a),
              .datab(reduce_nor6),
              .datac(reduce_nor3),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(Mux_a6673) );

// atom is at LC_X4_Y6_N8
lcell_stratix_on_sd_cx_c0x_c1x_bbab Mux_a6674_I
            ( .dataa(Mux_a6672),
              .datab(RX_STATE_a0_a),
              .datac(END_UPLINK),
              .datad(Mux_a6673),
              .inverta( vss ),
              .combout(Mux_a6674) );

// atom is at LC_X6_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_0f00 Mux_a6668_I
            ( .dataa( vdd ),
              .datac(safe_q_3),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(Mux_a6668) );

// atom is at LC_X4_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_0040 Mux_a6669_I
            ( .dataa(RX_STATE_a1_a),
              .datab(RX_STATE_a0_a),
              .datac(safe_q_4),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6669) );

// atom is at LC_X7_Y4_N2
lcell_stratix_on_sd_cx_c0x_c1x_0001 Mux_a6644_I
            ( .dataa(safe_q_8),
              .datab(safe_q_4),
              .datac(safe_q_6),
              .datad(safe_q_7),
              .inverta( vss ),
              .combout(Mux_a6644) );

// atom is at LC_X4_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_cac0 Mux_a6670_I
            ( .dataa(END_UPLINK),
              .datab(Mux_a6669),
              .datac(SLOT_STATE_2),
              .datad(Mux_a6644),
              .inverta( vss ),
              .combout(Mux_a6670) );

// atom is at LC_X4_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_0800 Mux_a6671_I
            ( .dataa(Mux_a6668),
              .datab(reduce_nor1),
              .datac(SLOT_STATE_0),
              .datad(Mux_a6670),
              .inverta( vss ),
              .combout(Mux_a6671) );

// atom is at LC_X4_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_00f0 Mux_a6675_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_2),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6675) );

// atom is at LC_X4_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_00af Mux_a879_I
            ( .dataa(SLOT_STATE_2),
              .datac(SLOT_STATE_0),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(Mux_a879) );

// atom is at LC_X4_Y6_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f1f3 END_UPLINK_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a6674),
              .datab(Mux_a6671),
              .datac(SLOT_STATE_1),
              .datad(Mux_a6675),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(Mux_a879),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(END_UPLINK) );

// atom is at LC_X3_Y6_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00ff END_SPI_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(END_UPLINK),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(END_SPI) );

// atom is at LC_X6_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_000c reduce_nor_a186_I
            ( .dataa( vdd ),
              .datab(Mux_a6644),
              .datac(safe_q_3),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor_a186) );

// atom is at LC_X4_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_3000 Mux_a722_I
            ( .dataa( vdd ),
              .datab(RX_STATE_a0_a),
              .datac(RX_STATE_a1_a),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a722) );

// atom is at LC_X3_Y5_N0
lcell_stratix_on_sd_cx_c0x_c1x_5000 START_SPI_a26_I
            ( .dataa(RX_STATE_a0_a),
              .datac(RX_STATE_a1_a),
              .datad(START_SPI1),
              .inverta( vss ),
              .combout(START_SPI_a26) );

// atom is at LC_X5_Y4_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c888 START_SPI_aI
            ( .clk( not__CLK ),
              .dataa(START_SPI),
              .datab(Mux_a722),
              .datac(reduce_nor4),
              .datad(reduce_nor5),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(START_SPI_a26),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(START_SPI) );

// atom is at LC_X5_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_00df SPI_ENABLE_a67_I
            ( .dataa(reduce_nor_a186),
              .datab(safe_q_2),
              .datac(reduce_nor),
              .datad(START_SPI),
              .inverta( vss ),
              .combout(SPI_ENABLE_a67) );

// atom is at LC_X3_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_ee0f Mux_a6648_I
            ( .dataa(CRC_BIT_a47),
              .datab(CRC_BIT_a46),
              .datac(reduce_nor_a8),
              .datad(RX_STATE_a1_a),
              .inverta( vss ),
              .combout(Mux_a6648) );

// atom is at LC_X3_Y4_N2
lcell_stratix_on_sd_cx_c0x_c1x_dccc Mux_a6649_I
            ( .dataa(Mux),
              .datab(Mux_a6647),
              .datac(Mux_a790),
              .datad(Mux_a6648),
              .inverta( vss ),
              .combout(Mux_a6649) );

// atom is at LC_X5_Y4_N8
lcell_stratix_on_sd_cx_c0x_c1x_3fff BYTE_LATCH_a4_a_a753_I
            ( .dataa( vdd ),
              .datab(Mux_a6645),
              .datac(reduce_nor4),
              .datad(Mux_a6659),
              .inverta( vss ),
              .combout(BYTE_LATCH_a4_a_a753) );

// atom is at LC_X5_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_8000 Mux_a6678_I
            ( .dataa(RX_STATE_0),
              .datab(Mux_a6645),
              .datac(reduce_nor4),
              .datad(Mux_a722),
              .inverta( vss ),
              .combout(Mux_a6678) );

// atom is at LC_X5_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_008b BYTE_LATCH_a4_a_a754_I
            ( .dataa(BYTE_LATCH_a4_a_a753),
              .datab(SLOT_STATE_0),
              .datac(Mux_a6678),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a4_a_a754) );

// atom is at LC_X5_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_f3d3 BYTE_LATCH_a4_a_a755_I
            ( .dataa(Mux_a6659),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(reduce_nor_a8),
              .inverta( vss ),
              .combout(BYTE_LATCH_a4_a_a755) );

// atom is at LC_X6_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_0200 reduce_nor_a191_I
            ( .dataa(reduce_nor4),
              .datab(safe_q_4),
              .datac(safe_q_3),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor_a191) );

// atom is at LC_X5_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_c505 Mux_a6686_I
            ( .dataa(reduce_nor_a8),
              .datab(SLOT_STATE_0),
              .datac(SLOT_STATE_2),
              .datad(reduce_nor_a191),
              .inverta( vss ),
              .combout(Mux_a6686) );

// atom is at LC_X5_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_eac0 Mux_a6687_I
            ( .dataa(Mux_a6659),
              .datab(Mux_a6678),
              .datac(Mux5),
              .datad(Mux_a6686),
              .inverta( vss ),
              .combout(Mux_a6687) );

// atom is at LC_X5_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_f1fb BYTE_LATCH_a1_a_a756_I
            ( .dataa(reduce_nor7),
              .datab(Mux_a6659),
              .datac(Mux),
              .datad(Mux_a722),
              .inverta( vss ),
              .combout(BYTE_LATCH_a1_a_a756) );

// atom is at LC_X5_Y5_N3
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ffff BYTE_LATCH_a0_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac( vdd ),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a0_a) );

// atom is at LC_X5_Y5_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_fb01 BYTE_LATCH_a1_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a1_a_a756),
              .datab(PO2),
              .datac(RX_STATE_a0_a_a2082),
              .datad(BYTE_LATCH_a0_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a1_a) );

// atom is at LC_X5_Y5_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c8cd BYTE_LATCH_a2_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a1_a_a756),
              .datab(BYTE_LATCH_a1_a),
              .datac(RX_STATE_a0_a_a2082),
              .datad(PO1),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a2_a) );

// atom is at LC_X5_Y5_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_d700 BYTE_LATCH_a3_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a6687),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(BYTE_LATCH_a2_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a3_a) );

// atom is at LC_X5_Y5_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a8ab BYTE_LATCH_a4_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a3_a),
              .datab(BYTE_LATCH_a4_a_a755),
              .datac(BYTE_LATCH_a4_a_a754),
              .datad(Mux4),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a4_a) );

// atom is at LC_X5_Y5_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_c8cd BYTE_LATCH_a5_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a4_a_a754),
              .datab(BYTE_LATCH_a4_a),
              .datac(BYTE_LATCH_a4_a_a755),
              .datad(Mux3),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a5_a) );

// atom is at LC_X5_Y5_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_e0f1 BYTE_LATCH_a6_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a4_a_a754),
              .datab(BYTE_LATCH_a4_a_a755),
              .datac(BYTE_LATCH_a5_a),
              .datad(Mux2),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a6_a) );

// atom is at LC_X3_Y4_N8
lcell_stratix_on_sd_cx_c0x_c1x_f0f4 Mux_a866_I
            ( .dataa(RX_STATE_a0_a),
              .datab(RX_STATE_a1_a),
              .datac(RX_STATE_a2_a),
              .datad(reduce_nor2),
              .inverta( vss ),
              .combout(Mux_a866) );

// atom is at LC_X3_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_05cc Mux_a6650_I
            ( .dataa(Mux),
              .datab(Mux_a6649),
              .datac(BYTE_LATCH_a6_a),
              .datad(Mux_a866),
              .inverta( vss ),
              .combout(Mux_a6650) );

// atom is at LC_X4_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_e232 Mux_a6651_I
            ( .dataa(Mux_a6650),
              .datab(SLOT_STATE_2),
              .datac(CDU_RX_LATCH),
              .datad(SLOT_STATE_1),
              .inverta( vss ),
              .combout(Mux_a6651) );

// atom is at LC_X3_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_0fee Mux_a6653_I
            ( .dataa(CRC_BIT_a47),
              .datab(CRC_BIT_a46),
              .datac(BYTE_LATCH_a6_a),
              .datad(reduce_nor6),
              .inverta( vss ),
              .combout(Mux_a6653) );

// atom is at LC_X4_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_0a0c Mux_a6654_I
            ( .dataa(Mux1),
              .datab(Mux_a6653),
              .datac(SLOT_STATE_0),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6654) );

// atom is at LC_X4_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_30c0 Mux_a6564_I
            ( .dataa( vdd ),
              .datab(RX_STATE_a0_a),
              .datac(SLOT_STATE_0),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(Mux_a6564) );

// atom is at LC_X4_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_4022 Mux_a6565_I
            ( .dataa(RX_STATE_a1_a),
              .datab(RX_STATE_a0_a),
              .datac(reduce_nor_a191),
              .datad(Mux_a6564),
              .inverta( vss ),
              .combout(Mux_a6565) );

// atom is at LC_X7_Y6_N3
lcell_stratix_sof_rof_pol_oa_sc_cf_c0tx_c1tx_5a5f ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella3
            ( .clk(CLK),
              .dataa(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a3_a),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a20),
              .cin0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella2_aCOUT),
              .cin1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella2_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a3_a),
              .cout0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella3_aCOUT),
              .cout1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella3_aCOUTCOUT1_3) );

// atom is at LC_X3_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_f3a3 Mux_a6655_I
            ( .dataa(CRC_BIT_a47),
              .datab(BYTE_LATCH_a6_a),
              .datac(reduce_nor3),
              .datad(CRC_BIT_a46),
              .inverta( vss ),
              .combout(Mux_a6655) );

// atom is at LC_X4_Y4_N2
lcell_stratix_on_sd_cx_c0x_c1x_a808 Mux_a6656_I
            ( .dataa(SLOT_STATE_0),
              .datab(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a3_a),
              .datac(RX_STATE_a1_a),
              .datad(Mux_a6655),
              .inverta( vss ),
              .combout(Mux_a6656) );

// atom is at LC_X4_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_fcb8 Mux_a6657_I
            ( .dataa(Mux_a6654),
              .datab(Mux_a6565),
              .datac(CDU_RX_LATCH),
              .datad(Mux_a6656),
              .inverta( vss ),
              .combout(Mux_a6657) );

// atom is at LC_X4_Y4_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0b0f BYTE_LATCH_a7_a_aI
            ( .clk( not__CLK ),
              .dataa(SLOT_STATE_1),
              .datab(SLOT_STATE_2),
              .datac(Mux_a6651),
              .datad(Mux_a6657),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a7_a) );

// atom is at LC_X3_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_1000 Mux_a6682_I
            ( .dataa(RX_STATE_a2_a),
              .datab(RX_STATE_a0_a),
              .datac(reduce_nor2),
              .datad(RX_STATE_a1_a),
              .inverta( vss ),
              .combout(Mux_a6682) );

// atom is at LC_X3_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_2030 SSSM_END_a5_I
            ( .dataa(SLOT_STATE_1),
              .datab(SLOT_STATE_2),
              .datac(RESET),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(SSSM_END_a5) );

// atom is at LC_X3_Y6_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f400 SSSM_END_aI
            ( .clk( not__CLK ),
              .dataa(SET_SYNC_a29),
              .datab(SSSM_END),
              .datac(Mux_a6682),
              .datad(FRAME_SYNC_a31),
              .aclr( vss ),
              .aload( vss ),
              .ena(SSSM_END_a5),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SSSM_END) );

// atom is at LC_X3_Y6_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0f8f SS_OUT_a0_a_aI
            ( .clk(CLK),
              .dataa(SS_OUT_a0_a),
              .datab(END_UPLINK),
              .datac(SPI_ENABLE_a67),
              .datad(SSSM_END),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SS_OUT_a0_a) );

// atom is at LC_X3_Y6_N0
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 SS_OUT_a1_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(SS_OUT_a0_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SS_OUT_a1_a) );

// atom is at LC_X12_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_0a00 SET_SYNC_a30_I
            ( .dataa(SLOT_STATE_1),
              .datac(SLOT_STATE_2),
              .datad(SET_SYNC_a29),
              .inverta( vss ),
              .combout(SET_SYNC_a30) );

// atom is at LC_X12_Y6_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0080 SET_SYNC_aI
            ( .clk( not__CLK ),
              .dataa(safe_q_4),
              .datab(safe_q_3),
              .datac(reduce_nor4),
              .datad(SET_SYNC),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(SET_SYNC_a30),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SET_SYNC) );

// atom is at LC_X12_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_0a00 TS_COUNT_a2_a_a71_I
            ( .dataa(SLOT_STATE_1),
              .datac(SLOT_STATE_2),
              .datad(SET_SYNC),
              .inverta( vss ),
              .combout(TS_COUNT_a2_a_a71) );

// atom is at LC_X8_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_fffb UL_SYNC_INT_a71_I
            ( .dataa(ISS_BIT_COUNT_a4_a),
              .datab(ISS_BIT_COUNT_a3_a),
              .datac(ISS_BIT_COUNT_a1_a),
              .datad(UL_SYNC),
              .inverta( vss ),
              .combout(UL_SYNC_INT_a71) );

// atom is at LC_X8_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_ffef UL_SYNC_INT_a72_I
            ( .dataa(safe_q_01),
              .datab(ISS_BIT_COUNT_a5_a),
              .datac(ISS_BIT_COUNT_a2_a),
              .datad(ISS_BIT_COUNT_a0_a),
              .inverta( vss ),
              .combout(UL_SYNC_INT_a72) );

// atom is at LC_X7_Y6_N4
lcell_stratix_sof_rof_pol_on_sc_cf_c0tx_c1tx_a5a5 ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella4
            ( .clk(CLK),
              .dataa(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a4_a),
              .datac( vdd ),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena(reduce_nor_a20),
              .cin0(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella3_aCOUT),
              .cin1(ISS_SLOT_NO_rtl_1_aauto_generated_acounter_cella3_aCOUTCOUT1_3),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a4_a) );

// atom is at LC_X7_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_ffbf UL_SYNC_INT_a73_I
            ( .dataa(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a3_a),
              .datab(safe_q_21),
              .datac(ISS_SLOT_NO_rtl_1_aauto_generated_asafe_q_a4_a),
              .datad(safe_q_11),
              .inverta( vss ),
              .combout(UL_SYNC_INT_a73) );

// atom is at LC_X4_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_0101 reduce_nor_a189_I
            ( .dataa(SLOT_STATE_2),
              .datab(SLOT_STATE_1),
              .datac(SLOT_STATE_0),
              .inverta( vss ),
              .combout(reduce_nor_a189) );

// atom is at LC_X4_Y6_N0
lcell_stratix_on_sd_cx_c0x_c1x_0f0e SLOT_STATE_a595_I
            ( .dataa(RX_STATE_a1_a),
              .datab(RX_STATE_a0_a),
              .datac(reduce_nor_a189),
              .datad(RX_STATE_a2_a),
              .inverta( vss ),
              .combout(SLOT_STATE_a595) );

// atom is at LC_X4_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_ffbf reduce_nor_a2_I
            ( .dataa(safe_q_1),
              .datab(reduce_nor_a186),
              .datac(safe_q_0),
              .datad(safe_q_2),
              .inverta( vss ),
              .combout(reduce_nor_a2) );

// atom is at LC_X4_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_4a40 SLOT_STATE_a593_I
            ( .dataa(reduce_nor_a189),
              .datab(SLOT_STATE_0),
              .datac(SLOT_STATE_a595),
              .datad(reduce_nor_a2),
              .inverta( vss ),
              .combout(SLOT_STATE_a593) );

// atom is at LC_X4_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_a000 SLOT_BIT_a32_I
            ( .dataa(reduce_nor_a189),
              .datac(reduce_nor_a186),
              .datad(reduce_nor4),
              .inverta( vss ),
              .combout(SLOT_BIT_a32) );

// atom is at LC_X2_Y5_N1
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_aaaa SLOT_BIT_aI
            ( .clk(CLK),
              .dataa(CDU_RX),
              .datac( vdd ),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(SLOT_BIT_a32),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(SLOT_BIT) );

// atom is at LC_X4_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_0555 SLOT_STATE_a1_a_a597_I
            ( .dataa(SLOT_STATE_a595),
              .datac(reduce_nor_a189),
              .datad(reduce_nor_a2),
              .inverta( vss ),
              .combout(SLOT_STATE_a1_a_a597) );

// atom is at LC_X9_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_3000 TS_COUNT_a72_I
            ( .dataa( vdd ),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(TS_COUNT_a72) );

// atom is at LC_X12_Y6_N2
lcell_stratix_on_sd_cx_c0x_c1x_0800 TS_COUNT_a2_a_aadv_mux_opt_ce_319_I
            ( .dataa(SLOT_STATE_1),
              .datab(RESET),
              .datac(SLOT_STATE_2),
              .datad(SET_SYNC),
              .inverta( vss ),
              .combout(TS_COUNT_a2_a_aadv_mux_opt_ce_319) );

// atom is at LC_X7_Y5_N7
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_TEMP_a0_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(PIC_ISSM_DATA),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_TEMP_a0_a) );

// atom is at LC_X7_Y5_N5
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 ISSM_TEMP_a1_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(ISSM_TEMP_a0_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(ISSM_TEMP_a1_a) );

// atom is at LC_X5_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_0008 Mux_a6688_I
            ( .dataa(safe_q_1),
              .datab(safe_q_2),
              .datac(safe_q_0),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(Mux_a6688) );

// atom is at LC_X5_Y6_N8
lcell_stratix_on_sd_cx_c0x_c1x_6444 Mux_a6689_I
            ( .dataa(Mux_a6659),
              .datab(PIC_LINK_DATA),
              .datac(Mux_a6688),
              .datad(safe_q_3),
              .inverta( vss ),
              .combout(Mux_a6689) );

// atom is at LC_X5_Y6_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_2200 PIC_LINK_DATA_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a6689),
              .datab(SLOT_STATE_2),
              .datac( vdd ),
              .datad(SLOT_STATE_1),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(Mux_a876),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(PIC_LINK_DATA) );

// atom is at LC_X3_Y5_N6
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LINK_TEMP_a0_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(PIC_LINK_DATA),
              .aclr( vss ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(RESET),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LINK_TEMP_a0_a) );

// atom is at LC_X3_Y5_N3
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LINK_TEMP_a1_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datac(LINK_TEMP_a0_a),
              .aclr( vss ),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena(RESET),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LINK_TEMP_a1_a) );

// atom is at LC_X8_Y6_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0040 PIC_CSSM_DATA_aI
            ( .clk(CLK),
              .dataa(ISS_BIT_COUNT_a1_a),
              .datab(reduce_nor_a185),
              .datac(ISS_BIT_COUNT_a0_a),
              .datad(FIRST_ISSM),
              .aclr(ISS_DET_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(PIC_CSSM_DATA) );

endmodule
module CRC_8 ( CDU_EN_DELAY, CLK, CDU_EN, RESET_FPGA, CDU_RX, devclrn, devpor, devoe, CRC_BIT, CRC_BIT1);
input CDU_EN_DELAY;
input CLK;
input CDU_EN;
input RESET_FPGA;
input CDU_RX;
input devclrn;
input devpor;
input devoe;
output CRC_BIT;
output CRC_BIT1;
// atom is at LC_X1_Y4_N8
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fffe LATCH_a6_a_aI
            ( .clk(CLK),
              .dataa(LATCH_a5_a),
              .datab(LATCH_a4_a),
              .datac(LATCH_a5_a),
              .datad(LATCH_a7_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(CRC_BIT),
              .regout(LATCH_a6_a) );

// atom is at LC_X1_Y4_N0
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fffe LATCH_a3_a_aI
            ( .clk(CLK),
              .dataa(LATCH_a0_a),
              .datab(LATCH_a2_a),
              .datac(LATCH_a2_a),
              .datad(LATCH_a1_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(CRC_BIT1),
              .regout(LATCH_a3_a) );

// atom is at LC_X1_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_33f3 SHIFT_a0_I
            ( .dataa( vdd ),
              .datab(RESET_FPGA),
              .datac(CDU_EN),
              .datad(CDU_EN_DELAY),
              .inverta( vss ),
              .combout(SHIFT_a0) );

// atom is at LC_X1_Y4_N2
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LATCH_a4_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(LATCH_a3_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a4_a) );

// atom is at LC_X1_Y4_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff00 LATCH_a5_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac( vdd ),
              .datad(LATCH_a4_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a5_a) );

// atom is at LC_X1_Y4_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_9966 LATCH_a7_a_aI
            ( .clk(CLK),
              .dataa(CDU_RX),
              .datab(LATCH_a7_a),
              .datac( vdd ),
              .datad(LATCH_a6_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a7_a) );

// atom is at LC_X1_Y4_N5
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_55aa LATCH_a0_a_aI
            ( .clk(CLK),
              .dataa(CDU_RX),
              .datac( vdd ),
              .datad(LATCH_a7_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a0_a) );

// atom is at LC_X1_Y4_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_0000 LATCH_a1_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(LATCH_a0_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a1_a) );

// atom is at LC_X1_Y4_N7
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_9966 LATCH_a2_a_aI
            ( .clk(CLK),
              .dataa(CDU_RX),
              .datab(LATCH_a7_a),
              .datac( vdd ),
              .datad(LATCH_a1_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_a2_a) );

endmodule
module TRANSMIT ( safe_q_2, safe_q_4, safe_q_3, safe_q_5, safe_q_0, safe_q_1, SLOT_STATE_0, SLOT_STATE_1, SLOT_STATE_2, BYTE_LATCH, LINK_LATCH_7, BYTE_LATCH1, BYTE_LATCH3, BYTE_LATCH4, BYTE_LATCH5, BYTE_LATCH6, RX_STATE_0, TS_COUNT_2, TS_COUNT_1, TS_COUNT_0, START_SPI, reduce_nor10, SLOT_STATE_11, BYTE_LATCH_65, BYTE_LATCH_67, reduce_nor11, BYTE_LATCH_5, BYTE_LATCH_51, BYTE_LATCH_4, LINK_LATCH_4, BYTE_LATCH_41, Mux5, Mux6, Mux7, Mux9, Mux10, ISSM_LATCH_2, Mux12, Mux13, Mux14, Mux15, Mux17, Mux18, Mux20, Mux21, Mux22, Mux24, Mux26, Mux27, CLK, CDU_EN, RESET, devclrn, devpor, devoe, CDU_TX, reduce_nor, BYTE_LATCH_6, reduce_nor1, TX_STATE_0, TX_STATE_2, BYTE_LATCH2, reduce_nor2, reduce_nor3, TX_STATE_1, reduce_nor4, reduce_nor5, reduce_nor6, reduce_nor7, reduce_nor8, BYTE_LATCH_61, Mux, reduce_nor9, BYTE_LATCH_62, BYTE_LATCH_63, BYTE_LATCH_64, BYTE_LATCH_66, Mux1, Mux2, Mux3, LATCH_3, Mux4, Mux8, Mux11, BYTE_LATCH_0, Mux16, Mux19, Mux23, Mux25, BYTE_LATCH_68);
input safe_q_2;
input safe_q_4;
input safe_q_3;
input safe_q_5;
input safe_q_0;
input safe_q_1;
input SLOT_STATE_0;
input SLOT_STATE_1;
input SLOT_STATE_2;
input BYTE_LATCH;
input LINK_LATCH_7;
input BYTE_LATCH1;
input BYTE_LATCH3;
input BYTE_LATCH4;
input BYTE_LATCH5;
input BYTE_LATCH6;
input RX_STATE_0;
input TS_COUNT_2;
input TS_COUNT_1;
input TS_COUNT_0;
input START_SPI;
input reduce_nor10;
input SLOT_STATE_11;
input BYTE_LATCH_65;
input BYTE_LATCH_67;
input reduce_nor11;
input BYTE_LATCH_5;
input BYTE_LATCH_51;
input BYTE_LATCH_4;
input LINK_LATCH_4;
input BYTE_LATCH_41;
input Mux5;
input Mux6;
input Mux7;
input Mux9;
input Mux10;
input ISSM_LATCH_2;
input Mux12;
input Mux13;
input Mux14;
input Mux15;
input Mux17;
input Mux18;
input Mux20;
input Mux21;
input Mux22;
input Mux24;
input Mux26;
input Mux27;
input CLK;
input CDU_EN;
input RESET;
input devclrn;
input devpor;
input devoe;
output CDU_TX;
output reduce_nor;
output BYTE_LATCH_6;
output reduce_nor1;
output TX_STATE_0;
output TX_STATE_2;
output BYTE_LATCH2;
output reduce_nor2;
output reduce_nor3;
output TX_STATE_1;
output reduce_nor4;
output reduce_nor5;
output reduce_nor6;
output reduce_nor7;
output reduce_nor8;
output BYTE_LATCH_61;
output Mux;
output reduce_nor9;
output BYTE_LATCH_62;
output BYTE_LATCH_63;
output BYTE_LATCH_64;
output BYTE_LATCH_66;
output Mux1;
output Mux2;
output Mux3;
output LATCH_3;
output Mux4;
output Mux8;
output Mux11;
output BYTE_LATCH_0;
output Mux16;
output Mux19;
output Mux23;
output Mux25;
output BYTE_LATCH_68;
i1  inst_1
            ( .a( CLK ),
              .zn( not__CLK ) );
i1  inst_2
            ( .a( RESET ),
              .zn( not__RESET ) );
i1  inst_3
            ( .a( SLOT_STATE_2 ),
              .zn( not__SLOT_STATE_2 ) );
CRC_81   CRC_BLOCK
            ( .BYTE_LATCH_7(BYTE_LATCH_a7_a),
              .safe_q_4(safe_q_4),
              .reduce_nor(reduce_nor_a177),
              .TX_STATE_3(TX_STATE_a3_a),
              .BYTE_LATCH_6(BYTE_LATCH_62),
              .BYTE_LATCH_61(BYTE_LATCH_65),
              .BYTE_LATCH_62(BYTE_LATCH_67),
              .BYTE_LATCH_5(BYTE_LATCH_5),
              .BYTE_LATCH_51(BYTE_LATCH_51),
              .LINK_LATCH_4(LINK_LATCH_4),
              .BYTE_LATCH_2(BYTE_LATCH_a2_a),
              .Mux(Mux_a13260),
              .BYTE_LATCH_0(BYTE_LATCH_0),
              .BYTE_LATCH_64(BYTE_LATCH_68),
              .CLK(CLK),
              .CDU_EN(CDU_EN),
              .RESET_FPGA(RESET),
              .devclrn(devclrn),
              .devpor(devpor),
              .devoe(devoe),
              .LATCH_7(CRC_BLOCK_aLATCH_a7_a),
              .BYTE_LATCH_63(BYTE_LATCH_a6_a_a1517),
              .BYTE_LATCH_52(BYTE_LATCH_a5_a_a1519),
              .BYTE_LATCH_4(BYTE_LATCH_a4_a_a1520),
              .LATCH_3(LATCH_3),
              .Mux1(Mux_a13261),
              .LATCH_2(CRC_BLOCK_aLATCH_a2_a),
              .LATCH_1(CRC_BLOCK_aLATCH_a1_a),
              .Mux2(Mux_a13297),
              .LATCH_0(CRC_BLOCK_aLATCH_a0_a) );

// atom is at LC_X1_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_ffcc CDU_TX_a1_I
            ( .dataa( vdd ),
              .datab(BYTE_LATCH_a7_a),
              .datad(CDU_EN),
              .inverta( vss ),
              .combout(CDU_TX) );

// atom is at LC_X5_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_0a0a reduce_nor_a175_I
            ( .dataa(safe_q_0),
              .datac(safe_q_1),
              .inverta( vss ),
              .combout(reduce_nor) );

// atom is at LC_X10_Y5_N2
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f3e2 BYTE_LATCH_a6_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13239),
              .datab(BYTE_LATCH_a6_a_a4948),
              .datac(BYTE_LATCH_a5_a),
              .datad(BYTE_LATCH_a6_a_a1517),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_6) );

// atom is at LC_X6_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_a000 reduce_nor_a176_I
            ( .dataa(safe_q_2),
              .datac(safe_q_0),
              .datad(safe_q_1),
              .inverta( vss ),
              .combout(reduce_nor1) );

// atom is at LC_X10_Y6_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_30ba TX_STATE_a0_a_aI
            ( .clk( not__CLK ),
              .dataa(TX_STATE_a0_a_a3336),
              .datab(TX_STATE_a3_a),
              .datac(Mux_a13241),
              .datad(Mux),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(TX_STATE_a0_a_a564),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TX_STATE_0) );

// atom is at LC_X10_Y6_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_00c0 TX_STATE_a2_a_aI
            ( .clk( not__CLK ),
              .dataa( vdd ),
              .datab(TX_STATE_0),
              .datac(Mux_a13241),
              .datad(TX_STATE_a3_a),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena(TX_STATE_a0_a_a564),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TX_STATE_2) );

// atom is at LC_X10_Y3_N8
lcell_stratix_on_sd_cx_c0x_c1x_b8f0 BYTE_LATCH_a4918_I
            ( .dataa(CRC_BLOCK_aLATCH_a7_a),
              .datab(safe_q_4),
              .datac(BYTE_LATCH_6),
              .datad(reduce_nor_a177),
              .inverta( vss ),
              .combout(BYTE_LATCH2) );

// atom is at LC_X12_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_3000 reduce_nor_a178_I
            ( .dataa( vdd ),
              .datab(safe_q_3),
              .datac(reduce_nor1),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(reduce_nor2) );

// atom is at LC_X12_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_00c0 reduce_nor_a179_I
            ( .dataa( vdd ),
              .datab(safe_q_3),
              .datac(reduce_nor1),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(reduce_nor3) );

// atom is at LC_X6_Y6_N4
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_ee22 TX_STATE_a1_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13249),
              .datab(SLOT_STATE_0),
              .datac(Mux_a13251),
              .datad(Mux_a13246),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr(Mux),
              .sload( not__SLOT_STATE_2 ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TX_STATE_1) );

// atom is at LC_X12_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_0020 reduce_nor_a7_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor4) );

// atom is at LC_X12_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_ffbf reduce_nor_a8_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor5) );

// atom is at LC_X12_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_1000 reduce_nor_a180_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor6) );

// atom is at LC_X8_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_0c00 reduce_nor_a11_I
            ( .dataa( vdd ),
              .datab(reduce_nor_a177),
              .datac(safe_q_4),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor7) );

// atom is at LC_X12_Y5_N0
lcell_stratix_on_sd_cx_c0x_c1x_0080 reduce_nor_a181_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(reduce_nor8) );

// atom is at LC_X12_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_ff9f BYTE_LATCH_a6_a_a4925_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(BYTE_LATCH_61) );

// atom is at LC_X2_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_f00f Mux_a2422_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_2),
              .inverta( vss ),
              .combout(Mux) );

// atom is at LC_X12_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_c000 reduce_nor_a182_I
            ( .dataa( vdd ),
              .datab(safe_q_3),
              .datac(reduce_nor1),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(reduce_nor9) );

// atom is at LC_X9_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_4051 BYTE_LATCH_a6_a_a4935_I
            ( .dataa(BYTE_LATCH_a6_a_a4932),
              .datab(SLOT_STATE_1),
              .datac(Mux_a13236),
              .datad(BYTE_LATCH_a6_a_a4934),
              .inverta( vss ),
              .combout(BYTE_LATCH_62) );

// atom is at LC_X8_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_33b3 BYTE_LATCH_a6_a_a4936_I
            ( .dataa(reduce_nor_a177),
              .datab(SLOT_STATE_0),
              .datac(TX_STATE_2),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(BYTE_LATCH_63) );

// atom is at LC_X11_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_f000 BYTE_LATCH_a6_a_a4937_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_0),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(BYTE_LATCH_64) );

// atom is at LC_X7_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_00a0 BYTE_LATCH_a6_a_a4938_I
            ( .dataa(safe_q_3),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(BYTE_LATCH_66) );

// atom is at LC_X11_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_00aa Mux_a13244_I
            ( .dataa(TX_STATE_0),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux1) );

// atom is at LC_X12_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_4000 Mux_a13253_I
            ( .dataa(TX_STATE_a3_a),
              .datab(TX_STATE_2),
              .datac(TX_STATE_0),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux2) );

// atom is at LC_X12_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_00f0 Mux_a13259_I
            ( .dataa( vdd ),
              .datac(SLOT_STATE_2),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(Mux3) );

// atom is at LC_X10_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_d9c8 Mux_a13262_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_0),
              .datac(reduce_nor1),
              .datad(reduce_nor),
              .inverta( vss ),
              .combout(Mux4) );

// atom is at LC_X11_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_f000 Mux_a13269_I
            ( .dataa( vdd ),
              .datac(TX_STATE_0),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux8) );

// atom is at LC_X11_Y3_N8
lcell_stratix_on_sd_cx_c0x_c1x_20ec Mux_a13283_I
            ( .dataa(reduce_nor9),
              .datab(reduce_nor2),
              .datac(CRC_BLOCK_aLATCH_a2_a),
              .datad(ISSM_LATCH_2),
              .inverta( vss ),
              .combout(Mux11) );

// atom is at LC_X12_Y4_N1
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_aacc BYTE_LATCH_a0_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13325),
              .datab(Mux_a13321),
              .datac(Mux_a13322),
              .datad(SLOT_STATE_0),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr(Mux),
              .sload( not__SLOT_STATE_2 ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_0) );

// atom is at LC_X11_Y3_N2
lcell_stratix_on_sd_cx_c0x_c1x_7744 Mux_a13298_I
            ( .dataa(ISSM_LATCH_2),
              .datab(reduce_nor2),
              .datad(Mux_a13297),
              .inverta( vss ),
              .combout(Mux16) );

// atom is at LC_X12_Y3_N8
lcell_stratix_on_sd_cx_c0x_c1x_b000 Mux_a13302_I
            ( .dataa(safe_q_5),
              .datab(reduce_nor3),
              .datac(TX_STATE_2),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux19) );

// atom is at LC_X11_Y3_N1
lcell_stratix_on_sd_cx_c0x_c1x_20ec Mux_a13314_I
            ( .dataa(reduce_nor9),
              .datab(reduce_nor2),
              .datac(CRC_BLOCK_aLATCH_a0_a),
              .datad(ISSM_LATCH_2),
              .inverta( vss ),
              .combout(Mux23) );

// atom is at LC_X8_Y4_N2
lcell_stratix_on_sd_cx_c0x_c1x_0050 Mux_a13317_I
            ( .dataa(TX_STATE_1),
              .datac(TX_STATE_0),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux25) );

// atom is at LC_X9_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_f4f0 BYTE_LATCH_a6_a_a4951_I
            ( .dataa(SLOT_STATE_0),
              .datab(BYTE_LATCH_62),
              .datac(BYTE_LATCH_a6_a_a4932),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(BYTE_LATCH_68) );

// atom is at LC_X5_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_8000 reduce_nor_a177_I
            ( .dataa(safe_q_1),
              .datab(safe_q_2),
              .datac(safe_q_0),
              .datad(safe_q_3),
              .inverta( vss ),
              .combout(reduce_nor_a177) );

// atom is at LC_X8_Y4_N6
lcell_stratix_on_sd_cx_c0x_c1x_bfff reduce_nor_a12_I
            ( .dataa(safe_q_5),
              .datab(reduce_nor_a177),
              .datac(safe_q_4),
              .datad(RX_STATE_0),
              .inverta( vss ),
              .combout(reduce_nor_a12) );

// atom is at LC_X1_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_0003 Mux_a13231_I
            ( .dataa( vdd ),
              .datab(TX_STATE_2),
              .datac(TX_STATE_0),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13231) );

// atom is at LC_X1_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_3a0a Mux_a13232_I
            ( .dataa(BYTE_LATCH_6),
              .datab(reduce_nor_a12),
              .datac(Mux_a13231),
              .datad(CRC_BLOCK_aLATCH_a7_a),
              .inverta( vss ),
              .combout(Mux_a13232) );

// atom is at LC_X10_Y3_N5
lcell_stratix_on_sd_cx_c0x_c1x_ff88 BYTE_LATCH_a4926_I
            ( .dataa(BYTE_LATCH_61),
              .datab(BYTE_LATCH6),
              .datad(BYTE_LATCH5),
              .inverta( vss ),
              .combout(BYTE_LATCH_a4926) );

// atom is at LC_X10_Y3_N2
lcell_stratix_on_sd_cx_c0x_c1x_ee30 Mux_a2441_I
            ( .dataa(BYTE_LATCH_6),
              .datab(TX_STATE_0),
              .datac(BYTE_LATCH1),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux_a2441) );

// atom is at LC_X10_Y3_N6
lcell_stratix_on_sd_cx_c0x_c1x_bbc0 Mux_a2444_I
            ( .dataa(BYTE_LATCH_a4926),
              .datab(TX_STATE_0),
              .datac(BYTE_LATCH4),
              .datad(Mux_a2441),
              .inverta( vss ),
              .combout(Mux_a2444) );

// atom is at LC_X1_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_b8e2 Mux_a13328_I
            ( .dataa(Mux_a2444),
              .datab(TX_STATE_2),
              .datac(BYTE_LATCH_6),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13328) );

// atom is at LC_X8_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_a000 Mux_a13252_I
            ( .dataa(reduce_nor_a12),
              .datac(TX_STATE_a3_a),
              .datad(Mux_a13231),
              .inverta( vss ),
              .combout(Mux_a13252) );

// atom is at LC_X8_Y5_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a888 TX_STATE_a3_a_aI
            ( .clk( not__CLK ),
              .dataa(START_SPI),
              .datab(Mux_a13252),
              .datac(Mux2),
              .datad(reduce_nor7),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(TX_STATE_a3_a) );

// atom is at LC_X1_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_ccf0 Mux_a13329_I
            ( .dataa( vdd ),
              .datab(Mux_a13232),
              .datac(Mux_a13328),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux_a13329) );

// atom is at LC_X7_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_0300 Mux_a13235_I
            ( .dataa( vdd ),
              .datab(safe_q_1),
              .datac(TX_STATE_1),
              .datad(safe_q_0),
              .inverta( vss ),
              .combout(Mux_a13235) );

// atom is at LC_X9_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_0088 Mux_a13236_I
            ( .dataa(TS_COUNT_1),
              .datab(TS_COUNT_2),
              .datad(TS_COUNT_0),
              .inverta( vss ),
              .combout(Mux_a13236) );

// atom is at LC_X7_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_a0aa Mux_a13237_I
            ( .dataa(Mux_a13235),
              .datac(Mux_a13236),
              .datad(LINK_LATCH_7),
              .inverta( vss ),
              .combout(Mux_a13237) );

// atom is at LC_X12_Y4_N8
lcell_stratix_on_sd_cx_c0x_c1x_0003 Mux_a13233_I
            ( .dataa( vdd ),
              .datab(TX_STATE_2),
              .datac(TX_STATE_0),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux_a13233) );

// atom is at LC_X1_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_a000 Mux_a13234_I
            ( .dataa(TX_STATE_1),
              .datac(reduce_nor_a177),
              .datad(CRC_BLOCK_aLATCH_a7_a),
              .inverta( vss ),
              .combout(Mux_a13234) );

// atom is at LC_X1_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_faca Mux_a13238_I
            ( .dataa(BYTE_LATCH_6),
              .datab(Mux_a13237),
              .datac(Mux_a13233),
              .datad(Mux_a13234),
              .inverta( vss ),
              .combout(Mux_a13238) );

// atom is at LC_X10_Y3_N3
lcell_stratix_on_sd_cx_c0x_c1x_e6c4 Mux_a2442_I
            ( .dataa(TX_STATE_0),
              .datab(Mux_a2441),
              .datac(BYTE_LATCH3),
              .datad(BYTE_LATCH),
              .inverta( vss ),
              .combout(Mux_a2442) );

// atom is at LC_X1_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_aab8 Mux_a13230_I
            ( .dataa(BYTE_LATCH_6),
              .datab(TX_STATE_a3_a),
              .datac(Mux_a2442),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13230) );

// atom is at LC_X1_Y5_N9
lcell_stratix_son_rof_pol_on_sd_cx_c0x_c1x_ee22 BYTE_LATCH_a7_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13329),
              .datab(SLOT_STATE_0),
              .datac(Mux_a13238),
              .datad(Mux_a13230),
              .aclr( not__RESET ),
              .aload( vss ),
              .sclr(Mux),
              .sload( not__SLOT_STATE_2 ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a7_a) );

// atom is at LC_X12_Y6_N0
lcell_stratix_on_sd_cx_c0x_c1x_cf3f BYTE_LATCH_a6_a_a4927_I
            ( .dataa( vdd ),
              .datab(safe_q_3),
              .datac(reduce_nor1),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4927) );

// atom is at LC_X10_Y6_N2
lcell_stratix_on_sd_cx_c0x_c1x_0080 BYTE_LATCH_a6_a_a4928_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_0),
              .datac(SLOT_STATE_11),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4928) );

// atom is at LC_X10_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_0008 BYTE_LATCH_a6_a_a4929_I
            ( .dataa(BYTE_LATCH_a6_a_a4927),
              .datab(BYTE_LATCH_a6_a_a4928),
              .datac(TX_STATE_a3_a),
              .datad(Mux),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4929) );

// atom is at LC_X6_Y6_N2
lcell_stratix_on_sd_cx_c0x_c1x_000f BYTE_LATCH_a6_a_a4930_I
            ( .dataa( vdd ),
              .datac(TX_STATE_2),
              .datad(TX_STATE_0),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4930) );

// atom is at LC_X6_Y6_N8
lcell_stratix_on_sd_cx_c0x_c1x_5002 BYTE_LATCH_a6_a_a4931_I
            ( .dataa(TX_STATE_a3_a),
              .datab(SLOT_STATE_0),
              .datac(SLOT_STATE_1),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4931) );

// atom is at LC_X6_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_aeaa BYTE_LATCH_a6_a_a4932_I
            ( .dataa(BYTE_LATCH_a6_a_a4929),
              .datab(BYTE_LATCH_a6_a_a4930),
              .datac(Mux),
              .datad(BYTE_LATCH_a6_a_a4931),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4932) );

// atom is at LC_X9_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_5000 Mux_a13239_I
            ( .dataa(BYTE_LATCH_a6_a_a4932),
              .datac(SLOT_STATE_1),
              .datad(Mux_a13236),
              .inverta( vss ),
              .combout(Mux_a13239) );

// atom is at LC_X8_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_0202 BYTE_LATCH_a6_a_a4952_I
            ( .dataa(reduce_nor_a12),
              .datab(SLOT_STATE_0),
              .datac(SLOT_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4952) );

// atom is at LC_X6_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_0001 BYTE_LATCH_a6_a_a4934_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_0),
              .datac(TX_STATE_a3_a),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4934) );

// atom is at LC_X6_Y6_N1
lcell_stratix_on_sd_cx_c0x_c1x_0010 BYTE_LATCH_a6_a_a4939_I
            ( .dataa(TX_STATE_2),
              .datab(SLOT_STATE_0),
              .datac(TX_STATE_a3_a),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4939) );

// atom is at LC_X6_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_ff72 BYTE_LATCH_a6_a_a4940_I
            ( .dataa(BYTE_LATCH_a6_a_a4934),
              .datab(reduce_nor),
              .datac(SLOT_STATE_1),
              .datad(BYTE_LATCH_a6_a_a4939),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4940) );

// atom is at LC_X9_Y5_N4
lcell_stratix_on_sd_cx_c0x_c1x_ce00 BYTE_LATCH_a6_a_a4941_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_1),
              .datac(TX_STATE_0),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4941) );

// atom is at LC_X9_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_0567 BYTE_LATCH_a6_a_a4942_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_1),
              .datac(reduce_nor1),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4942) );

// atom is at LC_X9_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_efee BYTE_LATCH_a6_a_a4943_I
            ( .dataa(BYTE_LATCH_a6_a_a4941),
              .datab(TX_STATE_a3_a),
              .datac(SLOT_STATE_1),
              .datad(BYTE_LATCH_a6_a_a4942),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4943) );

// atom is at LC_X9_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_00aa BYTE_LATCH_a6_a_a4933_I
            ( .dataa(TX_STATE_2),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4933) );

// atom is at LC_X12_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_ef1f BYTE_LATCH_a6_a_a4944_I
            ( .dataa(safe_q_3),
              .datab(safe_q_4),
              .datac(reduce_nor1),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4944) );

// atom is at LC_X9_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_eeae BYTE_LATCH_a6_a_a4945_I
            ( .dataa(BYTE_LATCH_a6_a_a4943),
              .datab(BYTE_LATCH_a6_a_a4933),
              .datac(TX_STATE_0),
              .datad(BYTE_LATCH_a6_a_a4944),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4945) );

// atom is at LC_X6_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_fdfc BYTE_LATCH_a6_a_a4946_I
            ( .dataa(BYTE_LATCH_a6_a_a4934),
              .datab(BYTE_LATCH_a6_a_a4940),
              .datac(Mux),
              .datad(BYTE_LATCH_a6_a_a4945),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4946) );

// atom is at LC_X8_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_545c BYTE_LATCH_a6_a_a4947_I
            ( .dataa(reduce_nor_a177),
              .datab(SLOT_STATE_0),
              .datac(SLOT_STATE_1),
              .datad(safe_q_4),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4947) );

// atom is at LC_X8_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_facc BYTE_LATCH_a6_a_a4948_I
            ( .dataa(BYTE_LATCH_a6_a_a4952),
              .datab(BYTE_LATCH_a6_a_a4946),
              .datac(BYTE_LATCH_a6_a_a4947),
              .datad(BYTE_LATCH_a6_a_a4932),
              .inverta( vss ),
              .combout(BYTE_LATCH_a6_a_a4948) );

// atom is at LC_X10_Y5_N5
lcell_stratix_on_sd_cx_c0x_c1x_f000 Mux_a13276_I
            ( .dataa( vdd ),
              .datac(reduce_nor_a177),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13276) );

// atom is at LC_X9_Y5_N0
lcell_stratix_on_sd_cx_c0x_c1x_0040 Mux_a13260_I
            ( .dataa(TX_STATE_0),
              .datab(RX_STATE_0),
              .datac(reduce_nor8),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13260) );

// atom is at LC_X1_Y5_N0
lcell_stratix_on_sd_cx_c0x_c1x_1434 Mux_a13294_I
            ( .dataa(SLOT_STATE_0),
              .datab(TX_STATE_a3_a),
              .datac(TX_STATE_0),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13294) );

// atom is at LC_X6_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_0800 Mux_a13293_I
            ( .dataa(TX_STATE_1),
              .datab(reduce_nor_a177),
              .datac(TX_STATE_a3_a),
              .datad(BYTE_LATCH_a6_a_a4930),
              .inverta( vss ),
              .combout(Mux_a13293) );

// atom is at LC_X6_Y6_N0
lcell_stratix_on_sd_cx_c0x_c1x_5808 Mux_a13295_I
            ( .dataa(SLOT_STATE_2),
              .datab(Mux_a13294),
              .datac(SLOT_STATE_1),
              .datad(Mux_a13293),
              .inverta( vss ),
              .combout(Mux_a13295) );

// atom is at LC_X11_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_0caa Mux_a13296_I
            ( .dataa(BYTE_LATCH_0),
              .datab(CRC_BLOCK_aLATCH_a1_a),
              .datac(SLOT_STATE_2),
              .datad(Mux_a13295),
              .inverta( vss ),
              .combout(Mux_a13296) );

// atom is at LC_X11_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_d080 Mux_a13301_I
            ( .dataa(TX_STATE_2),
              .datab(Mux17),
              .datac(SLOT_STATE_0),
              .datad(Mux18),
              .inverta( vss ),
              .combout(Mux_a13301) );

// atom is at LC_X12_Y7_N2
lcell_stratix_on_sd_cx_c0x_c1x_ef67 Mux_a13308_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_1),
              .datac(reduce_nor1),
              .datad(BYTE_LATCH_a6_a_a4944),
              .inverta( vss ),
              .combout(Mux_a13308) );

// atom is at LC_X12_Y3_N1
lcell_stratix_on_sd_cx_c0x_c1x_f0f8 Mux_a13307_I
            ( .dataa(Mux22),
              .datab(reduce_nor3),
              .datac(Mux21),
              .datad(safe_q_5),
              .inverta( vss ),
              .combout(Mux_a13307) );

// atom is at LC_X12_Y3_N4
lcell_stratix_on_sd_cx_c0x_c1x_ffec Mux_a13309_I
            ( .dataa(BYTE_LATCH_0),
              .datab(Mux20),
              .datac(Mux_a13308),
              .datad(Mux_a13307),
              .inverta( vss ),
              .combout(Mux_a13309) );

// atom is at LC_X11_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_f1f0 Mux_a13310_I
            ( .dataa(SLOT_STATE_0),
              .datab(TX_STATE_a3_a),
              .datac(Mux_a13301),
              .datad(Mux_a13309),
              .inverta( vss ),
              .combout(Mux_a13310) );

// atom is at LC_X11_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_000f Mux_a13243_I
            ( .dataa( vdd ),
              .datac(TX_STATE_1),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux_a13243) );

// atom is at LC_X11_Y4_N2
lcell_stratix_on_sd_cx_c0x_c1x_aea2 Mux_a13311_I
            ( .dataa(BYTE_LATCH_0),
              .datab(Mux_a13243),
              .datac(reduce_nor_a12),
              .datad(CRC_BLOCK_aLATCH_a1_a),
              .inverta( vss ),
              .combout(Mux_a13311) );

// atom is at LC_X11_Y4_N3
lcell_stratix_on_sd_cx_c0x_c1x_aeaa Mux_a13312_I
            ( .dataa(Mux_a13310),
              .datab(TX_STATE_a3_a),
              .datac(SLOT_STATE_0),
              .datad(Mux_a13311),
              .inverta( vss ),
              .combout(Mux_a13312) );

// atom is at LC_X11_Y4_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_f8f0 BYTE_LATCH_a1_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13295),
              .datab(SLOT_STATE_2),
              .datac(Mux_a13296),
              .datad(Mux_a13312),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a1_a) );

// atom is at LC_X11_Y6_N8
lcell_stratix_on_sd_cx_c0x_c1x_e040 Mux_a13289_I
            ( .dataa(Mux_a13260),
              .datab(BYTE_LATCH_a1_a),
              .datac(TX_STATE_a3_a),
              .datad(CRC_BLOCK_aLATCH_a2_a),
              .inverta( vss ),
              .combout(Mux_a13289) );

// atom is at LC_X11_Y6_N3
lcell_stratix_on_sd_cx_c0x_c1x_00d5 Mux_a13264_I
            ( .dataa(Mux4),
              .datab(TX_STATE_2),
              .datac(BYTE_LATCH_a6_a_a4944),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux_a13264) );

// atom is at LC_X11_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_fefa Mux_a13291_I
            ( .dataa(Mux_a13289),
              .datab(BYTE_LATCH_a1_a),
              .datac(Mux15),
              .datad(Mux_a13264),
              .inverta( vss ),
              .combout(Mux_a13291) );

// atom is at LC_X11_Y6_N5
lcell_stratix_on_sd_cx_c0x_c1x_08ff Mux_a13274_I
            ( .dataa(BYTE_LATCH_a6_a_a4927),
              .datab(TX_STATE_2),
              .datac(reduce_nor9),
              .datad(Mux4),
              .inverta( vss ),
              .combout(Mux_a13274) );

// atom is at LC_X11_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_f888 Mux_a13326_I
            ( .dataa(Mux_a13274),
              .datab(BYTE_LATCH_a1_a),
              .datac(Mux12),
              .datad(Mux4),
              .inverta( vss ),
              .combout(Mux_a13326) );

// atom is at LC_X12_Y7_N8
lcell_stratix_on_sd_cx_c0x_c1x_5000 Mux_a13324_I
            ( .dataa(TX_STATE_a3_a),
              .datac(TX_STATE_0),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux_a13324) );

// atom is at LC_X12_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_a8a0 Mux_a13288_I
            ( .dataa(Mux_a13324),
              .datab(Mux14),
              .datac(Mux13),
              .datad(BYTE_LATCH_61),
              .inverta( vss ),
              .combout(Mux_a13288) );

// atom is at LC_X12_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_f5e4 Mux_a13327_I
            ( .dataa(SLOT_STATE_0),
              .datab(Mux_a13291),
              .datac(Mux_a13326),
              .datad(Mux_a13288),
              .inverta( vss ),
              .combout(Mux_a13327) );

// atom is at LC_X9_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_f9ca Mux_a13257_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_a3_a),
              .datac(SLOT_STATE_0),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13257) );

// atom is at LC_X10_Y5_N7
lcell_stratix_on_sd_cx_c0x_c1x_05c0 Mux_a13258_I
            ( .dataa(Mux_a13257),
              .datab(Mux_a13233),
              .datac(SLOT_STATE_1),
              .datad(SLOT_STATE_2),
              .inverta( vss ),
              .combout(Mux_a13258) );

// atom is at LC_X10_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_2000 Mux_a13280_I
            ( .dataa(CRC_BLOCK_aLATCH_a2_a),
              .datab(SLOT_STATE_2),
              .datac(reduce_nor_a177),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13280) );

// atom is at LC_X10_Y5_N1
lcell_stratix_on_sd_cx_c0x_c1x_0311 Mux_a13281_I
            ( .dataa(reduce_nor),
              .datab(SLOT_STATE_2),
              .datac(reduce_nor_a177),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13281) );

// atom is at LC_X10_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_efa0 Mux_a13282_I
            ( .dataa(Mux_a13280),
              .datab(Mux_a13281),
              .datac(Mux_a13258),
              .datad(BYTE_LATCH_a1_a),
              .inverta( vss ),
              .combout(Mux_a13282) );

// atom is at LC_X10_Y5_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_ff80 BYTE_LATCH_a2_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13327),
              .datab(SLOT_STATE_2),
              .datac(Mux_a13258),
              .datad(Mux_a13282),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a2_a) );

// atom is at LC_X11_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_fdec Mux_a13277_I
            ( .dataa(Mux_a13276),
              .datab(Mux_a13235),
              .datac(LATCH_3),
              .datad(BYTE_LATCH_a2_a),
              .inverta( vss ),
              .combout(Mux_a13277) );

// atom is at LC_X11_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_fefc Mux_a13275_I
            ( .dataa(BYTE_LATCH_a2_a),
              .datab(Mux9),
              .datac(Mux10),
              .datad(Mux_a13274),
              .inverta( vss ),
              .combout(Mux_a13275) );

// atom is at LC_X11_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_e222 Mux_a13278_I
            ( .dataa(Mux_a13277),
              .datab(SLOT_STATE_2),
              .datac(SLOT_STATE_0),
              .datad(Mux_a13275),
              .inverta( vss ),
              .combout(Mux_a13278) );

// atom is at LC_X11_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_ffec Mux_a13265_I
            ( .dataa(Mux_a13264),
              .datab(Mux5),
              .datac(BYTE_LATCH_a2_a),
              .datad(Mux_a13261),
              .inverta( vss ),
              .combout(Mux_a13265) );

// atom is at LC_X12_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_faf0 Mux_a13268_I
            ( .dataa(BYTE_LATCH_61),
              .datac(Mux6),
              .datad(Mux7),
              .inverta( vss ),
              .combout(Mux_a13268) );

// atom is at LC_X12_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_a888 Mux_a13270_I
            ( .dataa(Mux3),
              .datab(Mux_a13265),
              .datac(Mux_a13324),
              .datad(Mux_a13268),
              .inverta( vss ),
              .combout(Mux_a13270) );

// atom is at LC_X10_Y5_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_fcac BYTE_LATCH_a3_a_aI
            ( .clk( not__CLK ),
              .dataa(Mux_a13278),
              .datab(BYTE_LATCH_a2_a),
              .datac(Mux_a13258),
              .datad(Mux_a13270),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a3_a) );

// atom is at LC_X9_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_f838 BYTE_LATCH_a4_a_a1521_I
            ( .dataa(BYTE_LATCH_4),
              .datab(BYTE_LATCH_62),
              .datac(BYTE_LATCH_a4_a_a1520),
              .datad(BYTE_LATCH_41),
              .inverta( vss ),
              .combout(BYTE_LATCH_a4_a_a1521) );

// atom is at LC_X10_Y5_N6
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_bbb8 BYTE_LATCH_a4_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a3_a),
              .datab(BYTE_LATCH_a6_a_a4948),
              .datac(BYTE_LATCH_a4_a_a1521),
              .datad(Mux_a13239),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a4_a) );

// atom is at LC_X10_Y5_N9
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_bbb8 BYTE_LATCH_a5_a_aI
            ( .clk( not__CLK ),
              .dataa(BYTE_LATCH_a4_a),
              .datab(BYTE_LATCH_a6_a_a4948),
              .datac(BYTE_LATCH_a5_a_a1519),
              .datad(Mux_a13239),
              .aclr( not__RESET ),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(BYTE_LATCH_a5_a) );

// atom is at LC_X12_Y4_N4
lcell_stratix_on_sd_cx_c0x_c1x_befc TX_STATE_a0_a_a3335_I
            ( .dataa(TX_STATE_a3_a),
              .datab(TX_STATE_2),
              .datac(TX_STATE_0),
              .datad(SLOT_STATE_0),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3335) );

// atom is at LC_X12_Y4_N5
lcell_stratix_on_sd_cx_c0x_c1x_cd01 TX_STATE_a0_a_a3336_I
            ( .dataa(TX_STATE_1),
              .datab(SLOT_STATE_1),
              .datac(TX_STATE_a0_a_a3335),
              .datad(Mux_a13233),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3336) );

// atom is at LC_X10_Y6_N7
lcell_stratix_on_sd_cx_c0x_c1x_0002 Mux_a13241_I
            ( .dataa(SLOT_STATE_2),
              .datab(TX_STATE_1),
              .datac(SLOT_STATE_1),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux_a13241) );

// atom is at LC_X8_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_3830 TX_STATE_a0_a_a3333_I
            ( .dataa(reduce_nor11),
              .datab(TX_STATE_a3_a),
              .datac(TX_STATE_0),
              .datad(reduce_nor_a12),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3333) );

// atom is at LC_X9_Y5_N2
lcell_stratix_on_sd_cx_c0x_c1x_bb05 TX_STATE_a0_a_a3334_I
            ( .dataa(TX_STATE_a3_a),
              .datab(reduce_nor1),
              .datac(reduce_nor),
              .datad(TX_STATE_a0_a_a3333),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3334) );

// atom is at LC_X10_Y6_N4
lcell_stratix_on_sd_cx_c0x_c1x_4ccc TX_STATE_a0_a_a3337_I
            ( .dataa(reduce_nor1),
              .datab(BYTE_LATCH_a6_a_a4928),
              .datac(safe_q_4),
              .datad(safe_q_3),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3337) );

// atom is at LC_X10_Y3_N4
lcell_stratix_on_sd_cx_c0x_c1x_fcee TX_STATE_a0_a_a3326_I
            ( .dataa(reduce_nor_a177),
              .datab(TX_STATE_2),
              .datac(reduce_nor2),
              .datad(TX_STATE_0),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3326) );

// atom is at LC_X8_Y5_N0
lcell_stratix_on_sd_cx_c0x_c1x_020e TX_STATE_a0_a_a3338_I
            ( .dataa(reduce_nor10),
              .datab(SLOT_STATE_0),
              .datac(TX_STATE_2),
              .datad(reduce_nor6),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3338) );

// atom is at LC_X9_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_aeee TX_STATE_a0_a_a3339_I
            ( .dataa(TX_STATE_a0_a_a3338),
              .datab(BYTE_LATCH_a6_a_a4933),
              .datac(BYTE_LATCH_a6_a_a4944),
              .datad(reduce_nor7),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3339) );

// atom is at LC_X9_Y5_N6
lcell_stratix_on_sd_cx_c0x_c1x_2e0c TX_STATE_a0_a_a3327_I
            ( .dataa(TX_STATE_0),
              .datab(SLOT_STATE_1),
              .datac(TX_STATE_a0_a_a3326),
              .datad(TX_STATE_a0_a_a3339),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3327) );

// atom is at LC_X10_Y6_N9
lcell_stratix_on_sd_cx_c0x_c1x_00ea TX_STATE_a0_a_a3340_I
            ( .dataa(TX_STATE_a0_a_a3337),
              .datab(TX_STATE_1),
              .datac(TX_STATE_a0_a_a3327),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a3340) );

// atom is at LC_X10_Y6_N6
lcell_stratix_on_sd_cx_c0x_c1x_ff13 TX_STATE_a0_a_a564_I
            ( .dataa(TX_STATE_a0_a_a3334),
              .datab(TX_STATE_a0_a_a3340),
              .datac(Mux_a13243),
              .datad(Mux),
              .inverta( vss ),
              .combout(TX_STATE_a0_a_a564) );

// atom is at LC_X8_Y5_N9
lcell_stratix_on_sd_cx_c0x_c1x_08c8 Mux_a13247_I
            ( .dataa(reduce_nor10),
              .datab(TX_STATE_1),
              .datac(TX_STATE_2),
              .datad(reduce_nor7),
              .inverta( vss ),
              .combout(Mux_a13247) );

// atom is at LC_X8_Y5_N8
lcell_stratix_on_sd_cx_c0x_c1x_a888 Mux_a13248_I
            ( .dataa(Mux1),
              .datab(Mux_a13247),
              .datac(reduce_nor1),
              .datad(Mux_a13243),
              .inverta( vss ),
              .combout(Mux_a13248) );

// atom is at LC_X8_Y5_N3
lcell_stratix_on_sd_cx_c0x_c1x_ff08 Mux_a13249_I
            ( .dataa(TX_STATE_a3_a),
              .datab(Mux_a13231),
              .datac(reduce_nor_a12),
              .datad(Mux_a13248),
              .inverta( vss ),
              .combout(Mux_a13249) );

// atom is at LC_X12_Y7_N5
lcell_stratix_on_sd_cx_c0x_c1x_2cec Mux_a13250_I
            ( .dataa(reduce_nor1),
              .datab(TX_STATE_1),
              .datac(TX_STATE_0),
              .datad(reduce_nor2),
              .inverta( vss ),
              .combout(Mux_a13250) );

// atom is at LC_X12_Y7_N3
lcell_stratix_on_sd_cx_c0x_c1x_000a Mux_a13251_I
            ( .dataa(Mux_a13250),
              .datac(TX_STATE_a3_a),
              .datad(TX_STATE_2),
              .inverta( vss ),
              .combout(Mux_a13251) );

// atom is at LC_X12_Y7_N9
lcell_stratix_on_sd_cx_c0x_c1x_0408 Mux_a13245_I
            ( .dataa(TX_STATE_2),
              .datab(TX_STATE_0),
              .datac(TX_STATE_a3_a),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13245) );

// atom is at LC_X12_Y7_N6
lcell_stratix_on_sd_cx_c0x_c1x_b100 Mux_a13246_I
            ( .dataa(TX_STATE_2),
              .datab(reduce_nor6),
              .datac(reduce_nor9),
              .datad(Mux_a13245),
              .inverta( vss ),
              .combout(Mux_a13246) );

// atom is at LC_X12_Y4_N3
lcell_stratix_on_sd_cx_c0x_c1x_0040 Mux_a13325_I
            ( .dataa(TX_STATE_a3_a),
              .datab(Mux24),
              .datac(TX_STATE_0),
              .datad(TX_STATE_1),
              .inverta( vss ),
              .combout(Mux_a13325) );

// atom is at LC_X12_Y4_N9
lcell_stratix_on_sd_cx_c0x_c1x_c000 Mux_a13320_I
            ( .dataa( vdd ),
              .datab(Mux_a13260),
              .datac(CRC_BLOCK_aLATCH_a0_a),
              .datad(TX_STATE_a3_a),
              .inverta( vss ),
              .combout(Mux_a13320) );

// atom is at LC_X12_Y4_N0
lcell_stratix_on_sd_cx_c0x_c1x_f5f4 Mux_a13321_I
            ( .dataa(TX_STATE_2),
              .datab(Mux27),
              .datac(Mux26),
              .datad(Mux_a13320),
              .inverta( vss ),
              .combout(Mux_a13321) );

// atom is at LC_X12_Y4_N7
lcell_stratix_on_sd_cx_c0x_c1x_8000 Mux_a13322_I
            ( .dataa(TX_STATE_1),
              .datab(reduce_nor_a177),
              .datac(CRC_BLOCK_aLATCH_a0_a),
              .datad(Mux_a13233),
              .inverta( vss ),
              .combout(Mux_a13322) );

endmodule
module CRC_81 ( BYTE_LATCH_7, safe_q_4, reduce_nor, TX_STATE_3, BYTE_LATCH_6, BYTE_LATCH_61, BYTE_LATCH_62, BYTE_LATCH_5, BYTE_LATCH_51, LINK_LATCH_4, BYTE_LATCH_2, Mux, BYTE_LATCH_0, BYTE_LATCH_64, CLK, CDU_EN, RESET_FPGA, devclrn, devpor, devoe, LATCH_7, BYTE_LATCH_63, BYTE_LATCH_52, BYTE_LATCH_4, LATCH_3, Mux1, LATCH_2, LATCH_1, Mux2, LATCH_0);
input BYTE_LATCH_7;
input safe_q_4;
input reduce_nor;
input TX_STATE_3;
input BYTE_LATCH_6;
input BYTE_LATCH_61;
input BYTE_LATCH_62;
input BYTE_LATCH_5;
input BYTE_LATCH_51;
input LINK_LATCH_4;
input BYTE_LATCH_2;
input Mux;
input BYTE_LATCH_0;
input BYTE_LATCH_64;
input CLK;
input CDU_EN;
input RESET_FPGA;
input devclrn;
input devpor;
input devoe;
output LATCH_7;
output BYTE_LATCH_63;
output BYTE_LATCH_52;
output BYTE_LATCH_4;
output LATCH_3;
output Mux1;
output LATCH_2;
output LATCH_1;
output Mux2;
output LATCH_0;
// atom is at LC_X10_Y4_N8
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_a55a LATCH_a7_a_aI
            ( .clk(CLK),
              .dataa(LATCH_7),
              .datac(BYTE_LATCH_7),
              .datad(LATCH_a6_a),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_7) );

// atom is at LC_X10_Y4_N3
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_b8cc LATCH_a6_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_62),
              .datab(BYTE_LATCH_61),
              .datac(LATCH_a5_a),
              .datad(BYTE_LATCH_64),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_63),
              .regout(LATCH_a6_a) );

// atom is at LC_X10_Y4_N5
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_b8cc LATCH_a5_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_51),
              .datab(BYTE_LATCH_5),
              .datac(LATCH_a4_a),
              .datad(BYTE_LATCH_64),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_52),
              .regout(LATCH_a5_a) );

// atom is at LC_X10_Y4_N6
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_fc11 LATCH_a4_a_aI
            ( .clk(CLK),
              .dataa(LINK_LATCH_4),
              .datab(BYTE_LATCH_6),
              .datac(LATCH_3),
              .datad(BYTE_LATCH_64),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(BYTE_LATCH_4),
              .regout(LATCH_a4_a) );

// atom is at LC_X10_Y6_N1
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_c480 LATCH_a3_a_aI
            ( .clk(CLK),
              .dataa(Mux),
              .datab(TX_STATE_3),
              .datac(LATCH_2),
              .datad(BYTE_LATCH_2),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux1),
              .regout(LATCH_3) );

// atom is at LC_X10_Y4_N0
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_9966 LATCH_a2_a_aI
            ( .clk(CLK),
              .dataa(BYTE_LATCH_7),
              .datab(LATCH_1),
              .datac( vdd ),
              .datad(LATCH_7),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_2) );

// atom is at LC_X10_Y4_N7
lcell_stratix_son_rof_pol_on_sq_cx_c0x_c1x_f780 LATCH_a1_a_aI
            ( .clk(CLK),
              .dataa(reduce_nor),
              .datab(safe_q_4),
              .datac(LATCH_0),
              .datad(BYTE_LATCH_0),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .sclr( vss ),
              .sload( vdd ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .combout(Mux2),
              .regout(LATCH_1) );

// atom is at LC_X10_Y4_N4
lcell_stratix_sof_rof_pol_on_sd_cx_c0x_c1x_0ff0 LATCH_a0_a_aI
            ( .clk(CLK),
              .dataa( vdd ),
              .datac(BYTE_LATCH_7),
              .datad(LATCH_7),
              .aclr(SHIFT_a0),
              .aload( vss ),
              .ena( vdd ),
              .inverta( vss ),
              .devclrn(devclrn),
              .devpor(devpor),
              .regout(LATCH_0) );

// atom is at LC_X10_Y4_N1
lcell_stratix_on_sd_cx_c0x_c1x_f3f3 SHIFT_a0_I
            ( .dataa( vdd ),
              .datab(RESET_FPGA),
              .datac(CDU_EN),
              .inverta( vss ),
              .combout(SHIFT_a0) );

endmodule
