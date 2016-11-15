private
dispatchOn: aContext start: aStartPosition count: anItemCount payload: anObject
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: anObject.
	aContext dispatchAndUpdateElementHolders: newCommand.