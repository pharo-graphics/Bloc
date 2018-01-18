*Bloc-Extensions
gtInspectorCurrentTargetIn: composite
	<gtInspectorPresentationOrder: 15>
	
	(self target isKindOf: BlElement)
		ifTrue: [ (self currentTarget gtInspectorPreviewIn: composite) title: 'Current target' ]