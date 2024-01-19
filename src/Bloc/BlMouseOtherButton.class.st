"
I represent all other mouse buttons that are not primary, middle or context.
Nowadays there can be any number of mouse buttons, we have to support them

"
Class {
	#name : 'BlMouseOtherButton',
	#superclass : 'BlMouseButton',
	#instVars : [
		'code'
	],
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'instance creation' }
BlMouseOtherButton class >> code: aNumber [
	^ self new code: aNumber
]

{ #category : 'comparing' }
BlMouseOtherButton >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].

	^ anotherObject code = self code
]

{ #category : 'accessing' }
BlMouseOtherButton >> code [
	"Return a numerical (integer) code of this mouse button"
	<return: #Number>

	^ code
]

{ #category : 'accessing' }
BlMouseOtherButton >> code: aNumber [

	self
		assert: [ code isNil ]
		description: [ 'Mouse button is immutable, create a new instance with the code' ].

	code := aNumber
]

{ #category : 'comparing' }
BlMouseOtherButton >> hash [
	^ self class hash bitXor: self code hash
]
