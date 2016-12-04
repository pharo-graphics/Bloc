private - commands
consumePendingDataSourceCommands
	"I help to reflect data changes to the state.
	DataSource changes during a scroll may trigger a crash because scroll assumes no data change but data actually changed.
	I consume all deferred changes to avoid that case."

	(firstLayoutComplete not or: [ dataSourceChangedAfterLayout ])
		ifTrue: [ ^ self dispatchLayout ].
	
	dataSourceManager hasPendingCommands
		ifFalse: [ ^ self ].

	"if it is only an item change (no add-remove-move) we can check
	if any of the visible items is affected and if not, just ignore the change."
	dataSourceManager hasOnlyUpdateCommand
		ifTrue: [ 
			self eatRequestLayout.
			dataSourceManager preProcessCommands.
			layoutRequestEaten ifFalse: [ 
				self hasUpdatedChild
					ifTrue: [ self dispatchLayout ]
					"no need to layout, clean state"
					ifFalse: [ dataSourceManager consumePostponedCommands ] ].
			self resumeRequestLayout: true ]
		ifFalse: [
			 dataSourceManager hasPendingCommands
				ifTrue: [ self dispatchLayout ] ]