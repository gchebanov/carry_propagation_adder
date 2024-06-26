fpga
====
```
version="Vivado v2018.2"
model="Xilinx Virtex UltraScale+"
device=xcvu3p-ffvc1517-3-e
TWO_CYCLE_ALU=1
```
 
| name          | flags  | clock period, ns | success freq, MHz | WNS    | LUT  | FF  |
|---------------|--------|------------------|------------------|--------|------|-----|
| picorev32_axi | cnt_lp | 1.311            |                  | -0.106 | 1107 | 801 |
| picorev32_axi | cnt_lp | 1.34             |                  | -0.024 | 1103 | 801 |
| picorev32_axi | cnt_lp | 1.36             | 735              | 0.021  | 1103 | 801 |
| picorev32_axi | cnt_lp | 1.42             | 704              | 0.057  | 1102 | 801 |
| picorev32_axi |        | 1.4              |                  | -0.199 | 969  | 682 |
| picorev32_axi |        | 1.47             |                  | -0.021 | 976  | 682 |
| picorev32_axi |        | 1.495            |                  | -0.148 | 970  | 682 |
| picorev32_axi |        | 1.515            | 660              | 0.103  | 976  | 682 |
| picorev32_axi |        | 1.535            | 651              | 0.072  | 978  | 682 |
| picorev32_axi |        | 1.58             | 633              | 0.045  | 972  | 682 |

That is about `11%` frequency improve, but we have not any counter increment among top critical path!
But obliviously default counter makes design timing's worse.

asic
====

```
version="openroad 2024-04-08"
PDK=ASAP7
```

picorev32+cnt_lp
================

Default settings: no mult/div and single cycle alu (`TWO_CYCLE_ALU=0`).

|               | units | syn0     | floorplan0 | place0    | cts0      | route0    | dfm0      | export0 | export1   |
|---------------|-------|----------|------------|-----------|-----------|-----------|-----------|---------|-----------|
| errors        |       | 0        | 0          | 0         | 0         | 0         | 0         | 0       | 0         |
| warnings      |       | 1        | 36         | 37        | 1036      | 1036      | 1036      | 1       | 35        |
| drvs          |       | ---      | 6139       | 24        | 24        | 24        | 0         | ---     | 187       |
| unconstrained |       | ---      | 307        | 307       | 307       | 307       | 307       | ---     | 307       |
| cellarea      | um^2  | 1449.558 | 1427.430   | 1545.010  | 1651.870  | 1651.870  | 1651.870  | ---     | 1651.870  |
| totalarea     | um^2  | ---      | 14462.000  | 14462.000 | 14462.000 | 14462.000 | 14462.000 | ---     | 14462.000 |
| utilization   | %     | ---      | 9.870      | 10.683    | 11.422    | 11.422    | 11.422    | ---     | 11.422    |
| peakpower     | mw    | ---      | 0.368      | 0.430     | 0.508     | 0.499     | 0.456     | ---     | 0.507     |
| leakagepower  | mw    | ---      | 0.001      | 0.002     | 0.002     | 0.002     | 0.002     | ---     | 0.002     |
| holdpaths     |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| setuppaths    |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| holdslack     | ns    | ---      | 0.039      | 0.039     | 0.030     | 0.029     | 0.029     | ---     | 0.029     |
| holdwns       | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| holdtns       | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| setupslack    | ns    | ---      | 22.005     | 23.427    | 23.417    | 23.410    | 23.485    | ---     | 23.395    |
| setupwns      | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| setuptns      | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| fmax          | Hz    | ---      | 333.900M   | 635.735M  | 631.795M  | 628.956M  | 659.959M  | ---     | 623.204M  |
| macros        |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| cells         |       | 11848    | 12615      | 13013     | 14795     | 14795     | 14795     | ---     | 14795     |
| registers     |       | 1716     | 1716       | 1716      | 1716      | 1716      | 1716      | ---     | 1716      |
| buffers       |       | ---      | 982        | 1275      | 3057      | 3057      | 3057      | ---     | 3057      |
| pins          |       | 409      | 409        | 409       | 409       | 409       | 409       | ---     | 409       |
| nets          |       | 12287    | 11272      | 11670     | 13452     | 13452     | 13452     | ---     | 13452     |
| vias          |       | ---      | ---        | ---       | ---       | 119467    | ---       | ---     | ---       |
| wirelength    | um    | ---      | ---        | ---       | ---       | 56238.000 | ---       | ---     | ---       |
| memory        | B     | 280.492M | 1016.145M  | 773.918M  | 826.430M  | 3.888G    | 1.496G    | 1.243G  | 2.140G    |
| exetime       | s     | 17.480   | 55.179     | 03:07.680 | 01:06.969 | 27:45.000 | 01:35.709 | 19.559  | 03:43.629 |
| tasktime      | s     | 28.675   | 56.543     | 03:09.053 | 01:08.365 | 27:46.452 | 01:37.251 | 21.362  | 03:45.235 |


