Extension { #name : #TextColor }

{ #category : #'*Bloc-Text-Rope' }
TextColor >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"

	aBlText foreground: self color
]
