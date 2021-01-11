Extension { #name : #BlTextElementHostMeasurer }

{ #category : #'*Bloc-Sparta' }
BlTextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	self flag: #TODO.
	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space
				measureTextParagraph: aBlTextParagraph
				ifNotAvailable: [
					(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
						measureTextParagraph: aBlTextParagraph ] ]
		ifFalse: [
			(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
				measureTextParagraph: aBlTextParagraph ]
]
