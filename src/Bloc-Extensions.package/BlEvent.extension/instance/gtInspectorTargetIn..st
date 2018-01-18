*Bloc-Extensions
gtInspectorTargetIn: composite
	<gtInspectorPresentationOrder: 15>
	
	(self target isKindOf: BlElement)
		ifTrue: [ (self target gtInspectorPreviewIn: composite) title: 'Target' ]