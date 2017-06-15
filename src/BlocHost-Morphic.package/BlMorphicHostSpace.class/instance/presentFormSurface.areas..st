host space - drawing
presentFormSurface: aRendererSurface areas: aCollectionOfAreas

	morphicWindow form: aRendererSurface form.
	mirrowWindows do: [ :each | each form: aRendererSurface form ]