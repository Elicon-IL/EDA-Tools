# EDA-Tools

Verilog Gate-Level Studio for hardware engineers.

EDA-Tools is a user-friendly HW engineering studio comprising of an array of tools specially designed for performing reports and manipulation on Verilog gate-level netlists.

The current release of EDA-Tools is a 'generic' engineering tool – it operates without the need of loading a vendor library of cells. You can perform the manipulations and reports on 'semi-finished' designs and defer the decision on the technology and vendor - the tools are smart enough to differentiate between instances of modules and library gates without a loaded library.

Currently the following tools are available:

**Manipulations**  - Manipulate and save the netlist.

**Reports** - Generate many helpfull reports on the netlist.

##Manipulaions

###Uppercase Library Gate Ports
With this manipulation you can fix common casing errors. It will upper case all ports for all library gaets.

Uppercase Library Gate Ports Example - 
```
Source Netlist:

module main (clkin, rst_in, out);
input clkin , rst_in  ;
output out ;
  sec inst001(.clkin ( clkin ), .rst_in ( rst_in ), .out ( outwire ) );
  x_buf inst002 ( .i ( outwire ), .o ( out ) );
endmodule

module sec ( clkin, rst_in, out);
input clkin , rst_in  ;
output out ;
  x_buf inst002 ( .i ( clkin ), .o ( out ) );
  x_inv inst003 ( .i ( rst_in ), .o ( nc_wire ) );
endmodule
```
Netlist After Uppercase Manipulation:
```
module main ( clkin , rst_in , out );
input clkin , rst_in ;
output out ;
  sec inst001 ( .clkin ( clkin ) , .rst_in ( rst_in ) , .out ( outwire ) );
  x_buf inst002 ( .I ( outwire ) , .O ( out ) );
endmodule

module sec ( clkin , rst_in , out );
input clkin , rst_in ;
output out ;
  x_buf inst002 ( .I ( clkin ) , .O ( out ) );
  x_inv inst003 ( .I ( rst_in ) , .O ( nc_wire ) );
endmodule
```

###Remove Buffers
- You supply the buffer name and the buffer input port and the output port.
- The manipulation will remove the buffer from the netlist, and will do all the rewiring.
- Only non pass through buffers are removed

Remove Buffers Example - 
```
Source Netlist:

module top (clkin, rst_in, out);
input clkin , rst_in  ;
output out ;
	x_inv inst001 ( .i ( outwire ), .o ( clkout ) );
	x_buf inst002 ( .i ( clkout ), .o ( out ) );
	x_buf inst002 ( .i ( clkin ), .o ( outwire ) );
endmodule
```
Netlist After Remove Buffers Manipulation:
```
module top ( clkin , rst_in , out );
input clkin , rst_in ;
output out ;
	x_inv inst001 ( .i ( clkin ) , .o ( out ) );
endmodule
```

###Replace Library Gates
- You supply the old gate, new gate, and specify how ports should be replaced.
- The manipulation will replace the old gate with the new gate, and will do all the rewiring.

Replace Library Gates Example -
```
Source Netlist:

module top ( clkin , rst_in , out );
input clkin , rst_in ;
output out ;
	x_inv inst001 ( .i ( clkin ) , .o ( out ) );
endmodule
```
Netlist After Replace Library Gates Manipulation:
```
module top ( clkin , rst_in , out );
input clkin , rst_in ;
output out ;
	not inst001 ( .in ( clkin ) , .out ( out ) );
endmodule
```

##Reports

###Count Library Gates

- This report generates an accurate count of all the library gates within the module you choose.
- If you run it on the **top module** you will get an accurate count of all the libraray gates in the netlist

Report Example - 
```
//
// EDA Tools - Verilog Gate-Level Studio, Version 1.0.2.1 by Elicon
// Visit us here - http://www.elicon.biz/
//

==============================
Module                   Count
==============================

an2                       1135
aoi22                     4
i1                        1140
ic                        15
iobhc                     10
mx21                      1742
mx21i                     695
oai22                     1
or2                       779
or3                       4
or4                       7
xo2                       605
```

###List Library Gates

- This report generates a list of all the library gates in the netlist.
- For any of the gates we enusre to show all of its ports.

Report Example - 
```
//
// EDA Tools - Verilog Gate-Level Studio, Version 1.0.2.1 by Elicon
// Visit us here - http://www.elicon.biz/
//

module bd ( z , a );
module mx21 ( z , a , b , sb );
module b1 ( z , a );
module mx21i ( zn , a , b , sb );
module an2 ( z , a , b );
module an3 ( z , a , b , c );
module or2 ( z , a , b );
module oai211 ( c , b , a2 , a1 , zn );
module or3 ( c , b , a , z );
module por ( zn );
```


###List Physical Paths

This report generates a list of all **physical paths** for each module you specify.

Report Example - 
```
//
// EDA Tools - Verilog Gate-Level Studio, Version 1.0.2.1 by Elicon
// Visit us here - http://www.elicon.biz/
//

// Modules to list: x_lut4_0xff0c, x_lut4_0x6a5f

//
// x_lut4_0xff0c instances:
//
CDU/SCK_a1_I/tlib000001/tlib000004
// x_lut4_0xff0c has 1 instance

//
// x_lut4_0x6a5f instances:
//
CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000073
CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000074
CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella7/tlib000001/tlib000075
CDU/BITCOUNT_BLOCK/COUNT_rtl_0_aauto_generated_acounter_cella3/tlib000001/tlib000062
// x_lut4_0x6a5f has 4 instances
```

## Future Release
- Add support for vendor specific gate libraries
- Fanout report
- Floating inputs report
- Eliminate assign statements manipulation
- Remove open output gates manipulation

## Team

Developed by http://www.elicon.biz/
