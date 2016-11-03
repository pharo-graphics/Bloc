private
absoluteAlignment: isHorizontal
	(self alignment = BlGridAlignment undefined)
		ifFalse: [ ^ self alignment ].
	
	self hasWeight
		ifFalse: [ ^ isHorizontal
			ifTrue: [ BlGridAlignment start ]
			ifFalse: [ BlGridAlignment baseline ] ].
		
	^ BlGridAlignment fill