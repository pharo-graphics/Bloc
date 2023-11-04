Extension { #name : #BlText }

{ #category : #'*Bloc-Spec2' }
BlText >> inspectionPreview: aBuilder [
	"<inspectorPresentationOrder: 1 title: 'Preview'>"

	^ self asElement inspectionPreview: aBuilder
]
