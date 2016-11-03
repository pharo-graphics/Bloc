accessing
position: aPoint
	position := aPoint.
	self hostSpace ifNotNil: [ :hw | 
			hw position = aPoint ifFalse: [ hw position: aPoint ] ]