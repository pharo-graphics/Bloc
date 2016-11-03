geometry position convertion
globalPointToLocal: aPoint
	self parent ifNil: [ ^ self transform globalPointToLocal: aPoint ].
	^  self parent globalPointToLocal: (self transform globalPointToLocal: aPoint)