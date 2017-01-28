private - accessing
mousePosition
	| x y |
	x := ByteArray new: ExternalType long byteSize.
	y := ByteArray new: ExternalType long byteSize.
	SDL2 mouseStateX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)