"
I extend the mutable rectangular bounds with a cache mechanism.
"
Class {
	#name : #BlCachedBounds,
	#superclass : #BlBounds,
	#instVars : [
		'isValid'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #copying }
BlCachedBounds >> copy [
	"We assume sender just wants simple bounds"

	^ BlBounds
		  left: left
		  top: top
		  right: right
		  bottom: bottom
]

{ #category : #validation }
BlCachedBounds >> ensureValidWith: factoryBlock [

	(isValid isNotNil and: [ isValid ]) ifTrue: [ ^ self ].

	factoryBlock value: self.

	isValid := true
]

{ #category : #initialization }
BlCachedBounds >> initialize [

	super initialize.
	
	isValid := false
]

{ #category : #validation }
BlCachedBounds >> invalidate [

	isValid := false
]