picorev32
=========

|               | units | syn0     | floorplan0 | place0    | cts0      | route0    | dfm0      | export0 | export1   |
|---------------|-------|----------|------------|-----------|-----------|-----------|-----------|---------|-----------|
| errors        |       | 0        | 0          | 0         | 0         | 0         | 0         | 0       | 0         |
| warnings      |       | 0        | 36         | 37        | 1036      | 1036      | 1036      | 1       | 35        |
| drvs          |       | --       | 6065       | 0         | 10        | 0         | 0         | ---     | 203       |
| unconstrained |       | --       | 307        | 307       | 307       | 307       | 307       | ---     | 307       |
| cellarea      | um^2  | 1387.666 | 1366.180   | 1489.640  | 1588.740  | 1588.740  | 1588.740  | ---     | 1588.740  |
| totalarea     | um^2  | ---      | 13864.400  | 13864.400 | 13864.400 | 13864.400 | 13864.400 | ---     | 13864.400 |
| utilization   | %     | ---      | 9.854      | 10.744    | 11.459    | 11.459    | 11.459    | ---     | 11.459    |
| peakpower     | mw    | ---      | 0.380      | 0.438     | 0.510     | 0.501     | 0.458     | ---     | 0.509     |
| leakagepower  | mw    | ---      | 0.001      | 0.001     | 0.002     | 0.002     | 0.002     | ---     | 0.002     |
| holdpaths     |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| setuppaths    |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| holdslack     | ns    | ---      | 0.039      | 0.041     | 0.040     | 0.041     | 0.039     | ---     | 0.040     |
| holdwns       | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| holdtns       | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| setupslack    | ns    | ---      | 22.060     | 23.155    | 23.126    | 23.099    | 23.224    | ---     | 23.122    |
| setupwns      | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| setuptns      | ns    | ---      | 0.000      | 0.000     | 0.000     | 0.000     | 0.000     | ---     | 0.000     |
| fmax          | Hz    | ---      | 340.167M   | 541.938M  | 533.494M  | 526.171M  | 562.965M  | ---     | 532.487M  |
| macros        |       | ---      | 0          | 0         | 0         | 0         | 0         | ---     | 0         |
| cells         |       | 11385    | 12139      | 12548     | 14203     | 14203     | 14203     | ---     | 14203     |           
| registers     |       | 11385    | 1597       | 1597      | 1597      | 1597      | 1597      | ---     | 1597      |           
| buffers       |       | ---      | 918        | 1222      | 2877      | 2877      | 2877      | ---     | 2877      |
| pins          |       | 409      | 409        | 409       | 409       | 409       | 409       | ---     | 409       |           
| nets          |       | 11879    | 10887      | 11296     | 12951     | 12951     | 12951     | ---     | 12951     |           
| vias          |       | ---      | ---        | ---       | ---       | 114877    | ---       | ---     | ---       |
| wirelength    | um    | ---      | ---        | ---       | ---       | 56313.000 | ---       | ---     | ---       |
| memory        | B     | 283.199M | 998.434M   | 758.848M  | 809.613M  | 3.583G    | 1.441G    | 1.208G  | 2.066G    |
| exetime       | s     | 17.260   | 51.109     | 02:52.620 | 01:06.060 | 25:34.309 | 01:30.019 | 18.449  | 03:37.409 |
| tasktime      | s     | 28.274   | 52.455     | 02:53.978 | 01:07.457 | 25:35.780 | 01:31.514 | 20.204  | 03:39.071 |