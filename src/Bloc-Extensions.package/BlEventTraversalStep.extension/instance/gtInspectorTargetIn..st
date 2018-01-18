*Bloc-Extensions
gtInspectorTargetIn: composite
	<gtInspectorPresentationOrder: 11>
	
	(self target isKindOf: BlElement)
		ifTrue: [ (self target gtInspectorPreviewIn: composite) title: 'Target' ]