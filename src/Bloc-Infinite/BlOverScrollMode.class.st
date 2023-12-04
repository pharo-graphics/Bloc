Class {
	#name : 'BlOverScrollMode',
	#superclass : 'Object',
	#classInstVars : [
		'always',
		'ifContentScrolls',
		'never'
	],
	#category : 'Bloc-Infinite-Scrollable-Helpers',
	#package : 'Bloc-Infinite',
	#tag : 'Scrollable-Helpers'
}

{ #category : 'accessing' }
BlOverScrollMode class >> never [
	^ never ifNil: [ never := BlOverScrollNeverMode new ]
]
