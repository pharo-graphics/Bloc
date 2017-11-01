collecting nodes
nodesAt: aPoint in: aCollection
	| aParentPoint aLocalPoint |

	aParentPoint := self transformation inverseTransformPoint: aPoint.
	aLocalPoint := self element parentPointToLocal: aParentPoint.
	
	(self element containsPoint: aLocalPoint)
		ifTrue: [ aCollection addFirst: self ].
		
	self nodes reverseDo: [ :aNode | aNode nodesAt: aPoint in: aCollection ]