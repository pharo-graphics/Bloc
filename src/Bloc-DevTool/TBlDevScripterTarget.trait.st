Trait {
	#name : #TBlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #converting }
TBlDevScripterTarget >> asBreadthFirstSearch [
	self target: (BlDevScripterBreadthFirstSearchEventTarget new target: self target)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildAt: aNumber [
	self target: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildFromMessage: aSymbol [
	self target: (BlDevScripterSelectorChildEventTarget new selector: aSymbol)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildFromSelectionBlock: anOneArgBlock [
	self target: (BlDevScripterBlockSelectorEventTarget new block: anOneArgBlock)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self target: (BlDevScripterNamedChildEventTarget new name: aSymbol)
]

{ #category : #accessing }
TBlDevScripterTarget >> onElementOfClass: aClass [
	self target: (BlDevScripterElementClassEventTarget new elementClass: aClass)
]

{ #category : #accessing }
TBlDevScripterTarget >> onNestedChild: anArray [
	self target: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #accessing }
TBlDevScripterTarget >> onSelf [
	self target: (BlDevScripterSelfEventTarget new)
]

{ #category : #accessing }
TBlDevScripterTarget >> target [
	<return: #BlDevScripterEventTarget>
	self explicitRequirement
]

{ #category : #accessing }
TBlDevScripterTarget >> target: aScripterEventTarget [
	self explicitRequirement
]
