*Bloc-Extensions
gtInspectorSelectionGraphIn: aComposite
	<gtInspectorPresentationOrder: 1> 
	
	self hasRoot
		ifTrue: [ self root gtInspectorSelectionGraphIn: aComposite ]