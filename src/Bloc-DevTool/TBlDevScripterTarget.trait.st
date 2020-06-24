"
I define common step target definitions.
"
Trait {
	#name : #TBlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'targets - converting' }
TBlDevScripterTarget >> asBreadthFirstSearch [
	self target: (BlDevScripterBreadthFirstSearchEventTarget new target: self target)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildAt: aNumber [
	self updateTarget: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromMessage: aSymbol [
	self updateTarget: (BlDevScripterSelectorChildEventTarget new selector: aSymbol)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildFromSelectionBlock: anOneArgBlock [
	self updateTarget: (BlDevScripterBlockSelectorEventTarget new block: anOneArgBlock)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self updateTarget: (BlDevScripterNamedChildEventTarget new name: aSymbol)
]

{ #category : #'targets - children' }
TBlDevScripterTarget >> onChildOfClass: aClass [
	self updateTarget: (BlDevScripterElementClassEventTarget new elementClass: aClass)
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
TBlDevScripterTarget >> onSelf [
	self updateTarget: (BlDevScripterSelfEventTarget new)
]

{ #category : #'targets - other' }
TBlDevScripterTarget >> onSpace [
	self updateTarget: (BlDevScripterSpaceTarget new)
]

{ #category : #'targets - text' }
TBlDevScripterTarget >> onTextAttributesAt: anIndex [
	self updateTarget: (BlDevScripterTextAttributesAtTarget new index: anIndex)
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
