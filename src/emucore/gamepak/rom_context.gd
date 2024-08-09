extends RefCounted
class_name RomContext

var filename : String
var rom_size : int
var rom_data : PackedByteArray
var header : RomHeader = RomHeader.new()

func rom_get_license() -> StringName:
	if header.new_lic_code <= 0xA4:
		return RomConstants.LICENSE_CODES[header.new_lic_code]
	
	return RomConstants.LICENSE_CODES[0x00]
	
func rom_get_type() -> StringName:
	if header.type <= 0x22:
		return RomConstants.ROM_TYPES[header.type]
	
	return "UNKNOWN"
	
func compute_checksum(rom_data : PackedByteArray, base_checksum : int) -> bool:
	var checksum : int = 0
	
	var address : int = 0x0134
	
	while address <= 0x014C:
		checksum = checksum - rom_data[address] - 1
		checksum = wrapi(checksum, 0, 256)
		
		address += 1
	
	if base_checksum == checksum:
		return true
	
	return false
	
func load_rom(path : String):
	var rom_file := FileAccess.open(path, FileAccess.READ)
	
	filename = path
	rom_data = rom_file.get_buffer(rom_file.get_length())
	rom_size = rom_file.get_length()
	
	rom_file.close()
	
	for i in range(0x0104, 0x0134):
		header.logo.push_back(rom_data[i])
	
	var is_gb_rom : bool = RomHeader.check_nintendo_logo(header.logo)
	
	if not is_gb_rom:
		return
	
	var title_chars : PackedByteArray = []
	
	for i in range(0x134, 0x144):
		title_chars.push_back(rom_data[i])
	
	header.title = title_chars.get_string_from_ascii()
	header.cgb_flag = rom_data[0x143]
	header.sgb_flag = rom_data[0x146]
	header.type = rom_data[0x147]
	header.rom_size = 32000 * (1 << rom_data[0x148])
	header.ram_size = RomConstants.RAM_SIZES[rom_data[0x149]]
	header.dest_code = rom_data[0x14A]
	header.checksum = rom_data[0x14D]
	
	if not compute_checksum(rom_data, header.checksum):
		return
