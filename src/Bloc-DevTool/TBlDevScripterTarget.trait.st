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
	self updateTarget: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildFromMessage: aSymbol [
	self updateTarget: (BlDevScripterSelectorChildEventTarget new selector: aSymbol)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildFromSelectionBlock: anOneArgBlock [
	self updateTarget: (BlDevScripterBlockSelectorEventTarget new block: anOneArgBlock)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self updateTarget: (BlDevScripterNamedChildEventTarget new name: aSymbol)
]

{ #category : #accessing }
TBlDevScripterTarget >> onElementOfClass: aClass [
	self updateTarget: (BlDevScripterElementClassEventTarget new elementClass: aClass)
]

{ #category : #accessing }
TBlDevScripterTarget >> onNestedChild: anArray [
	self updateTarget: (BlDevScripterNestedChildEventTarget new targetSequence: anArray)
]

{ #category : #accessing }
TBlDevScripterTarget >> onSelf [
	self updateTarget: (BlDevScripterSelfEventTarget new)
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

{ #category : #accessing }
TBlDevScripterTarget >> updateTarget: aScripterEventTarget [
	self target 
		ifNil: [ self target: aScripterEventTarget ]
		ifNotNil: [ :aTarget | aTarget updateUsing: aScripterEventTarget on: self ]
]
