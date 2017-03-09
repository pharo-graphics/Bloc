accessing
positionAt: anIndex
	| lineFound lineIndex spans spanFound spanIndex offset indexLeft  |
	lineFound := false.
	lineIndex := 0.

	indexLeft := anIndex.
	
	indexLeft <= 0 ifTrue: [ ^ SpTextPosition none ].
	
	[ lineFound or: [ lineIndex >= lines size ] ] whileFalse: [ 
		lineIndex := lineIndex + 1.
		indexLeft <= (lines at: lineIndex) length
			ifTrue: [ lineFound := true ]
			ifFalse: [ indexLeft := indexLeft - (lines at: lineIndex) length ] ].
	
	lineFound ifFalse: [ ^ SpTextPosition none ].
	
	spanFound := false.
	spanIndex := 0.
	spans := (lines at: lineIndex) spans.
	[ spanFound or: [ spanIndex >= spans size ] ] whileFalse: [ 
		spanIndex := spanIndex + 1.
		indexLeft <= (spans at: spanIndex) length
			ifTrue: [ spanFound := true ]
			ifFalse: [ indexLeft := indexLeft - (spans at: spanIndex) length ] ].
		
	spanFound ifFalse: [ ^ SpTextPosition none ].
	
	offset := indexLeft.
	
	^ SpTextPosition line: lineIndex span: spanIndex offset: offset