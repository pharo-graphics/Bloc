as yet unclassified
globalMousePosition
	"| x y |
	x := ByteArray new: 4.
	y := ByteArray new: 4.
	SDL2 globalMouseStateX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)"
	^ hostSpace position + self mousePosition