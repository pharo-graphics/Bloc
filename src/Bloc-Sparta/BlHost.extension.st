Extension { #name : #BlHost }

{ #category : #'*Bloc-Sparta' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 

	self flag: #todo. "This is a feature expected from any BlHost but creates a dependency to Sparta."

	(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
		measureTextParagraph: aBlTextParagraph
]
