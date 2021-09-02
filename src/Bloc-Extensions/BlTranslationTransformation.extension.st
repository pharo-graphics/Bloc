Extension { #name : 'BlTranslationTransformation' }

{ #category : '*Bloc-Extensions' }
BlTranslationTransformation >> gtInspectorVectorIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ (self translation	gtInspectorPreviewIn: aComposite)
		title: 'Vector'
]
