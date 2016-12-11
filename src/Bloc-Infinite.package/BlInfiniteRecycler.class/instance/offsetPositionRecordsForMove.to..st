accessing - position
offsetPositionRecordsForMove: aStartPosition to: anEndPosition
	| start end inBetweenOffset |

	aStartPosition < anEndPosition
		ifTrue: [ 
			start := aStartPosition.
			end := anEndPosition.
			inBetweenOffset := -1 ]
		ifFalse: [ 
			start := anEndPosition.
			end := aStartPosition.
			inBetweenOffset := 1 ].
	
	cachedScrap
		select: [ :aHolder | (aHolder position < start or: [ aHolder position > end ]) ]
		thenDo: [ :aHolder |
			aHolder position = aStartPosition
				ifTrue: [ aHolder offsetPositionBy: anEndPosition - aStartPosition applyToPreLayout: false ]
				ifFalse: [ aHolder offsetPositionBy: inBetweenOffset applyToPreLayout: false ] ]