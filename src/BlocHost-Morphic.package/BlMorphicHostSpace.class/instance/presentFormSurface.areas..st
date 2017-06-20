host space - rendering
presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas

	morphicWindow form: aBlHostRendererFormSurface form.
	mirrowWindows do: [ :each | each form: aBlHostRendererFormSurface form ]