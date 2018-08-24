Extension { #name : #BlElementTransformation }

{ #category : #'*Bloc-Extensions' }
BlElementTransformation >> gtInspectorDecompositionIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ self matrix gtInspectorDecompositionIn: aComposite
]

{ #category : #'*Bloc-Extensions' }
BlElementTransformation >> gtInspectorMatrixIn: composite [
	<gtInspectorPresentationOrder: 1>
	
	self matrix
		gtInspectorMatrixIn: composite
]

{ #category : #'*Bloc-Extensions' }
BlElementTransformation >> gtInspectorTransformationsIn: composite [
		
	^ composite tree 
		title: 'Transformations' translated;
		rootsExpanded;
		display: [ self ];
		children: [ :each | {} ]
]
