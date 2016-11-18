data source updates
onItemRangeInserted: aPositionStart itemCount: anItemCount
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register add command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeAdd instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: nil).

	^ pendingCommands size = 1