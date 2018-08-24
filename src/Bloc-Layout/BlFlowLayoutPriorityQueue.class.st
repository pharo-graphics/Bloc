Class {
	#name : #BlFlowLayoutPriorityQueue,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'totalSize',
		'nodes',
		'priorityBlock'
	],
	#category : 'Bloc-Layout-Flow-Utilities'
}

{ #category : #'instance creation' }
BlFlowLayoutPriorityQueue class >> priority: aPriorityBlock [
	^ self new
		priorityBlock: aPriorityBlock;
		yourself
]

{ #category : #converting }
BlFlowLayoutPriorityQueue >> asDictionary [
	| index lastPriority |
	index := 0.
	lastPriority := nil.
	
	^ (nodes collect: [ :node | 
			| key |
			key := node priority asString.
			node priority = lastPriority
				ifTrue: [
					index := index + 1.
					key := '[', index asString, '] ', key ]
				ifFalse: [ 
					lastPriority := node priority.
					index := 0 ].
			key -> node value	 ]) asOrderedDictionary
]

{ #category : #private }
BlFlowLayoutPriorityQueue >> cascadeDown: aNode [
	| finalQueueIndex newParentNode |
	finalQueueIndex := aNode queueIndex.
	newParentNode := nil.
	
	[ 
		| childLeftIndex childLeft childRightIndex |
		newParentNode := aNode.
		
		childLeftIndex := 2 * finalQueueIndex.
		
		(childLeftIndex > self size)
			ifTrue: [
				aNode queueIndex: finalQueueIndex.
				nodes at: finalQueueIndex put: aNode.
				^ self ].
		
		childLeft := nodes at: childLeftIndex.
		
		(self hasHigherPriority: childLeft than: newParentNode)
			ifFalse: [ newParentNode := childLeft ].
		
		childRightIndex := childLeftIndex + 1.
		childRightIndex <= self size ifTrue: [ 
			| childRight |
			childRight := nodes at: childRightIndex.
			(self hasHigherPriority: childRight than: newParentNode)
				ifFalse: [ newParentNode := childRight ] ].
		
		newParentNode == aNode
			ifFalse: [ 
				| index |
				nodes at: finalQueueIndex put: newParentNode.
				index := newParentNode queueIndex.
				newParentNode queueIndex: finalQueueIndex.
				finalQueueIndex := index	]
			ifTrue: [
				aNode queueIndex: finalQueueIndex.
				nodes at: finalQueueIndex put: aNode.
				^ self ].
	 ] repeat
]

{ #category : #private }
BlFlowLayoutPriorityQueue >> cascadeUp: aNode [
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
]

{ #category : #'add / remove' }
BlFlowLayoutPriorityQueue >> dequeue [
	"Removes node with highest priority"
	^ self remove: nodes first
]

{ #category : #'add / remove' }
BlFlowLayoutPriorityQueue >> enqueue: anObject [
	| priority node |
	priority := priorityBlock value: anObject.
	
	node := BlFlowLayoutPriorityQueueNode new.
	node value: anObject.
	node priority: priority.
	
	nodes add: node.
	
	totalSize := totalSize + 1.
	node insertionIndex: totalSize.
	node queueIndex: self size.
	
	self cascadeUp: node.

	^ node
]

{ #category : #'gt-inspector-extension' }
BlFlowLayoutPriorityQueue >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (composite table)
		title: 'Items';
		display: [ self asDictionary associations ];
		children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter new asTruncatedTextFrom: each value ];
		selectionPopulate: #selection 
			entitled: 'Open key'
			with: [ :table | (table rawSelection collect: #key) gtInspectorInterestingObject ];
		beMultiple;
		withSmalltalkSearch;
		send: [ :selection | 
			selection isNil 
			ifTrue:[nil]
			ifFalse:[ (selection size = 1) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ]];
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'
]

{ #category : #private }
BlFlowLayoutPriorityQueue >> hasHigherPriority: aNodeA than: aNodeB [

	^ aNodeA priority < aNodeB priority
		or: [ aNodeA priority = aNodeB priority
			and: [ aNodeA insertionIndex < aNodeB insertionIndex ] ]
]

{ #category : #initialization }
BlFlowLayoutPriorityQueue >> initialize [
	super initialize.
	
	nodes := OrderedCollection new.
	totalSize := 0
]

{ #category : #private }
BlFlowLayoutPriorityQueue >> nodeUpdated: aNode [
	| parentIndex parentNode |

	parentIndex := ((aNode queueIndex - 1) / 2) asInteger.
	parentNode := nodes at: parentIndex + 1.

	(parentIndex > 0 and: [ self hasHigherPriority: aNode than: parentNode ])
		ifTrue: [ self cascadeUp: aNode ]
		ifFalse: [ self cascadeDown: aNode ]
]

{ #category : #accessing }
BlFlowLayoutPriorityQueue >> priorityBlock: aPriorityBlock [

	self assert: priorityBlock isNil.

	priorityBlock := aPriorityBlock
]

{ #category : #'add / remove' }
BlFlowLayoutPriorityQueue >> remove: aNode [
	<return: #BlFlowLayoutPriorityQueueNode>
	
	| formerLastNode |
	
	(aNode queueIndex = self size)
		ifTrue: [ ^ nodes removeLast value ].

	formerLastNode := nodes last.
	self swap: aNode and: formerLastNode.
	nodes removeLast.
	
	self nodeUpdated: formerLastNode.
	^ aNode value
]

{ #category : #accessing }
BlFlowLayoutPriorityQueue >> size [
	^ nodes size
]

{ #category : #private }
BlFlowLayoutPriorityQueue >> swap: aNodeA and: aNodeB [
	| index |
	
	nodes at: aNodeA queueIndex put: aNodeB.
	nodes at: aNodeB queueIndex put: aNodeA.
	
	index := aNodeA queueIndex.
	aNodeA queueIndex: aNodeB queueIndex.
	aNodeB queueIndex: index
]

{ #category : #accessing }
BlFlowLayoutPriorityQueue >> top [
	^ nodes first
]
