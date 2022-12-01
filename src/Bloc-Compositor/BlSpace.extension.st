Extension { #name : #BlSpace }

{ #category : #'*Bloc-Compositor' }
BlSpace >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [

	self root fullPaintWithTransformOn: aCompositorPainter offset: anOffset
]

{ #category : #'*Bloc-Compositor' }
BlSpace >> hasCompositionLayer [

	^ self root hasCompositionLayer
]

{ #category : #'*Bloc-Compositor' }
BlSpace >> wantsSeparateCompositingLayer [

	^ self root wantsSeparateCompositingLayer
]
