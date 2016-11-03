calculating
alignLines: theLines within: anExtent
	| lastLine excessBreadth excessOffset |
	theLines
		ifEmpty: [ ^ self ].

	lastLine := theLines last.
	excessBreadth := (anExtent y - (lastLine breadth + lastLine startBreadth)) max: 0.
	excessOffset := 0.
	
	theLines do: [ :aLine |
		| extraBreadth lineLength lineBreadth allowedBounds origin alignment |
		extraBreadth := excessBreadth / theLines size.
		lineLength := aLine length.
		lineBreadth := aLine breadth.
		
		alignment := layout alignment.
		alignment := self orientation isHorizontal
			ifTrue: [ alignment ]
			ifFalse: [ 
				self direction isLeftToRight 
					ifTrue: [ alignment inverted ]
					ifFalse: [ alignment swap ] ].
		alignment := alignment directed: self direction.
	
		allowedBounds := 0 @ excessOffset extent: anExtent x @ (lineBreadth + extraBreadth).
		origin := alignment translate: (0 @ excessOffset extent: lineLength @ lineBreadth) in: allowedBounds.
		
		excessOffset := excessOffset + extraBreadth.
		aLine startLength: aLine startLength + origin x.
		aLine startBreadth: aLine startBreadth + origin y.
		
		self alignLine: aLine ]