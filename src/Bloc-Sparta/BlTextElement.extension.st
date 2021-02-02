Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	paragraph
		ifNil: [ ^ self ].
		
	paragraph containerExtent: self extent.
	paragraph selection: self selection.

	aCanvas clip
		by: (self geometry pathOnSpartaCanvas: aCanvas of: self)
		during: [
			paragraph
				drawHighlightsOnSpartaCanvas: aCanvas
				padding: self padding.

			aCanvas transform
				by: [ :t | t translateBy: self padding topLeft ]
				during: [ paragraph drawOn: aCanvas ].

			paragraph
				drawSelectionOnSpartaCanvas: aCanvas
				padding: self padding ]
]
