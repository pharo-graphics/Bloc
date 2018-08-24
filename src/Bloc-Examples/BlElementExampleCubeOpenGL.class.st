"
Class definition:

BlElement subclass: #BlElementExampleCubeOpenGL
	instanceVariableNames: 'rotateX rotateY rotateZ count ctx fb'
	classVariableNames: ''
	poolDictionaries: 'UFFIOpenGLConstants UFFIOpenGLTypes'
	category: 'Bloc-Examples-Experimental'
"
Class {
	#name : #BlElementExampleCubeOpenGL,
	#superclass : #BlElement,
	#instVars : [
		'rotateX',
		'rotateY',
		'rotateZ',
		'count',
		'ctx',
		'fb'
	],
	#category : 'Bloc-Examples-Experimental'
}

{ #category : #accessing }
BlElementExampleCubeOpenGL >> context [

	^ ctx
]

{ #category : #drawing }
BlElementExampleCubeOpenGL >> cube [

	^ { 
		"Multi-colored side - TOP"
		{ 
			#( 1.0,  0.0,  0.0 ) -> #(  1, 1, -1 ).
			#( 0.0,  1.0,  0.0 ) -> #( -1, 1, -1 ).
			#( 0.0,  0.0,  1.0 ) -> #( -1, 1,  1 ).
			#( 1.0,  0.0,  1.0 ) -> #(  1, 1,  1 ) }.
		"Red side - BOTTOM"
		{ 
			#( 1.0,  0.0,  0.0 ) -> #(  1, -1,  1 ).
			#( 1.0,  0.0,  0.0 ) -> #( -1, -1,  1 ).
			#( 1.0,  0.0,  0.0 ) -> #( -1, -1, -1 ).
			#( 1.0,  0.0,  0.0 ) -> #(  1, -1, -1 ) }.
			
		"Cyan side - FRONT"
		{ 
			#( 0.0,  1.0,  1.0 ) -> #(  1,  1,  1 ).
			#( 0.0,  1.0,  1.0 ) -> #( -1,  1,  1 ).
			#( 0.0,  1.0,  1.0 ) -> #( -1, -1,  1 ).
			#( 0.0,  1.0,  1.0 ) -> #(  1, -1,  1 ) }.
			
		"Blue side - BACK"
		{ 
			#( 0.0,  0.0, 1.0 ) -> #(  1, -1, -1 ).
			#( 0.0,  0.0, 1.0 ) -> #( -1, -1, -1 ).
			#( 0.0,  0.0, 1.0 ) -> #( -1,  1, -1 ).
			#( 0.0,  0.0, 1.0 ) -> #(  1,  1, -1 ) }.
			
		"Green side - LEFT"
		{ 
			#( 0.0,  1.0,  0.0 ) -> #( -1,  1,  1 ).
			#( 0.0,  1.0,  0.0 ) -> #( -1,  1, -1 ).
			#( 0.0,  1.0,  0.0 ) -> #( -1, -1, -1 ).
			#( 0.0,  1.0,  0.0 ) -> #( -1, -1,  1 ) }.
			
		"Purple side - RIGHT"
		{ 
			#( 1.0,  0.0,  1.0 ) -> #(  1,  1, -1 ).
			#( 1.0,  0.0,  1.0 ) -> #(  1,  1,  1 ).
			#( 1.0,  0.0,  1.0 ) -> #(  1, -1,  1 ).
			#( 1.0,  0.0,  1.0 ) -> #(  1, -1, -1 ) }.
		
	 }
]

{ #category : #drawing }
BlElementExampleCubeOpenGL >> cubeSize [
	^ 1
]

{ #category : #drawing }
BlElementExampleCubeOpenGL >> drawCubeOn: gl [
	"| cubeSize |

	cubeSize := self cubeSize.

	self cube do: [ :aSide |
		gl begin: GL_QUADS.
		aSide do: [ :aVertex |			
			gl
				color3f_red: aVertex key first
				green: aVertex key third
				blue: aVertex key fifth.
			gl
				vertex3f_x: aVertex value first
				y: aVertex value third
				z: aVertex value fifth ].
		gl end ]."
]

{ #category : #drawing }
BlElementExampleCubeOpenGL >> drawOnSpartaCanvas: aCanvas [
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
]

{ #category : #accessing }
BlElementExampleCubeOpenGL >> framebuffer [

	"^ fb ifNil: [ fb := self context offscreenBufferExtent: self extent ]"
]

{ #category : #initialization }
BlElementExampleCubeOpenGL >> initialize [
	super initialize.
	
	"ctx := UFFIOpenGLContext new.
	ctx gl
		clearColor_red: 1.0 green: 1 blue: 1.0 alpha: 1;
		clearDepth: 1.0;
		enable: GL_DEPTH_TEST;
		enable: GL_CULL_FACE;
		enable: GL_TEXTURE_2D;
		depthFunc: GL_LEQUAL;
		shadeModel: GL_SMOOTH;
		hint_target: GL_PERSPECTIVE_CORRECTION_HINT mode: GL_NICEST.
	
	rotateX := 0.
	rotateY := 0.
	rotateZ := 0.
	
	BlNumberTransition new
		beInfinite;
		target: self;
		from: 0;
		to: 360;
		duration: 10000;
		onStepDo: [ :value | rotateX := rotateY := rotateZ := value. self invalidate ];
		start.
		
	count := 0"
]

{ #category : #'geometry hooks' }
BlElementExampleCubeOpenGL >> onExtentChanged [
	super onExtentChanged.

	fb := nil
]
