Extension { #name : #BlHost }

{ #category : #'*Bloc-Sparta' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 

	(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
		measureTextParagraph: aBlTextParagraph
]
