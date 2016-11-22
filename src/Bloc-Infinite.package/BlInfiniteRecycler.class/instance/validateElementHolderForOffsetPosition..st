private - testing
validateElementHolderForOffsetPosition: anElementHolder
	"Checks whether a given element holder can be used for the provided position.
	Position is taken from element holder itself.
	Return true if anElementHolder matches the provided position, false otherwise.
	anElementHolder must not be nil"
	<return: #Boolean>
	self assert: anElementHolder isNotNil.
	
	anElementHolder isRemoved ifTrue: [ 
		^ anElementHolder isPreLayout
			ifTrue: [ true ]
			ifFalse: [ 
				self error: 'Can not validate removed element holder unless it is in pre layout mode!'.
				^ false ] ].
	
	(anElementHolder position < 1
		or: [ anElementHolder position > self controller dataSourceItemCount ])
			ifTrue: [
				SubscriptOutOfBounds
					signalFor: anElementHolder position
					lowerBound: 1
					upperBound: self controller dataSourceItemCount ].
	
	"we don't need to check type if it is pre-layout"
	self controller isPreLayout ifFalse: [
		| type |
		type := self controller itemTypeAt: anElementHolder position.
		type ~= anElementHolder itemType
			ifFalse: [ ^ false ] ].
	
	self controller hasStableIds
		ifTrue: [ ^ anElementHolder itemId = self controller itemIdAt: anElementHolder position ].
	
	^ true