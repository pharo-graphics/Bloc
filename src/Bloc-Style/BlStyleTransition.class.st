"
to be removed ?
"
Class {
	#name : #BlStyleTransition,
	#superclass : #BlStyle,
	#category : 'Bloc-Style-Util'
}

{ #category : #accessing }
BlStyleTransition >> transition [
	^ declaration
]

{ #category : #accessing }
BlStyleTransition >> transition: anObject [
	declaration := anObject
]
