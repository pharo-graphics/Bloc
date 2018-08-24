Extension { #name : #BlGeometry }

{ #category : #'*Bloc-Extensions' }
BlGeometry >> gtInspectorLiveIn: composite [
	<gtInspectorPresentationOrder: 1>

	^ self asElement gtInspectorLiveIn: composite
]
