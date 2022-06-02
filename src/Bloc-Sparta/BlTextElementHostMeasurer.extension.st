Extension { #name : #BlTextElementHostMeasurer }

{ #category : #'*Bloc-Sparta' }
BlTextElementHostMeasurer >> measureTextParagraph: aBlTextParagraph of: aTextElement [

	aTextElement isAttachedToSceneGraph
		ifTrue: [
			aTextElement space measureTextParagraph: aBlTextParagraph ]
		ifFalse: [
			(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
				measureTextParagraph: aBlTextParagraph ]

]
