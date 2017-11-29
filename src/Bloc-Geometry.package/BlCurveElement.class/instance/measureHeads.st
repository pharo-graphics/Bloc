layout
measureHeads
	self hasFromHead
		ifTrue: [ self measureFromHead ].
		
	self hasToHead
		ifTrue: [ self measureToHead ]