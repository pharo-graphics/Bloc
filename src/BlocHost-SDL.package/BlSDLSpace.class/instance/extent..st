accessing
extent: newExtent
	self extent ~= newExtent
		ifTrue: [ sdlWindow setSizeW: newExtent x h: newExtent y ].
	renderer resized