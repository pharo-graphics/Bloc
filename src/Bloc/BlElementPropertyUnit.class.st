Class {
	#name : #BlElementPropertyUnit,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'instance creation' }
BlElementPropertyUnit class >> em [
	^ BlElementPropertyEmUnit uniqueInstance
]

{ #category : #'instance creation' }
BlElementPropertyUnit class >> pt [
	^ BlElementPropertyPtUnit uniqueInstance
]

{ #category : #'instance creation' }
BlElementPropertyUnit class >> rem [
	^ BlElementPropertyRemUnit uniqueInstance
]

{ #category : #accessing }
BlElementPropertyUnit class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BlElementPropertyUnit >> resolveLengthForValue: aCurrentValueOrBlock parent: aParentValueOrBlock global: aGlobalValueOrBlock [
	<return: #Number>

	^ self subclassResponsibility
]
