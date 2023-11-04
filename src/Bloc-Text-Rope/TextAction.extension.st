Extension { #name : #TextAction }

{ #category : #'*Bloc-Text-Rope' }
TextAction >> applyToBlText: aBlText [

	self class = TextAction
		ifTrue: [ aBlText onClick: actOnClickBlock ]
		ifFalse: [ super applyToBlText: aBlText ]
]
