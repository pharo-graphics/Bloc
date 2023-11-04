Class {
	#name : #BlElementUniqueState,
	#superclass : #BlElementState,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Basic-State'
}

{ #category : 'accessing' }
BlElementUniqueState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
BlElementUniqueState >> type [
	"Return an object used to compare two states when adding to the collection of states in order to prevent
	elements from having duplicated states"
	<return: #Object>

	^ self class
]
