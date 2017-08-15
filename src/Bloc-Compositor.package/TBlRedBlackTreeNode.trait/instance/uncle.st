accessing
uncle
	"Return my uncle node. I have uncle if I have a grandparent which has left or right nodes
	Note: Always use #hasUncle before using me"
	<return: #TBlRedBlackTreeNode>
	| aGrandparent |
	
	self
		assert: [ self hasUncle ]
		description: [ 'I must have an uncle in order to return it' ].
		
	aGrandparent := self grandparent.
	
	^ self parent == aGrandparent left
		ifTrue: [ aGrandparent right ]
		ifFalse: [ aGrandparent left ]