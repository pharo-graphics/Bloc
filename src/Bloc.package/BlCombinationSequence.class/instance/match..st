accessing
match: anEventBuffer
	| matches |
	self seqSize = anEventBuffer bufferSize ifFalse: [ ^ false ].
	matches := anEventBuffer events withIndexCollect: [ :evt :i | (self at: i) matchEvent: evt ].
	^ (matches includes: false) not