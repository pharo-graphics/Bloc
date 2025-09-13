Class {
	#name : #BlFormSetBackground,
	#superclass : #BlAbstractImageBackground,
	#instVars : [
		'formSet'
	],
	#category : #'Bloc-Basic-Background'
}

{ #category : #'instance creation' }
BlFormSetBackground class >> formSet: aFormSet [

	^ self new
		formSet: aFormSet;
		yourself
]

{ #category : #comparing }
BlFormSetBackground >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].
	anotherObject opacity = self opacity ifFalse: [ ^ false ].
	^ anotherObject formSet = self formSet
]

{ #category : #accessing }
BlFormSetBackground >> formSet [

	^ formSet
]

{ #category : #accessing }
BlFormSetBackground >> formSet: aFormSet [

	formSet isNotNil
		ifTrue: [ (BlImmutableObjectChangeError object: self) signal ].
		
	formSet := aFormSet
]

{ #category : #accessing }
BlFormSetBackground >> height [

	^ formSet height
]

{ #category : #accessing }
BlFormSetBackground >> width [

	^ formSet width
]
