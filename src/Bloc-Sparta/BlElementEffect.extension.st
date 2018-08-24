Extension { #name : #BlElementEffect }

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyAfterOnSpartaCanvas: aSpartaCanvas for: anElement [
]

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
]

{ #category : #'*Bloc-Sparta' }
BlElementEffect >> applyEffectOnSpartaCanvas: anSpartaCanvas for: anElement around: aBlock [
	
	self applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement.
	aBlock value.
	self applyAfterOnSpartaCanvas: anSpartaCanvas for: anElement
]
