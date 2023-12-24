Class {
	#name : #BlOverScrollMode,
	#superclass : #Object,
	#classInstVars : [
		'always',
		'ifContentScrolls',
		'never'
	],
	#category : 'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #accessing }
BlOverScrollMode class >> never [
	^ never ifNil: [ never := BlOverScrollNeverMode new ]
]
