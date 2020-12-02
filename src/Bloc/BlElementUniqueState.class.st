Class {
	#name : #BlElementUniqueState,
	#superclass : #BlElementState,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Basic-State'
}

{ #category : #accessing }
BlElementUniqueState class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
