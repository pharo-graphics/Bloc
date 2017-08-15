testing
hasUncle
	"Return true if I have a grandparent, false otherwise"
	<return: #Boolean>
	| aGrandparent |
	
	"no grandparent => no uncle"
	self hasGrandparent
		ifFalse: [ ^ self ].
		
	aGrandparent := self grandparent.
	
	^ self parent == aGrandparent left
		ifTrue: [ aGrandparent hasRight ]
		ifFalse: [ aGrandparent hasLeft ]