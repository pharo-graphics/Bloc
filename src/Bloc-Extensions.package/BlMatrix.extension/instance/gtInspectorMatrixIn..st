*Bloc-Extensions
gtInspectorMatrixIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	^ aComposite bloc
		title: 'Matrix' translated;
		display: [ GLMBlocMatrixElement new matrix: self asMatrixCollection ]