TOP = led_toggle
SRC = led_ctrl.vhd
PCF = pins.pcf

bitstream.bin: $(TOP).asc
	icepack $< $@

$(TOP).asc: $(TOP).json $(PCF)
	nextpnr-ice40 --up5k --package sg48 --json $(TOP).json --pcf $(PCF) --asc $@

$(TOP).json: $(SRC)
	yosys -m ghdl -p 'ghdl $(SRC) -e $(TOP); synth_ice40 -top $(TOP) -json $@'

flash: bitstream.bin
	mpremote cp bitstream.bin :
	mpremote cp main.py :
	mpremote reset

clean:
	rm -f *.json *.asc bitstream.bin

.PHONY: flash clean