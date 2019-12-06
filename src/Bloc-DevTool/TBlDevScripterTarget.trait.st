Trait {
	#name : #TBlDevScripterTarget,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
TBlDevScripterTarget >> onChildAt: aNumber [
	self target: (BlDevScripterIndexedChildEventTarget new index: aNumber)
]

{ #category : #accessing }
TBlDevScripterTarget >> onChildNamed: aSymbol [
	self target: (BlDevScripterNamedChildEventTarget new name: aSymbol)
]

{ #category : #accessing }
TBlDevScripterTarget >> onSelf [
	self target: (BlDevScripterSelfEventTarget new)
]

{ #category : #accessing }
TBlDevScripterTarget >> target: aScripterEventTarget [
	self explicitRequirement
]
