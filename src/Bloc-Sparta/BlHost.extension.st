Extension { #name : #BlHost }

{ #category : #'*Bloc-Sparta' }
BlHost >> containsPoint: aPoint element: aBlElement geometry: aBlGeometry [

	^ aBlGeometry
		  containsPoint: aPoint
		  in: aBlElement
		  on: Bloc preferableSpartaCanvas offscreen
]

{ #category : #'*Bloc-Sparta' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 

	(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
		measureTextParagraph: aBlTextParagraph
]
