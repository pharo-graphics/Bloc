Class {
	#name : #BlNumberTransition,
	#superclass : #BlTransition,
	#instVars : [
		'by',
		'previousValue'
	],
	#category : #'Bloc-Animation-Animation'
}

{ #category : #pulse }
BlNumberTransition >> applyValue: aValue [

	previousValue = aValue ifTrue: [ ^ self ].
	previousValue := aValue.
	super applyValue: aValue
]

{ #category : #accessing }
BlNumberTransition >> by: aNumber [

	by := aNumber
]

{ #category : #pulse }
BlNumberTransition >> valueForStep: aDelta [

	| aValue |
	aValue := (to - from) * aDelta + from.
	^ by
		ifNil: [ aValue ]
		ifNotNil: [ (aValue / by) floor * by ]
]
