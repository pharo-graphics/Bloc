Extension { #name : #BlPaint }

{ #category : #'*Bloc-Extensions' }
BlPaint >> gtInspectorPreviewIn: aComposite [
	<gtInspectorPresentationOrder: 5>

	aComposite sparta
		title: [ 'Preview' translated ];
		extent: [ 350@250 ];
		draw: [ :aCanvas |
			aCanvas transform during: [ :aTransform |
				aTransform translateBy: (aCanvas extent - (aCanvas extent / 1.5)) / 2.0.
				aTransform apply.
				aCanvas fill
					paint: (self copy matchExtent: (aCanvas extent / 1.5));
					path: (0@0 extent: (aCanvas extent / 1.5));
					draw. ] ]
]
