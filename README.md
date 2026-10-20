# MSC-FFT-TmSCM-rotator

Constant twiddle-factor multipliers for an MSC-FFT datapath, written in
SystemVerilog/Verilog. Each module replaces a general-purpose complex
multiplier with a fixed shift-and-add network built from shifts, additions,
and subtractions only.

All RTL uses 16-bit signed fixed-point inputs and outputs. Coefficients are
quantized as 12-bit signed Q1.11 values (1 sign bit and 11 fractional bits).

## Modules

| Module | File | Coefficients | `sel` | Notes |
| --- | --- | --- | --- | --- |
| `TW10` | `src/TW10.sv` | 0.7070 | 1 bit | Output is zero when `sel = 1` |
| `TW11_imag` | `src/TW11.sv` | 0.9238, 0.3828 | 2 bits | Imaginary part (negated output) |
| `TW12and13_imag` | `src/TW12.sv` | 0.9808, 0.5556, 0.1951, 0.8315 | 2 bits | Shared network for TW12/TW13 imaginary parts |
| `TW13_real` | `src/TW13.sv` | 0.9808, 0.5556, 0.1951, 0.8315 | 2 bits | Real part |
| `TW22_imag` | `src/TW22.v` | 0.9238, 0.3828 | 1 bit | Imaginary part (negated output) |
| `TW23_imag` | `src/TW23.v` | 0.9238, 0.3828 | 1 bit | Imaginary part (negated output) |
| `TW32_real` | `src/TW32.v` | 0.7070 | — | Fixed coefficient |

The exact `sel`-to-coefficient mapping and output scaling are defined in each
module.

## Simulation

Requires [Icarus Verilog](http://iverilog.icarus.com/).

```sh
./simulator.sh
```

or run the steps manually:

```sh
iverilog -o testbench.out src/tb_cm.sv src/TW10.sv
vvp testbench.out
```

The testbench (`src/tb_cm.sv`) applies 1000 random 16-bit inputs to `TW10`,
compares each result against a 12-bit Q1.11 quantized reference model, and
reports the RMSE. It also writes `u_TW10.vcd` (waveform) and `u_TW10.txt`
(per-sample results).

Only `TW10` is instantiated in the testbench. The other modules are present
but their instantiations are commented out.

## Notes

`s_s.sh`, `simulator_simple.sh`, `src/tb_cm_simple.sv`, and `VerilogSyns.ys`
refer to an earlier `const_multiplier` module that is no longer part of
`src/`. They are kept for reference and are not used by the current flow.

## License

MIT
