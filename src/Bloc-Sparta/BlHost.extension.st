Extension { #name : #BlHost }

{ #category : #'*Bloc-Sparta' }
BlHost >> containsPoint: aPoint element: aBlElement geometry: aBlGeometry [

	self flag: #todo. "This is a feature expected from any BlHost but creates a dependency to Sparta."

	^ aBlGeometry
		  containsPoint: aPoint
		  in: aBlElement
		  onSpartaCanvas: Bloc preferableSpartaCanvas offscreen
]

{ #category : #'*Bloc-Sparta' }
BlHost >> offscreenMeasureTextParagraph: aBlTextParagraph [ 

	self flag: #todo. "This is a feature expected from any BlHost but creates a dependency to Sparta."

	(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
		measureTextParagraph: aBlTextParagraph
]

{ #category : #'*Bloc-Sparta' }
BlHost >> visualBoundsOf: aBlElement [

	self flag: #todo. "This is a feature expected from any BlHost but creates a dependency to Sparta."

	^ Bloc hasSparta
		ifTrue: [ aBlElement visualBoundsOn: (Bloc preferableSpartaCanvas offscreen) ]
		ifFalse: [ aBlElement geometryBounds ]
]
