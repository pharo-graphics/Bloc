Class {
	#name : #BlSpartaWebrenderCanvasBuilder,
	#superclass : #BlSpartaCanvasBuilder,
	#category : #'Bloc-Sparta'
}

{ #category : #accessing }
BlSpartaWebrenderCanvasBuilder class >> isSupported [
	<return: #Boolean>
	
	^ (self environment includesKey: #WebrenderCanvas)
		and: [ (self environment at: #WebrenderLibrary) uniqueInstance hasModule ]
]

{ #category : #accessing }
BlSpartaWebrenderCanvasBuilder class >> label [
	<return: #String>
	^ 'Webrender'
]

{ #category : #'instance creation' }
BlSpartaWebrenderCanvasBuilder class >> offscreen [
	<return: #SpartaCanvas>

	^ (self environment at: #SkiaCanvas) offscreen
]

{ #category : #accessing }
BlSpartaWebrenderCanvasBuilder class >> priority [
	"Return sparta canvas builder priority as positive number which influences builder order
	and selection of a default canvas.
	Lower value - more likely canvas becomes a default"
	<return: #Number>

	^ 100
]

{ #category : #testing }
BlSpartaWebrenderCanvasBuilder class >> supportsBufferSurface [
	"Return true if this canvas builder can work with a buffer surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaWebrenderCanvasBuilder class >> supportsFormSurface [
	"Return true if this canvas builder can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #testing }
BlSpartaWebrenderCanvasBuilder class >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'instance creation' }
BlSpartaWebrenderCanvasBuilder >> forOpenGLOn: aRendererSurface [
	| aWebrender |
	<return: #SpartaCanvas>
	
	aWebrender := (self class environment at: #Webrender)
		init: ((self class environment at: #GtGleamGL) loadGl: [ :aSymbol | aRendererSurface context getProcAddress: aSymbol ])
		extent: aRendererSurface physicalSize asPoint
		options: ((self class environment at: #WebrenderRendererOptions) new
			debugFlag: (self class environment at: #WebrenderDebugFlags) PROFILER_DBG";
			debugFlag: (self class environment at: #WebrenderDebugFlags) COMPACT_PROFILER").

	aRendererSurface addUpdateAction: [
		aWebrender update.	
		aWebrender render: aRendererSurface physicalSize asPoint.
		aWebrender flushPipelineInfo ].
	aRendererSurface updateEveryFrame.

	^ (self class environment at: #WebrenderWindowCanvas)
		extent: aRendererSurface physicalSize asPoint
		webrender: aWebrender
]
