# TCP Three-Way Handshake Simulation using Verilog

## Project Overview
This project implements a **TCP three-way handshake** using **Finite State Machines (FSMs)** in Verilog. The design includes separate FSMs for the **client** and **server** sides, modeling the connection initiation process. A testbench verifies the simulation, demonstrating the TCP handshake sequence.

## Table of Contents
- [Architecture](#architecture)
  - [Client FSM](#client-fsm)
  - [Server FSM](#server-fsm)
- [Verilog Code](#verilog-code)
- [Simulation](#simulation)
- [Acknowledgments](#acknowledgments)

## Architecture
The system is designed with two **Moore Finite State Machines (FSMs)**:

### Client FSM
![image](https://github.com/user-attachments/assets/63e0f59e-3007-429a-8820-7c9238a67a03)

- **States:**
  - `IDLE_HOLD_C` (Initial State)
  - `SYN_SENT` (Sending SYN packet)
  - `ESTABLISHED_C` (Connection established)
- **Transitions:**
  - Initiates connection upon receiving a control signal.
  - Waits for **SYN-ACK** from the server.
  - Sends **ACK** to complete the handshake.

### Server FSM
![image](https://github.com/user-attachments/assets/3d04e23c-986f-4c48-856b-777692efff8b)

- **States:**
  - `IDLE_HOLD_S` (Waiting for SYN)
  - `SYN_RECEIVED` (Received SYN, sending SYN-ACK)
  - `ESTABLISHED_S` (Connection established)
- **Transitions:**
  - Waits for **SYN** from the client.
  - Sends **SYN-ACK** upon reception of SYN.
  - Moves to established state upon receiving ACK.

## Verilog Code
The project consists of the following Verilog modules:
- **Client Side:** Implements the client-side FSM, handling SYN and ACK signals.
- **Server Side:** Implements the server-side FSM, handling SYN, SYN-ACK, and ACK signals.
- **TCP Module:** Integrates the client and server FSMs to simulate a TCP connection.
- **Testbench:** Provides a test environment to verify the handshake process.

## Simulation
- The **client starts** in `IDLE_HOLD_C` state.
- Upon receiving a control signal, it **sends a SYN packet**.
- The **server receives SYN** and transitions to `SYN_RECEIVED`, sending SYN-ACK.
- The **client receives SYN-ACK**, transitions to `ESTABLISHED_C`, and **sends ACK**.
- The **server receives ACK** and transitions to `ESTABLISHED_S`, completing the handshake.

## Acknowledgments
This project is part of the **Digital System Design (CE325)** course at **Habib University**, instructed by **Dr. Arsalan Javed**.

---
**Contributors:** Sadiqah Mushtaq
```
