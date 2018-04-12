*Bloc-Extensions
gtInspectorSelectionListIn: aComposite
	<gtInspectorPresentationOrder: 0> 
	
	^ aComposite fastList
		title: 'Selections (List)';
		display: [ Array streamContents: [ :aStream | self do: [ :aSelection | aStream nextPut: aSelection ] ] ]