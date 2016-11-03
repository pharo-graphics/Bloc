as yet unclassified
updateAll
	self validate ifFalse: [ ^ self ].
	texture updateTexturePixels: sdlSurface pixels pitch: sdlSurface pitch.