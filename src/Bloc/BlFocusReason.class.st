Class {
	#name : 'BlFocusReason',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#package : 'Bloc',
	#tag : 'Space - Support'
}

{ #category : 'accessing' }
BlFocusReason class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlFocusReason class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
