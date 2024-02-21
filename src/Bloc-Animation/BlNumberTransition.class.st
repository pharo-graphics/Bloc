Class {
	#name : #BlNumberTransition,
	#superclass : #BlTransition,
	#instVars : [
		'by'
	],
	#category : #'Bloc-Animation-Animation'
}

{ #category : #accessing }
BlNumberTransition >> by: aNumber [

	by := aNumber
]

{ #category : #pulse }
BlNumberTransition >> valueForStep: aNumber [

	| aValue |
	aValue := (to - from) * aNumber + from.
	^ by
		ifNil: [ aValue ]
		ifNotNil: [ (aValue / by) floor * by ]
]
