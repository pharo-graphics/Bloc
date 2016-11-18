data source updates
onItemRangeChanged: aPositionStart itemCount: anItemCount payload: anObjectPayload
	"Enques a new update pending command.
	I am a part of public API and should be triggered by data source (directly or indirectly)
	when items are changed/updated (item's value, content, or value was replaced in-place).
	Return true if pending commands need to be processed, otherwise false.
	object payload is optional and may be nil"
	<return: #Boolean>

	"If no items where updated we do nothing"
	anItemCount < 1
		ifTrue: [ ^ false ].

	"Register update command"
	pendingCommands add: (self
		createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
		positionStart: aPositionStart
		itemCount: anItemCount
		payload: anObjectPayload).

	^ pendingCommands size = 1