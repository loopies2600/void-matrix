extends RefCounted
class_name BitwiseUtil

# EXPECTS 16 bit value
static func endian_reverse(n : int) -> int:
	return ((n & 0xFF00) >> 8) | ((n & 0x00FF) << 8)
	
static func isBitEnabled(bitmask : int, flag : int) -> bool:
	return bitmask & flag != 0
	
static func setBit(bitmask : int, flag : int) -> int:
	bitmask = bitmask | flag
	return bitmask
	
static func unsetBit(bitmask : int, flag : int) -> int:
	bitmask = bitmask & ~flag
	return bitmask
