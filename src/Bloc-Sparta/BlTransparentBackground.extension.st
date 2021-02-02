Extension { #name : #BlTransparentBackground }

{ #category : #'*Bloc-Sparta' }
BlTransparentBackground >> asSpartaPaintOn: aCanvas [
	^ aCanvas paint color: Color transparent
]
