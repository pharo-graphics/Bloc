testing
partiallyMatch: anEventBuffer
	|matches|
	self seqSize < anEventBuffer bufferSize ifTrue:[^ false].
	matches := anEventBuffer events withIndexCollect: [ :evt :i | (self at:i) matchEvent: evt ].
	^ (matches includes:false) not