# EDA-Tools

Verilog Gate-Level Studio for hardware engineers.

**Reports** - Generate many helpfull reports on the netlist.

**Manipulations**  - Manipulate and save the netlist.

##Reports

###Count Library Gates

This report generates an accurate count of all the library gates within the module you choose.

If you run it on the **top module** you will get an accurate count of all the libraray gates in the netlist

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

This report generates a list of all the library gates in the netlist.

For any of the gates we enusre to show all of its ports.

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
