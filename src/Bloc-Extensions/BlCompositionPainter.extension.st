Extension { #name : #BlCompositionPainter }

{ #category : #'*Bloc-Extensions' }
BlCompositionPainter >> gtLayersTreeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Layers';
		priority: 2;
		object: [ self containerLayer ];
		view: #gtTreeFor:
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPainter >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 3;
		stencil: [
			| aCanvas aSkiaLayer aCompositor |
			
			aCanvas := SkiaCanvas extent: self bounds extent ceiling asIntegerPoint.
			aSkiaLayer := self containerLayer asSkiaLayer.
			
			aCompositor := SkiaCompositor new.
			
			aCompositor draw: aSkiaLayer on: aCanvas.
			aCanvas asForm ]
]

{ #category : #'*Bloc-Extensions' }
BlCompositionPainter >> gtSymbolTreeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Tree Print';
		priority: 4;
		object: [ self containerLayer ];
		view: #gtSymbolTreeFor:
]
