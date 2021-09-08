Extension { #name : 'TextEmphasis' }

{ #category : '*Bloc-Text-Rope' }
TextEmphasis >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"

	(emphasisCode anyMask: 1) ifTrue: [ aBlText bold ].
	(emphasisCode anyMask: 2) ifTrue: [ aBlText italic ].
	(emphasisCode anyMask: 4) ifTrue: [ aBlText underlined ].
	(emphasisCode anyMask: 8) ifTrue: [ aBlText narrow ].
	(emphasisCode anyMask: 16) ifTrue: [ aBlText struckOut ].

]
