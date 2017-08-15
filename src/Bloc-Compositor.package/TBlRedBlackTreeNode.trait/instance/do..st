tree - enumerating
do: aBlock
	self hasLeft
		ifTrue: [ self left do: aBlock ].
		
	aBlock value: self.
	
	self hasRight
		ifTrue: [ self right do: aBlock ]