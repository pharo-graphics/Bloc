"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control OSWindow window using unified host space api.
"
Class {
	#name : #BlOSWindowSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'window',
		'renderer',
		'eventFetcher',
		'space',
		'osWindowRenderer',
		'host'
	],
	#category : 'BlocHost-OSWindow-Host'
}

{ #category : #'host space - accessing' }
BlOSWindowSpace >> borderless [
	^ window borderless
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> borderless: aBoolean [
	window borderless: aBoolean
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>
	
	^ window canvasExtent
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> close [
	self isValid ifTrue: [ window destroy ].
	window := nil
]

{ #category : #'host space - cursor' }
BlOSWindowSpace >> cursor: aCursor [
	window setMouseCursor: aCursor
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlOSWindowSpace >> eventFetcher [
	^ eventFetcher
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> hide [
	window hide
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
BlOSWindowSpace >> initialize [
	super initialize.
	
	eventFetcher := BlHostEventFetcher new
]

{ #category : #initialization }
BlOSWindowSpace >> initializeForBuffer: aBufferSurface [
	"Asks host space to initialize itself to be used together with a pixel buffer surface.
	Default implementation simply connects renderer, host space and surface together"

	self initializeWithAttributes: (self host createAttributesFor: self space).

	aBufferSurface hostSpace: self.
	aBufferSurface hostRenderer: self renderer.

	self renderer surface: aBufferSurface.
	window newBlocRenderer surface: aBufferSurface
]

{ #category : #initialization }
BlOSWindowSpace >> initializeForForm: anFormSurface [
	"Asks host space to initialize itself to be used together with a Form surface.
	Default implementation simply connects renderer, host space and surface together"
	
	self initializeWithAttributes: (self host createAttributesFor: self space).
	
	anFormSurface hostSpace: self.
	anFormSurface hostRenderer: self renderer.

	self renderer surface: anFormSurface.
	window newBlocRenderer surface: anFormSurface
]

{ #category : #initialization }
BlOSWindowSpace >> initializeForOpenGL: anOpenGLSurface [
	"Asks host space to initialize itself to be used together with an OpenGL surface.
	Default implementation simply connects renderer, host space and surface together"
	| glAttributes |
	
	glAttributes := OSWindowGLAttributes new.
	glAttributes redSize: 8.
	glAttributes greenSize: 8.
	glAttributes blueSize: 8.
	glAttributes stencilSize: 8.
	
	self initializeWithAttributes: ((self host createAttributesFor: self space) glAttributes: glAttributes).

	anOpenGLSurface hostSpace: self.
	anOpenGLSurface hostRenderer: self renderer.
	"anOpenGLSurface context: UFFIOpenGLContext new."

	self renderer surface: anOpenGLSurface.
	
	window newOpenGLRenderer
]

{ #category : #initialization }
BlOSWindowSpace >> initializeWithAttributes: initialAttributes [
	window := OSWindowAnimated createWithAttributes: initialAttributes.
	window eventHandler: (BlOSWindowEventHandler window: self).
	window startTextInput
]

{ #category : #testing }
BlOSWindowSpace >> isValid [
	^ window isNotNil and: [ window isValid ]
]

{ #category : #'host space - testing' }
BlOSWindowSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ window isVisible
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> open [
	window show
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> position [
	^ window position
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> position: aPoint [
	window position: aPoint
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> prepareToRender: aBlSpace onBufferSurface: aBlHostRendererBufferSurface [
	"Prepare host space to a given space on a buffer surface.
	By default dispatch directly to the renderer"
	
	self hasResized
		ifTrue: [ window validHandle renderer resetResources ].
	
	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> prepareToRender: aBlSpace onFormSurface: aBlHostRendererFormSurface [
	"Prepare host space to a given space on a Form surface.
	By default dispatch directly to the renderer"
	
	self hasResized
		ifTrue: [ window validHandle renderer resetResources ].

	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> prepareToRender: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface [
	"Prepare host space to a given space on an OpenGL surface.
	By default dispatch directly to the renderer"
	
	self hasResized
		ifTrue: [ aBlHostRendererOpenGLSurface extent: self canvasExtent ].
	
	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	window validHandle renderer
		presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	window validHandle renderer
		presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> presentOpenGLSurface: aBlHostRendererOpenGLSurface areas: aCollectionOfAreas [
	
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> render: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface [
	"Render a given space on an OpenGL surface.
	By default dispatch directly to the renderer"
	| context gl |
	
	context := aBlHostRendererOpenGLSurface context.
	gl := context gl.

	context withWindow: window validHandle do: [
		gl
			clearColor_red: 0.0 green: 1.0 blue: 1.0 alpha: 1.0;
			clearDepth: 1.0;
			clear: GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT.
		aBlSpace beDirtyArea.
		self renderer doRender: aBlSpace.		
		context swapBuffers: window validHandle.
		context checkErrors.
	].
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> renderSpace: aSpace [
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
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #TBlHostRenderer>

	^ renderer
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> resizable [
	^ window resizable
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> resizable: aBoolean [
	window resizable: aBoolean
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ (self canvasExtent / self windowExtent) asFloatPoint
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> show [
	window show
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> title [
	^ window title
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> title: aString [
	window title: aString
]

{ #category : #private }
BlOSWindowSpace >> window: anOSWindow [
	window := anOSWindow
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ window extent
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	self windowExtent ~= newExtent
		ifTrue: [ window extent: newExtent ]
]

{ #category : #initialization }
BlOSWindowSpace >> withSpartaRenderer [

	renderer := BlSpartaRenderer new.
	renderer initializeHostSpace: self
]
