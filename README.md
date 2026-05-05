# Contenerized FPGA Development Environment for Pico2ICE
This development environment is created to work with [pico2ice](https://pico2-ice.tinyvision.ai/index.html) board.

It utilizes Docker to build a workflow based on open-source toolbox [oss-cad-suite from YosysHQ](https://github.com/yosyshq/oss-cad-suite-build).

## Usage
### Building
The only prequisity is the Docker itself.

In order to build run:

```bash
docker compose up --build -d
```

Then you can run the container and mount it wherever, like:

```bash
PROJECT_DIR=$(pwd)/led_toggle docker compose run --rm oss_cad_suite
```

**Important:** be quick and plug your board as you type the second command, since it the device has to be mounted as the container starts up!

### Development
I included inside `led_toggle/` a sample VHDL project with the workflow encapsulated within a Makefile.

Once the design is complete run:

```bash
make flash
```

To synthesize, implement and FLASH the bitstream into the board. In this example Micropython is used to load it according to this [example](https://pico2-ice.tinyvision.ai/md_mpy.html).

Once done the board should light up green and after pressing the button 4 times an LED should toggle on and off interchangeably.

The sample `*.pcf` file was inspired by [this one](https://github.com/tinyvision-ai-inc/pico-ice-sdk/blob/main/rtl/pico_ice.pcf).

### Future work

- An example of a custom firmware doing the same thing
- Potentially extending the container to incorporated  [pico-ice sdk](https://github.com/tinyvision-ai-inc/pico-ice-sdk)
- Introduce more robust Makefile and demonstrate the usage of other tools which are part of OSS-CAD Suite

## Acknowledgements
This project was prepared based on the [following work](https://github.com/davidsiaw/yosys-docker). I did only a handful of modifications, like:

- increased parallel thread count inside `install.sh`
- added `/workspace`
- set the container to run the terminal session on a startup
- prepared `compose.yaml` with a customizable mount point for the `/workspace`