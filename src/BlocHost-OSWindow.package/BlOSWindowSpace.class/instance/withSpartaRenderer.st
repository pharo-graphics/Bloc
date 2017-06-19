initialization
withSpartaRenderer
	| surface |

	renderer := BlSpartaRenderer for: self.

	surface := BlHostRendererBufferSurface new.
	surface hostSpace: self.
	surface hostRenderer: renderer.

	renderer surface: surface.
	
	osWindowRenderer := window newBlocRenderer surface: surface