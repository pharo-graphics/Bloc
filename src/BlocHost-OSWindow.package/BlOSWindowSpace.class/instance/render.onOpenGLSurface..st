host space - rendering
render: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface
	"Render a given space on an OpenGL surface.
	By default dispatch directly to the renderer"
	| context gl |
	
	context := aBlHostRendererOpenGLSurface context.
	gl := context gl.
	
	context withWindow: window validHandle do: [
		gl
			clearColor_red: 0.0 green: 1.0 blue: 1.0 alpha: 1.0;
			clear: GL_COLOR_BUFFER_BIT.
		aBlSpace beDirtyArea.
		self renderer doRender: aBlSpace.
		
		context swapBuffers: window validHandle
	].