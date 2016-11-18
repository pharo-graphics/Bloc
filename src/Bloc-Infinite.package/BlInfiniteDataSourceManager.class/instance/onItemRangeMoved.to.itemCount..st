data source updates
onItemRangeMoved: aPositionStart to: aPositionEnd itemCount: anItemCount
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If start and end position are the same, nothing needs to be done"
	aPositionStart = aPositionEnd
		ifTrue: [ ^ false ].
		
	anItemCount > 1
		ifTrue: [ self error: 'Moving multiple items is not supported yet' ].

	"Register move command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeMove instance
		positionStart: aPositionStart
		itemCount: aPositionEnd
		payload: nil).

	^ pendingCommands size = 1