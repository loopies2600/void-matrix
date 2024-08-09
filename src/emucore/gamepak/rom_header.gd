extends RefCounted
class_name RomHeader

const NINTENDO_LOGO : PackedByteArray = [206, 237, 102, 102, 204, 13, 0, 11, 3, 115, 0, 131, 0, 12, 0, 13, 0, 8, 17, 31, 136, 137, 0, 14, 220, 204, 110, 230, 221, 221, 217, 153, 187, 187, 103, 99, 110, 14, 236, 204, 221, 220, 153, 159, 187, 185, 51, 62]

var entry_point : PackedByteArray = [0x0, 0xC3, 0x50, 0x01]
var logo : PackedByteArray

var title : StringName
var new_lic_code : int
var cgb_flag : int
var sgb_flag : int
var type : int
var rom_size : int
var ram_size : int
var dest_code : int
var old_lic_code : int
var version : int
var checksum : int
var global_checksum : int

func as_text() -> String:
	var header_string := ""
	
	header_string += title
	
	header_string += "\nRom type: " + RomConstants.ROM_TYPES[type]
	header_string += "\nGame Boy Color enhanced: " + str(cgb_flag == 0x80)
	header_string += "\nSuper Game Boy enhanced: " + str(sgb_flag == 0x03)
	header_string += "\nROM size: " + str(rom_size) + " bytes"
	header_string += "\nEmbedded RAM size: " + str(ram_size) + " bytes"
	
	var destination := "World"
	
	if dest_code == 0x00:
		destination = "Japan"
	
	header_string += "\nDestination: " + destination
	
	return header_string
	
static func check_nintendo_logo(tile_data : PackedByteArray) -> bool:
	if tile_data == NINTENDO_LOGO:
		return true
	
	return false
