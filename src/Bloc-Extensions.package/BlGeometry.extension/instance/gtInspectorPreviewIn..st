*Bloc-Extensions
gtInspectorPreviewIn: composite
	<gtInspectorPresentationOrder: 1>

	^ (self asElement
		background: (Color gray alpha: 0.4);
		border: (BlBorder builder paint: Color gray; width: 2; build))
			gtInspectorPreviewIn: composite