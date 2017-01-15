rendering
present
	self validate ifFalse: [ ^ self ].
	sdlRenderer
		clear;
		copy: texture;
		present