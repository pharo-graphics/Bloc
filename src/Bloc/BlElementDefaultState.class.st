Class {
	#name : 'BlElementDefaultState',
	#superclass : 'BlElementUniqueState',
	#category : 'Bloc-Basic-State'
}

{ #category : 'testing' }
BlElementDefaultState >> matches: aSetOfStates [
	^ true
]

{ #category : 'printing' }
BlElementDefaultState >> printOn: aStream [
	aStream nextPutAll: 'default'
]

{ #category : 'accessing' }
BlElementDefaultState >> priority [
	^ 0
]
