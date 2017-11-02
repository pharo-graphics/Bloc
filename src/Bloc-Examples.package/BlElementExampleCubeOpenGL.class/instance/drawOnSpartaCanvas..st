drawing
drawOnSpartaCanvas: aCanvas
	"| gl context framebuffer extentNorm |
	super drawOnSpartaCanvas: aCanvas.
	
	context := self context.
	framebuffer := self framebuffer.
	gl := context gl.

	extentNorm := self extent / self extent min asFloat.
		
	context asCurrentDo: [		
		framebuffer activate.
		
		gl
			viewport_x: 0 y: 0 width: self width height: self height;
			clear: GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT.
		
		gl
			matrixMode: GL_PROJECTION;
			loadIdentity;
			ortho_left: extentNorm x / 2.0 negated
				right: extentNorm x / 2.0
				bottom: extentNorm y / 2.0
				top: extentNorm y / 2.0 negated
				zNear: -1
				zFar: 1.

		gl
			matrixMode: GL_MODELVIEW;
			loadIdentity.

		gl
			scalef_x: 0.20 y: 0.20 z: 0.20;
			rotatef_angle: rotateX x: 1 y: 0 z: 0;
			rotatef_angle: rotateY x: 0 y: 1 z: 0;
			rotatef_angle: rotateZ x: 0 y: 0 z: 1.
		
		self drawCubeOn: gl.
	].

	aCanvas fill
		paint: Color blue;
		path: self boundsInLocal;
		draw.
		
	aCanvas fill
		paint: framebuffer asForm;
		path: self boundsInLocal;
		draw"