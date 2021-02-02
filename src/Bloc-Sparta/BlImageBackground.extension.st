Extension { #name : #BlImageBackground }

{ #category : #'*Bloc-Sparta' }
BlImageBackground >> asSpartaPaintOn: aCanvas [
	^ aCanvas paint form: self image
]
