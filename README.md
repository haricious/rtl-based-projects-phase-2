# Phase 02 — RTL Core Builds

Phase 2 is the bridge from basic RTL design into the reusable building blocks used by the locked Phase 3 projects.

## Progress

| Project | Status |
|---|---|
| 32-bit Parameterized ALU | ⬜ Not started |
| CPU Register Block | ⬜ Not started |
| Synchronous FIFO | ⬜ Not started |
| Gray Code Counter + CDC Basics | ⬜ Not started |
| UART TX/RX + Baud Generator | ⬜ Not started |

**Progress: 0 / 5 complete**

> Update each status only after the project is actually completed and verified.

## Projects

### 01 — 32-bit Parameterized ALU
Covers add/sub, logic operations, shifts hook, and compare.

**Becomes:** `alu` in the Phase 3 RV32I core.

### 02 — CPU Register Block
2-read / 1-write register block with `x0` fixed at zero.

**Becomes:** `regfile` in the Phase 3 projects.

### 03 — Synchronous FIFO
Covers FIFO storage, pointer wrap, full/empty detection, and simultaneous read/write behavior.

**Becomes:** `sync_fifo` in the Phase 3 UART subsystem.

### 04 — Gray Code Counter + CDC Basics
Covers Gray-coded pointers, synchronization, reset synchronization, and the core CDC concepts needed for the asynchronous FIFO boundary.

**Becomes:** CDC/pointer logic used by the Phase 3 UART subsystem.

### 05 — UART TX/RX + Baud Generator
Covers UART transmit/receive logic and baud-rate timing.

**Becomes:** `baud_gen`, `uart_tx`, and `uart_rx` in the Phase 3 UART subsystem.

## Verification Standard

Every Phase 2 build should have:

- synthesizable RTL
- a self-checking testbench
- a single PASS/FAIL result
- a short record of what was built and what broke
- synthesis inspection where required by the project

## Phase 2 → Phase 3

The Phase 2 modules are written with their Phase 3 names and parameters from the start so they can be reused rather than rewritten.