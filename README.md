# EDA-Tools

Verilog Gate-Level Studio for hardware engineers.

**Manipulations**  - Manipulate and save the netlist.

**Reports** - Generate many helpfull reports on the netlist.

##Manipultaions

###Uppercase Library Gate Ports
With this manpulation you can fix common casing errors. It will upper case all ports for all library gaets.

###Remove Buffers
- You supply the buffer name and the buffer input port and the output port.
- The manpulation will remove the buffer from the netlist, and will do all the rewiring.
- Only non pass through buffers are removed

###Replace Library Gates
- You supply the old gate, new gate, and specify how ports should be replaced.
- The manpulation will replace the old gate with the new gate, and will do all the rewiring.

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

*This report generates a list of all the library gates in the netlist.
*For any of the gates we enusre to show all of its ports.

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
