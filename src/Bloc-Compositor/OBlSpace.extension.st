Extension { #name : #OBlSpace }

{ #category : #'*Bloc-Compositor' }
OBlSpace >> fullPaintWithTransformOn: aCompositorPainter offset: anOffset [

	self layerHolder fullPaintWithTransformOn: aCompositorPainter offset: anOffset
]

{ #category : #'*Bloc-Compositor' }
OBlSpace >> hasCompositionLayer [

	^ self layerHolder hasCompositionLayer
]

{ #category : #'*Bloc-Compositor' }
OBlSpace >> wantsSeparateCompositingLayer [

	^ self layerHolder wantsSeparateCompositingLayer
]
