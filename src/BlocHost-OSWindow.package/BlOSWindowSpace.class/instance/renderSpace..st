host space - rendering
renderSpace: aSpace
	"| extent |
		
	extent := self windowExtent.
		
	(canvas isNil or: [ windowExtent ~= extent ]) ifTrue: [ 
		windowExtent := extent.
		canvasExtent := windowExtent * 2.
		canvas := MozCanvas
			extent: canvasExtent.
		canvas transform
			push;
			scaleBy: 2;
			apply.
		
		texture := nil.
		
		MozCanvas primStderr: 'Reset resources'.
		
		SDL2 glSetSwapInterval: 1.
	].
	
	aSpace fullDrawOn: canvas.
	
	context withWindow: window validHandle do: [
		| gl |
		
		[ | error |
			[(error := context gl getError) ~= GL_NO_ERROR] whileTrue: [

			] ] value.
		
		gl := context gl.
		
		gl
			clearColor_red: 0.0 green: 1.0 blue: 1.0 alpha: 1.0;
			clear: GL_COLOR_BUFFER_BIT.
			
		gl
			viewport_x: 0 y: 0 width: canvasExtent x height: canvasExtent y;
			ortho_left: 0 right: canvasExtent x bottom: 0 top: canvasExtent y zNear: -1.0 zFar: 1.0;
			matrixMode: GL_TEXTURE;
			loadIdentity;
			scalef_x: 1.0 y: -1.0 z: 1.0;
			yourself.
		
		texture ifNil: [ 
			texture := context textureObject.
		
			gl
				bindTexture_target: GL_TEXTURE_2D texture: texture validHandle.
			
			gl
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_MIN_FILTER param: GL_LINEAR;
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_MAG_FILTER param: GL_LINEAR;
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_WRAP_S param: GL_CLAMP_TO_EDGE;
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_WRAP_T param: GL_CLAMP_TO_EDGE;
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_BASE_LEVEL param: 0;
				texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_MAX_LEVEL param: 0;
				yourself.
			
			context checkErrors.
			
			gl
				texImage2D_target: GL_TEXTURE_2D
				level: 0
				internalformat: GL_RGBA
				width: canvas width
				height: canvas height
				border: 0
				format: GL_BGRA
				type: GL_UNSIGNED_BYTE
				pixels: canvas primData.
			].
		
		gl
			enable: GL_TEXTURE_2D.
		
		gl
			bindTexture_target: GL_TEXTURE_2D
			texture: texture validHandle.
				
		gl
			texSubImage2D_target: GL_TEXTURE_2D
			level: 0
			xoffset: 0
			yoffset: 0
			width: canvas width
			height: canvas height
			format: GL_BGRA
			type: GL_UNSIGNED_BYTE
			pixels: canvas primData.
			
			gl
				begin: GL_QUADS;
				texCoord2f_s: 0 t: 0; vertex2f_x: 0 y: 0;
				texCoord2f_s: 1 t: 0; vertex2f_x: canvas width y: 0;
				texCoord2f_s: 1 t: 1; vertex2f_x: canvas width y: canvas height;
				texCoord2f_s: 0 t: 1; vertex2f_x: 0 y: canvas height;
			end.
			
			gl
				disable: GL_TEXTURE_2D.
			
			context checkErrors
	].
	
	context withWindow: window validHandle do: [
			
		surface blitToMainFramebuffer.
		context swapBuffers: window validHandle.
		context checkErrors
	]"