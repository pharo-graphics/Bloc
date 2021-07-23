Class {
	#name : 'BlUnit',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-Units'
}

{ #category : 'instance creation' }
BlUnit class >> em [
	^ BlEmUnit uniqueInstance
]

{ #category : 'instance creation' }
BlUnit class >> percent [
	^ BlPercentUnit uniqueInstance
]

{ #category : 'instance creation' }
BlUnit class >> pt [
	^ BlPtUnit uniqueInstance
]

{ #category : 'instance creation' }
BlUnit class >> rem [
	^ BlRemUnit uniqueInstance
]

{ #category : 'accessing' }
BlUnit class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'comparing' }
BlUnit >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'comparing' }
BlUnit >> hash [
	^ self class hash
]

{ #category : 'accessing' }
BlUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ self subclassResponsibility
]
