Extension { #name : #BlRopedText }

{ #category : #'*Bloc-Spec2' }
BlRopedText >> inspectionForRope: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Rope tree'>
	
	^ rope inspectionForStructure: aBuilder
]
