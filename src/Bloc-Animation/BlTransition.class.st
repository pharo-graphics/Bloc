Class {
	#name : #BlTransition,
	#superclass : #BlAnimation,
	#instVars : [
		'from',
		'to',
		'stepAction'
	],
	#category : 'Bloc-Animation-Animation'
}

{ #category : #pulse }
BlTransition >> applyValue: aValue [

	self stepAction valueWithEnoughArguments: { aValue. self target }
]

{ #category : #accessing }
BlTransition >> from [

	^ from
]

{ #category : #accessing }
BlTransition >> from: anObject [

	from := anObject
]

{ #category : #accessing }
BlTransition >> onStepDo: aBlock [

	stepAction := aBlock
]

{ #category : #accessing }
BlTransition >> stepAction [

	^ stepAction
]

{ #category : #accessing }
BlTransition >> to [

	^ to
]

{ #category : #accessing }
BlTransition >> to: anObject [

	to := anObject
]
