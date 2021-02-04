Extension { #name : #BlCompositeBackground }

{ #category : #'*Bloc-Sparta' }
BlCompositeBackground >> asSpartaPaintOn: aCanvas [
	"We do not yet support composite backgrounds"

	^ aCanvas paint color: Color transparent
]
