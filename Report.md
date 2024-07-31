<h1> Synthesis and Physical Design of GPRS Block </h1>

<h2> Introduction </h2>

Performing the synthesis and physical design steps for the General Packet Radio Service (GPRS) block used for data seurity.

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

- Reading netlist and sdc file
  
- Creating Core and die area
  Providing offset of 5 for the boundaries.

  ![image](https://github.com/user-attachments/assets/f81d16e9-84dd-418e-acf3-f118ef305ba5)

- Port plaement
  Placing the ports between core area and die area with M5 and M6 layers.

  ![image](https://github.com/user-attachments/assets/ecb6ddac-b1f1-4f16-a8e2-18d509664e07)

- Macroplacement
  Placing the macros with 10u spacing and outer keepout margins with offset values of 1.

  ![image](https://github.com/user-attachments/assets/cf642214-17bd-4ec5-a5d3-72bb79506db8)

  
- Power planning
  Creating stripes, rings, maro pin connections.

  ![image](https://github.com/user-attachments/assets/9a4f3b8c-8a1d-4e64-a98f-565c665063e5)

  Creating rails

  ![image](https://github.com/user-attachments/assets/85fc5917-42dd-4f17-af2c-916bdda44f66)

  <h3> Placement </h3>





