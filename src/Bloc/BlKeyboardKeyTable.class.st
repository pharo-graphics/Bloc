Class {
	#name : 'BlKeyboardKeyTable',
	#superclass : 'Object',
	#package : 'Bloc',
	#tag : 'Universe'
}

{ #category : 'initialization' }
BlKeyboardKeyTable >> initialize: aMapDictionary withKeys: aMapArray [

	aMapArray pairsDo: [ :eachCode :eachKey |
		aMapDictionary at: eachCode put: eachKey copy ]
]

{ #category : 'api - converting' }
BlKeyboardKeyTable >> keyFromVirtualCode: aScanCode [

	^ self subclassResponsibility
]
