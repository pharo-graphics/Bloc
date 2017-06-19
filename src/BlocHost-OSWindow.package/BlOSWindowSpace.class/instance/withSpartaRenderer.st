initialization
withSpartaRenderer
	| surface |

	renderer := BlSpartaRenderer for: self.

	surface := BlHostRendererFormSurface new.
	surface hostSpace: self.
	surface hostRenderer: renderer.

	renderer surface: surface.
	
	osWindowRenderer := window newBlocRenderer surface: surface