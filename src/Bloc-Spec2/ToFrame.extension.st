Extension { #name : #ToFrame }

{ #category : #'*Bloc-Spec2' }
ToFrame >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ self root inspectionPreview: aBuilder
]

{ #category : #'*Bloc-Spec2' }
ToFrame >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Tree'>

	^ self root inspectionTree: aBuilder
]
