as yet unclassified
for: anSDLSpace
	^ self new
		sdlSpace: anSDLSpace;
		sdlRenderer: anSDLSpace sdlWindow createDefaultRenderer;
		resetResources