as yet unclassified
dataSourcePositionOf: anElementHolder
	<return: #Number>
	
	(anElementHolder flags hasInvalid or: [
		anElementHolder flags hasRemoved or: [ 
			anElementHolder flags hasDataSourcePositionUnknown or: [
				anElementHolder isBound not ] ] ])
		ifTrue: [ ^ NoPosition ].
		
	^ self dataSourceManager applyPendingCommandsOnPosition: anElementHolder position