Class {
	#name : #BlKeyboardKeyTable,
	#superclass : #Object,
	#category : #'Bloc-Universe'
}

{ #category : #initialization }
BlKeyboardKeyTable >> initialize: aMapDictionary with: aMapArray [
	aMapArray pairsDo: [ :eachCode :eachName |
		| aName |
		
		aName := (BlKeyboardKey respondsTo: eachName)
			ifTrue: [ eachName ]
			ifFalse: [ (BlKeyboardKey respondsTo: eachName uncapitalized)
				ifTrue: [ eachName uncapitalized ]
				ifFalse: [ #unknown ] ].

		aMapDictionary at: eachCode put: ((BlKeyboardKey perform: aName) setValue: eachCode) ]
]

{ #category : #initialization }
BlKeyboardKeyTable >> initialize: aMapDictionary withKeys: aMapArray [
	aMapArray pairsDo: [ :eachCode :eachKey |
		aMapDictionary at: eachCode put: (eachKey copy) ]
]

{ #category : #'api - converting' }
BlKeyboardKeyTable >> keyFromVirtualCode: aScanCode [
	<return: #BlKeyboardKey>

	^ self subclassResponsibility
]
