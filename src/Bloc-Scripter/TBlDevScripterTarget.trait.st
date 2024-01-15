"
I define common step target definitions.
"
Trait {
	#name : #TBlDevScripterTarget,
	#category : #'Bloc-Scripter-Scripter'
}

{ #category : #'targets - converting' }
TBlDevScripterTarget >> asBreadthFirstSearch [
	self target: (BlDevScripterBreadthFirstSearchEventTarget new target: self target)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> id: aBlElementId [
	self updateTarget: (BlDevScripterElementIdEventTarget new elementId: aBlElementId)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> id: aBlElementId index: anIndex [
	"Find the Nth element with a given index"
	self updateTarget: (BlDevScripterElementIdEventTarget new elementId: aBlElementId; index: anIndex)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onAllChildrenBreadthFirst [
	self updateTarget: (BlDevScripterAllChildrenBreadthFirstEventTarget new)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onBreadthFirstChildOfClass: aClass [
	self updateTarget: (BlDevScripterDeepChildOfClassEventTarget new elementClass: aClass)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildAt: aNumber [
	self updateTarget: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromBlock: anOneArgBlock [
	self updateTarget: (BlDevScripterBlockSelectorEventTarget new block: anOneArgBlock)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromMessage: aSymbol [
	self updateTarget: (BlDevScripterSelectorChildEventTarget new selector: aSymbol)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self id: aSymbol
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildOfClass: aClass [
	self updateTarget: (BlDevScripterElementClassEventTarget new elementClass: aClass)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onFocusProcessor [
	self updateTarget: (BlDevScripterFocusProcessorTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onModel [
	self updateTarget: (BlDevScripterModelTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onMouseProcessor [
	self updateTarget: (BlDevScripterMouseProcessorTarget new)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onNestedChild: anArray [
	self updateTarget: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onScripter [
	self updateTarget: (BlDevScripterAsTarget new)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onSelected: aBlock [
	self updateTarget: (BlDevScripterSelectFilterEventTarget new block: aBlock)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onSelf [
	self updateTarget: (BlDevScripterSelfEventTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onSpace [
	self updateTarget: (BlDevScripterSpaceTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onSpaceRoot [
	self updateTarget: (BlDevScripterSpaceRootTarget new)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onTarget: oneArgBlock [
	oneArgBlock value: self
]

{ #category : #'targets - text' }
TBlDevScripterTarget >> onTextAttributesAt: anIndex [
	self updateTarget: (BlDevScripterTextAttributesAtTarget new index: anIndex)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onWithAllChildrenBreadthFirst [
	self updateTarget: (BlDevScripterWithAllChildrenBreadthFirstEventTarget new)
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> target [
	<return: #BlDevScripterEventTarget>
	self explicitRequirement
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> target: aScripterEventTarget [
	self explicitRequirement
]

{ #category : #'targets - accessing and updating' }
TBlDevScripterTarget >> updateTarget: aScripterEventTarget [
	self target 
		ifNil: [ self target: aScripterEventTarget ]
		ifNotNil: [ :aTarget | aTarget updateUsing: aScripterEventTarget on: self ]
]
