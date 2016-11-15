private
postponeOn: aContext start: aStartPosition count: anItemCount
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: nil.
	aContext postponeAndUpdateElementHolders: newCommand.