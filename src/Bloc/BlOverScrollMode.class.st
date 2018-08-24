Class {
	#name : #BlOverScrollMode,
	#superclass : #Object,
	#classInstVars : [
		'always',
		'ifContentScrolls',
		'never'
	],
	#category : 'Bloc-Utilities - Scrolling Helpers'
}

{ #category : #accessing }
BlOverScrollMode class >> never [
	^ never ifNil: [ never := BlOverScrollNeverMode new ]
]
