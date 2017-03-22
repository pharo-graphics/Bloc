events-processing
processEvent: anEvent using: defaultDispatcher
	
	(self isInSpaceArea: anEvent)
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].

	anEvent sentTo: eventHandler.
	
	"quick fix for issue #15 : 
	In morphic, if the drop event is mark as handled, the dragged window is removed"
	anEvent isDropEvent
		ifFalse: [ anEvent wasHandled: true ]