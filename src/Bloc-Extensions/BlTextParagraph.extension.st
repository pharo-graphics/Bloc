Extension { #name : #BlTextParagraph }

{ #category : #'*Bloc-Extensions' }
BlTextParagraph >> gtTextFor: aView [
	<gtView>
	self text isNil ifTrue: [ ^ aView empty ].
	^ self text gtTextFor: aView
]
