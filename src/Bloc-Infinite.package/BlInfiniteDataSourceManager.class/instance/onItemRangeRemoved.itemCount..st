data source updates
onItemRangeRemoved: aPositionStart itemCount: anItemCount
	"Return true if pending commands should be processed,
	otherwise false"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register remove command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeRemove instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: nil).
	existingCommandTypes addRemove.

	^ pendingCommands size = 1