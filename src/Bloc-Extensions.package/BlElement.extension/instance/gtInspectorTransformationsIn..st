*Bloc-Extensions
gtInspectorTransformationsIn: aComposite
	<gtInspectorPresentationOrder: 19>
	
	aComposite
		composite: [ :aTabbedComposite |
			aTabbedComposite title: 'Transformation'.
			(self transformation
				gtInspectorTransformationsIn: aTabbedComposite)
					title: 'Composition'.
			self transformation
				gtInspectorMatrixIn: aTabbedComposite.
			self transformation
				gtInspectorDecompositionIn: aTabbedComposite ].