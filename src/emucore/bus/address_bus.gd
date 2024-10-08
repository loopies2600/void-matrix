extends RefCounted
class_name AddressBus

#The Game Boy has a 16-bit address bus, which is used to address ROM, RAM, and I/O.
#
#Start	End	Description	Notes
#0000	3FFF	16 KiB ROM bank 00	From cartridge, usually a fixed bank
#4000	7FFF	16 KiB ROM Bank 01–NN	From cartridge, switchable bank via mapper (if any)
#8000	9FFF	8 KiB Video RAM (VRAM)	In CGB mode, switchable bank 0/1
#A000	BFFF	8 KiB External RAM	From cartridge, switchable bank if any
#C000	CFFF	4 KiB Work RAM (WRAM)	
#D000	DFFF	4 KiB Work RAM (WRAM)	In CGB mode, switchable bank 1–7
#E000	FDFF	Echo RAM (mirror of C000–DDFF)	Nintendo says use of this area is prohibited.
#FE00	FE9F	Object attribute memory (OAM)	
#FEA0	FEFF	Not Usable	Nintendo says use of this area is prohibited.
#FF00	FF7F	I/O Registers	
#FF80	FFFE	High RAM (HRAM)	
#FFFF	FFFF	Interrupt Enable register (IE)	

var rom_context : RomContext

func bus_read(address : int) -> int:
	if address <= 0x8000:
		return rom_context.rom_data[address]
	
	return 0
	
func bus_write(address : int, value : int) -> void:
	value = wrapi(value, 0, 256)
	
	if address <= 0x8000:
		rom_context.rom_data[address] = value
		return
