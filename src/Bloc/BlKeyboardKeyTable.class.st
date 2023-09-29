Class {
	#name : #BlKeyboardKeyTable,
	#superclass : #Object,
	#category : #'Bloc-Universe'
}

{ #category : #initialization }
BlKeyboardKeyTable >> initialize: aMapDictionary withKeys: aMapArray [

	aMapArray pairsDo: [ :eachCode :eachKey |
		aMapDictionary at: eachCode put: eachKey copy ]
]

{ #category : #'api - converting' }
BlKeyboardKeyTable >> keyFromVirtualCode: aScanCode [

	^ self subclassResponsibility
]
