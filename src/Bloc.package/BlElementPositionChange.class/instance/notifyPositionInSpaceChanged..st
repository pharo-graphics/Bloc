notifying
notifyPositionInSpaceChanged: anElement
	
	anElement children
		select: [ :aChild | aChild changes isPositionChanged not ]
		thenDo: [ :aChild |
			aChild onPositionInSpaceChanged.
			self notifyPositionInSpaceChanged: aChild ]