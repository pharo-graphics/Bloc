Class {
	#name : #BlGlutinRenderer,
	#superclass : #Object,
	#instVars : [
		'window',
		'surface',
		'gl',
		'textureExtent',
		'vertShaderObj',
		'fragShaderObj',
		'progObj',
		'vertexBuff',
		'buffData',
		'texBuff',
		'vloc',
		'tloc',
		'uLoc',
		'texture'
	],
	#pools : [
		'GlutinOpenGLConstants'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #'instance creation' }
BlGlutinRenderer class >> for: aWindowHandle [
	^ self basicNew
		initialize;
		initializeWindowHandle: aWindowHandle;
		yourself
]

{ #category : #'instance creation' }
BlGlutinRenderer class >> new [ 
	self error: 'Use #for:'
]

{ #category : #'host space - accessing' }
BlGlutinRenderer >> canvasExtent [
	^ window handle framebufferExtent
]

{ #category : #'private - gl' }
BlGlutinRenderer >> fragmentShader [
	| aShaderVersion |
	
	aShaderVersion := gl shaderVersion.
	aShaderVersion >= 410
		ifTrue: [ ^ self fragmentShader410 ].

	aShaderVersion >= 330
		ifTrue: [ ^ self fragmentShader330 ].
	
	aShaderVersion >= 150
		ifTrue: [ ^ self fragmentShader150 ].

	aShaderVersion >= 120
		ifTrue: [ ^ self fragmentShader120 ].
		
	^ self error: 'No fragment shader for version ', aShaderVersion asString
]

{ #category : #'private - gl' }
BlGlutinRenderer >> fragmentShader120 [
	^ '#version 120
	
	varying vec2 vTex;
	uniform sampler2D sampler0;

	void main(void) {
		gl_FragColor = texture2D(sampler0, vTex);
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> fragmentShader150 [
	^ '#version 150
	
	varying vec2 vTex;
	uniform sampler2D sampler0;

	void main(void) {
		gl_FragColor = texture2D(sampler0, vTex);
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> fragmentShader330 [
	^ '#version 330
	
	precision highp float;
	
	varying vec2 vTex;
	uniform sampler2D sampler0;

	void main(void) {
		gl_FragColor = texture2D(sampler0, vTex);
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> fragmentShader410 [
	^ '#version 410
	
	precision highp float;
	
	in vec2 vTex;
	uniform sampler2D sampler0;
	
	out vec4 fragColor;
	void main(void) {
		fragColor = texture(sampler0, vTex);
	}'
]

{ #category : #'host space - drawing' }
BlGlutinRenderer >> initializeForBuffer: aBlHostRendererBufferSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	self asCurrentDo: [
		| form pixels |
		textureExtent := aBlHostRendererBufferSurface canvasExtent.
		
		form := Form extent: textureExtent depth: 32.

		pixels := FFIExternalArray externalNewType: FFIUInt32 size: form stride * form height.
		pixels autoRelease.

		aBlHostRendererBufferSurface
			buffer: pixels getHandle;
			stride: form stride;
			extent: textureExtent.
			
		self initializeGL.

		gl viewport_x: 0 y: 0 width: textureExtent x height: textureExtent y.
	
		texture := gl gen_texture.
		gl bind_texture_2d: texture.
		gl tex_parameter_i_target: GL_TEXTURE_2D name: GL_TEXTURE_MIN_FILTER param: GL_NEAREST.
		gl tex_parameter_i_target: GL_TEXTURE_2D name: GL_TEXTURE_MAG_FILTER param: GL_NEAREST.
		
		gl
			tex_image_2d_level: 0
			internalformat: GL_RGBA
			width: textureExtent x
			height: textureExtent y
			border: 0
			format: GL_BGRA
			type: GL_UNSIGNED_INT_8_8_8_8_REV
			pixels: surface buffer
			length: surface stride * textureExtent y * 4 ]
]

{ #category : #initialization }
BlGlutinRenderer >> initializeForOpenGL: aBlHostRendererOpenGLSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	self asCurrentDo: [	
		aBlHostRendererOpenGLSurface
			extent: aBlHostRendererOpenGLSurface canvasExtent ]
]

{ #category : #'host space - drawing' }
BlGlutinRenderer >> initializeGL [
	
	gl
		ifNotNil: [ ^ self ].

	gl := self window handle gl.
	
	gl clear_colorR: 1 g: 1 b: 1 a: 1.
	gl clear: GL_COLOR_BUFFER_BIT.

	vertShaderObj := gl create_vertex_shader.
	fragShaderObj := gl create_fragment_shader.
	gl shader_source: vertShaderObj string: (self vertexShader withLineEndings: OSPlatform current lineEnding).
	gl shader_source: fragShaderObj string: (self fragmentShader withLineEndings: OSPlatform current lineEnding).
	gl compile_shader: vertShaderObj.
	gl compile_shader: fragShaderObj.
	
	progObj := gl create_program.
	gl attach_shader: vertShaderObj program: progObj.
	gl attach_shader: fragShaderObj program: progObj.
	
	gl link_program: progObj.
	gl use_program: progObj.
	
	vertexBuff := gl create_buffer.
	gl bind_array_buffer: vertexBuff.

	buffData := FFIExternalArray externalNewType: FFIFloat32 size: 8.
	buffData atAll: (1 to: 8) putAll: #(-1 1 -1 -1 1 -1 1 1).
	gl array_buffer_data_static_draw: (buffData getHandle) length: buffData size.
	buffData free.
	
	texBuff := gl create_buffer.
	gl bind_array_buffer: texBuff.

	buffData := FFIExternalArray externalNewType: FFIFloat32 size: 8.
	buffData atAll: (1 to: 8) putAll: #(0 1 0 0 1 0 1 1).
	gl array_buffer_data_static_draw: (buffData getHandle) length: buffData size.
	buffData free.

	vloc := gl get_attribute_location_program: progObj name: 'aVertex'.
	tloc := gl get_attribute_location_program: progObj name: 'aUV'.
	uLoc := gl get_attribute_location_program: progObj name: 'pos'.
]

{ #category : #initialization }
BlGlutinRenderer >> initializeWindowHandle: aGlutinWindowHandle [
	self window: aGlutinWindowHandle
]

{ #category : #misc }
BlGlutinRenderer >> makeCurrent: aWindow [
	aWindow isValid
		ifFalse: [ ^ false ].
	
	aWindow handle makeCurrent.
	^ true
]

{ #category : #'host space - drawing' }
BlGlutinRenderer >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	
	self asCurrentDo: [
		| vao |
		
		gl bind_texture_2d: texture.
		gl tex_parameter_i_target: GL_TEXTURE_2D name: GL_TEXTURE_MIN_FILTER param: GL_NEAREST.
		gl tex_parameter_i_target: GL_TEXTURE_2D name: GL_TEXTURE_MAG_FILTER param: GL_NEAREST.
		
		gl
			tex_sub_image_2d_level: 0
			xoffset: 0
			yoffset: 0
			width: textureExtent x
			height: textureExtent y
			format: GL_BGRA
			type: GL_UNSIGNED_INT_8_8_8_8_REV
			pixels: aBlHostRendererBufferSurface buffer
			length: aBlHostRendererBufferSurface stride * textureExtent y * 4.
		
		vao := gl gen_vertex_array.
		gl bind_vertex_array: vao.
		
		gl enable_vertex_attrib_array: vloc.
		gl bind_array_buffer: vertexBuff.
		gl
			vertex_attrib_pointer_index: vloc
			size: 2
			type: GL_FLOAT
			normalized: false
			stride: 0
			offset: 0.
			
		gl enable_vertex_attrib_array: tloc.
		gl bind_array_buffer: texBuff.
		gl
			vertex_attrib_pointer_index: tloc
			size: 2
			type: GL_FLOAT
			normalized: false
			stride: 0
			offset: 0.
			
		gl draw_arrays_mode: GL_TRIANGLE_FAN first: 0 count: 4.	
		
		self swapBuffers ]
]

{ #category : #'host space - drawing' }
BlGlutinRenderer >> presentOpenGLSurface: aBlHostRendererOpenGLSurface areas: aCollectionOfAreas [
	
	self asCurrentDo: [ self swapBuffers ]
]

{ #category : #misc }
BlGlutinRenderer >> swapBuffers: aWindow [
	aWindow handle swapBuffers
]

{ #category : #'private - gl' }
BlGlutinRenderer >> vertexShader [
	| aShaderVersion |
	
	aShaderVersion := gl shaderVersion.
	aShaderVersion >= 410
		ifTrue: [ ^ self vertexShader410 ].

	aShaderVersion >= 330
		ifTrue: [ ^ self vertexShader330 ].
	
	aShaderVersion >= 150
		ifTrue: [ ^ self vertexShader150 ].
	
	aShaderVersion >= 120
		ifTrue: [ ^ self vertexShader120 ].
		
	^ self error: 'No vertex shader for version ', aShaderVersion asString
]

{ #category : #'private - gl' }
BlGlutinRenderer >> vertexShader120 [
	^ '#version 120
	
	attribute vec2 aVertex;
	attribute vec2 aUV;
	varying vec2 vTex;
	
	void main(void) {
		gl_Position = vec4(aVertex.x, -aVertex.y, 0.0, 1.0);
		vTex = aUV;
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> vertexShader150 [
	^ '#version 150
	
	attribute vec2 aVertex;
	attribute vec2 aUV;
	varying vec2 vTex;
	
	void main(void) {
		gl_Position = vec4(aVertex.x, -aVertex.y, 0.0, 1.0);
		vTex = aUV;
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> vertexShader330 [
	^ '#version 330
	
	attribute vec2 aVertex;
	attribute vec2 aUV;
	varying vec2 vTex;
	
	void main(void) {
		gl_Position = vec4(aVertex.x, -aVertex.y, 0.0, 1.0);
		vTex = aUV;
	}'
]

{ #category : #'private - gl' }
BlGlutinRenderer >> vertexShader410 [
	^ '#version 410
	
	in vec2 aVertex;
	in vec2 aUV;
	out vec2 vTex;
	
	void main(void) {
		gl_Position = vec4(aVertex.x, -aVertex.y, 0.0, 1.0);
		vTex = aUV;
	}'
]
