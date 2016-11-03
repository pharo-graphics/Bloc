private
nodeUpdated: aNode
	| parentIndex parentNode |

	parentIndex := ((aNode queueIndex - 1) / 2) asInteger.
	parentNode := nodes at: parentIndex + 1.

	(parentIndex > 0 and: [ self hasHigherPriority: aNode than: parentNode ])
		ifTrue: [ self cascadeUp: aNode ]
		ifFalse: [ self cascadeDown: aNode ]