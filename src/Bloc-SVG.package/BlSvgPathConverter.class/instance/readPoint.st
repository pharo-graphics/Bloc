operations
readPoint
	" A path data permits specifying points without comma separator "
	| x y pos |
	self skipBlanksAndComma.
	pos := stream position.
	x := self nextNumber ifNil: [ ^ nil ].
	
	self skipBlanksAndComma.
	
	y := self nextNumber ifNil: [ stream position: pos. ^ nil ].
	
	^ x @ y