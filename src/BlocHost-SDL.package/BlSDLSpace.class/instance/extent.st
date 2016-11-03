accessing
extent
	| w h |
	w := ByteArray new: 4.
	h := ByteArray new: 4.
	sdlWindow getSizeW: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)