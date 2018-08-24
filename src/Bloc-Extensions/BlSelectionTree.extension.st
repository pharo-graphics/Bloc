Extension { #name : #BlSelectionTree }

{ #category : #'*Bloc-Extensions' }
BlSelectionTree >> gtInspectorSelectionGraphIn: aComposite [
	<gtInspectorPresentationOrder: 1> 
	
	self hasRoot
		ifTrue: [ self root gtInspectorSelectionGraphIn: aComposite ]
]

{ #category : #'*Bloc-Extensions' }
BlSelectionTree >> gtInspectorSelectionListIn: aComposite [
	<gtInspectorPresentationOrder: 0> 
	
	^ aComposite fastList
		title: 'Selections (List)';
		display: [ Array streamContents: [ :aStream | self do: [ :aSelection | aStream nextPut: aSelection ] ] ]
]
