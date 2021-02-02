Extension { #name : #BlElementEffect }

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyAfterOnSpartaCanvas: aSpartaCanvas for: anElement [
]

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
]

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyEffectOnSpartaCanvas: aSpartaCanvas for: anElement around: aBlock [
	
	self applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement.
	aBlock value: aSpartaCanvas.
	self applyAfterOnSpartaCanvas: aSpartaCanvas for: anElement
]
