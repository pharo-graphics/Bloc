*Bloc-Extensions
gtInspectorCurrentTargetIn: composite
	<gtInspectorPresentationOrder: 15>
	
	(self currentTarget isKindOf: BlElement)
		ifTrue: [ (self currentTarget gtInspectorPreviewIn: composite) title: 'Current target' ]