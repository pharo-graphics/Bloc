private
cascadeUp: aNode
	| parentIndex |
	parentIndex := (aNode queueIndex / 2) asInteger.
	
	"self halt."
	[ parentIndex >= 1 ] whileTrue: [ 
		| parentNode |
		parentNode := nodes at: parentIndex.
		(self hasHigherPriority: parentNode than: aNode)
			ifFalse: [ ^ self ].
		self swap: aNode and: parentNode.
		parentIndex := (aNode queueIndex / 2) asInteger ]