accessing
position
	| x y |
	self flag: 'Why is sdlWindow nil sometimes?'.
	sdlWindow ifNil: [ ^ 0@0 ].
	x := ByteArray new: ExternalType long byteSize.
	y := ByteArray new: ExternalType long byteSize.
	sdlWindow getPositionX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)