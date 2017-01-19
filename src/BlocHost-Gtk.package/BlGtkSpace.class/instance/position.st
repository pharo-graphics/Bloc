accessing
position
	| x y |
	x := ByteArray new: ExternalType ulong byteSize.
	y := ByteArray new: ExternalType ulong byteSize.
	hostWindow primGetPositionX: x y: y.
	^ ( x unsignedLongAt: 1) @ (y unsignedLongAt: 1)