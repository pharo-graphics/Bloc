private
dispatchAndUpdateElementHolders: aCommand
	| tmpStart tmpCnt offsetPositionForPartial positionMultiplier payload|
	tmpStart := self updatePosition: aCommand positionStart withPostponed: aCommand.
	tmpCnt := 1.
	offsetPositionForPartial := aCommand positionStart.
	positionMultiplier := aCommand positionMultiplier.
	
	1 to: aCommand itemCount - 1 do: [ :p |
		| pos updatedPos |
		pos := aCommand positionStart + (positionMultiplier * p).
		updatedPos := self updatePosition: pos withPostponed: aCommand.
		(aCommand continuous: updatedPos start: tmpStart)
			ifTrue: [ tmpCnt := tmpCnt + 1 ]
			ifFalse: [ 
				| tmpCommand |
				tmpCommand := aCommand class new
					positionStart: tmpStart;
					itemCount: tmpCnt;
					payload: aCommand payload.
				
				self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial.
				self recycleCommand: tmpCommand.
				
				aCommand isUpdate ifTrue: [ 
					offsetPositionForPartial := offsetPositionForPartial + tmpCnt ].
				tmpStart := updatedPos.
				tmpCnt := 1 ] ].

	payload := aCommand payload.
	self recycleCommand: aCommand.
	
	tmpCnt > 0 ifTrue: [ 
		|tmpCommand|
		tmpCommand := aCommand class
			positionStart: tmpStart;
			itemCount: tmpCnt;
			payload: payload.
		self dispatchFirstPassAndUpdateElementHolders: tmpCommand offset: offsetPositionForPartial.
		self recycleCommand: tmpCommand ].