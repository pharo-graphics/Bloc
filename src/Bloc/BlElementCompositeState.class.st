Class {
	#name : 'BlElementCompositeState',
	#superclass : 'BlElementState',
	#instVars : [
		'left',
		'right'
	],
	#category : 'Bloc-Basic-State'
}

{ #category : 'comparing' }
BlElementCompositeState >> = anotherState [
	anotherState == self
		ifTrue: [ ^ true ].
		
	anotherState species == self species
		ifFalse: [ ^ false ].
		
	^ self left = anotherState left
		and: [ self right = anotherState right ]
]

{ #category : 'comparing' }
BlElementCompositeState >> hash [
	^ (self class hash bitXor: self left hash) bitXor: self right hash
]

{ #category : 'accessing' }
BlElementCompositeState >> left [
	^ left
]

{ #category : 'accessing' }
BlElementCompositeState >> left: anObject [
	left := anObject
]

{ #category : 'testing' }
BlElementCompositeState >> matches: aSetOfStates [
	^ self subclassResponsibility
]

{ #category : 'enumerating' }
BlElementCompositeState >> optionalEventHandlerDo: aBlock [
	left optionalEventHandlerDo: aBlock.
	right optionalEventHandlerDo: aBlock
]

{ #category : 'accessing' }
BlElementCompositeState >> priority [
	^ left priority max: right priority
]

{ #category : 'accessing' }
BlElementCompositeState >> right [
	^ right
]

{ #category : 'accessing' }
BlElementCompositeState >> right: anObject [
	right := anObject
]

{ #category : 'accessing' }
BlElementCompositeState >> type [
	"Composition state can not be element state, so this method should not be implemented"
	<return: #Object>

	^ self shouldNotImplement
]
