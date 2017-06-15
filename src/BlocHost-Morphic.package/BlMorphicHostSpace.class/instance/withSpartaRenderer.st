instance creation
withSpartaRenderer
	| surface |
	renderer := BlSpartaRenderer for: self.

	surface := BlHostRendererFormSurface new.
	surface hostSpace: self.
	surface hostRenderer: renderer.

	renderer surface: surface