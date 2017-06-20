host space - rendering
prepareToRender: aBlSpace onFormSurface: aBlHostRendererFormSurface
	"Prepare host space to a given space on a Form surface.
	By default dispatch directly to the renderer"
	
	self hasResized
		ifTrue: [ window validHandle renderer resetResources ].

	self renderer prepareToRender: aBlSpace