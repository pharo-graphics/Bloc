accessing
extent
	| w h |
	w := ByteArray new: ExternalType long byteSize.
	h := ByteArray new: ExternalType long byteSize.
	sdlWindow getSizeW: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)