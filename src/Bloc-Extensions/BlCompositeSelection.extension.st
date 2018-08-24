Extension { #name : #BlCompositeSelection }

{ #category : #'*Bloc-Extensions' }
BlCompositeSelection >> gtInspectorSelectionGraphIn: aComposite [
	<gtInspectorPresentationOrder: 1> 
	
	^ selections gtInspectorSelectionGraphIn: aComposite
]

{ #category : #'*Bloc-Extensions' }
BlCompositeSelection >> gtInspectorSelectionListIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	
	^ selections gtInspectorSelectionListIn: aComposite
]
