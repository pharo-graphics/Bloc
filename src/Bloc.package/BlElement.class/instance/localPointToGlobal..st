geometry position convertion
localPointToGlobal: aPoint
	self parent ifNil: [ ^ self transform localPointToGlobal: aPoint ].
	 ^  self parent localPointToGlobal: (self transform localPointToGlobal: aPoint)