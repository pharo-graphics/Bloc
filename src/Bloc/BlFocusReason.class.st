Class {
	#name : 'BlFocusReason',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Space - Support'
}

{ #category : 'accessing' }
BlFocusReason class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlFocusReason class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
