Extension { #name : #SpartaCanvas }

{ #category : #'*Bloc-Spec2' }
SpartaCanvas >> inspectionPreview: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Preview'>

	^ self asForm asElement inspectionPreview: aBuilder
]
