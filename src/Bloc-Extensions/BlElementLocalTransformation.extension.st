Extension { #name : #BlElementLocalTransformation }

{ #category : #'*Bloc-Extensions' }
BlElementLocalTransformation >> gtInspectorTransformationsIn: composite [
	<gtInspectorPresentationOrder: 0>
	
	^ self transformation
		gtInspectorTransformationsIn: composite
]
