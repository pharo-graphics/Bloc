Extension { #name : 'BlMatrixDecomposition' }

{ #category : '*Bloc-Extensions' }
BlMatrixDecomposition >> gtInspectorCompositionIn: aComposite [
	<gtInspectorPresentationOrder: 9>
	
	^ (self composition gtInspectorMatrixIn: aComposite)
		title: 'Recomposition'
]

{ #category : '*Bloc-Extensions' }
BlMatrixDecomposition >> gtInspectorDecompositionIn: aComposite [
	<gtInspectorPresentationOrder: 9>
	
	^ (self asDictionary gtInspectorItemsIn: aComposite)
		title: 'Decomposition'
]
