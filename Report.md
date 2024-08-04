<h1> Synthesis and Physical Design of GPRS Block </h1>

<h2> Introduction </h2>

Performing the synthesis and physical design steps for the General Packet Radio Service (GPRS) block used for data seurity.

- Process: 32nm (saed32)
- Voltage: 0.95V (ss0p95v)
- Temperature: 125°C (125c)

- HVT, LVT, RVT standard cell libraries
- Low power SRAM library
- NDM library

<h2> Synthesis </h2>

- Setting the link library and target library.
- Analysing and reading the RTL.
- Elborating
- Writing timing constraints.
- Mapping and optimization
- Performing the synthesis.
- Analysing the area, power and timing reports.
- Saving the netlist.

<h3> Elaborated design obtained </h3>

![image](https://github.com/user-attachments/assets/203985b3-8973-4dee-98cc-3919ec3b3db0)

<h3> Mapped and optimized design </h3>

![image](https://github.com/user-attachments/assets/a6948887-2009-4354-b499-0979d4bfa23a)

<h2> Physical design </h2>

- Floorplanning
- Placement
- CTS
- Routing
- DRC, LVS checks

<h3> Floorplanning </h3>
- Setting path, setting the link and target libraries.
- Reading netlist and sdc file
  
- Horizontal layers : M1, M3, M5, M7, M9.
- Vertical layers: M2, M4, M6, M8
- Creating Core and die area, uitilisation = 0.7.
- Providing offset of 5 for the.

  ![image](https://github.com/user-attachments/assets/f81d16e9-84dd-418e-acf3-f118ef305ba5)

- Port plaement

  Placing the ports between core area and die area with M5 and M6 layers.

  ![image](https://github.com/user-attachments/assets/ecb6ddac-b1f1-4f16-a8e2-18d509664e07)

- Macro placement

  Placing the macros with 10u spacing and outer keepout margins with offset values of 1.

  ![image](https://github.com/user-attachments/assets/cf642214-17bd-4ec5-a5d3-72bb79506db8)

  
- Power planning

  - Removing the existing pattern
  - Creating vss, vdd, gnd
  - Creating rings, vias
  - Establishing connections between maros and rings
  - Creating power grids
  - Connecting the standard cells to the grids

  ![image](https://github.com/user-attachments/assets/9a4f3b8c-8a1d-4e64-a98f-565c665063e5)

  Creating rails

  ![image](https://github.com/user-attachments/assets/85fc5917-42dd-4f17-af2c-916bdda44f66)

<h3> Placement </h3>

Fixing the macros, setting the local cell density value to 0.7, setting the fanout limit to 20, setting the minimum layer as M2 and maximum as M6.

Performing the coarse placement

![image](https://github.com/user-attachments/assets/e85f5387-f196-4024-8fd3-5988aab09380)

Legalizing the placement

![image](https://github.com/user-attachments/assets/5c488165-07b8-4a6f-815c-ef0521a326c4)

Optimizing the placement

![image](https://github.com/user-attachments/assets/109c7cf8-997f-40ab-9c44-ee0a46070909)

<h3> Clock Tree Synthesis </h3>

Setting the driving clocks, target skew to 0.05, selecting the invertors and buffers, building and optimizing the clock tree and hence observing the clock tree graph.

![image](https://github.com/user-attachments/assets/95b42241-c9ba-4e6a-9f36-caaa96ac5168)

Global timing report

![image](https://github.com/user-attachments/assets/2c61fb3e-d89e-4533-8330-2a3c6f72b65b)

<h3> Routing </h3>

Setting the minimum and maximum layers for routing as M2 and M6 respectively, performing the detailed routing and optimizing it.

![image](https://github.com/user-attachments/assets/fcd33155-d7c9-43c6-aff4-f1b0663621b4)

<h3> DRC checks </h3>

![image](https://github.com/user-attachments/assets/06dc50d2-b8c4-4b56-902f-feaaba702d54)

<h3> LVS checks </h3>

![image](https://github.com/user-attachments/assets/d69bb59d-69fb-4aef-acba-6725e230df95)

<h2> Conclusion </h2>

Carried out the synthesis and physical design steps using the ICC2 tool by Synopsys successfully.













