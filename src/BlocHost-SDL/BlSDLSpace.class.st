Class {
	#name : #BlSDLSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'renderer',
		'sdlWindow',
		'eventQueue',
		'iconSurface',
		'currentCursor',
		'space'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-SDL'
}

{ #category : #'host space - accessing' }
BlSDLSpace >> borderless [
	^ sdlWindow getFlags anyMask: SDL_WINDOW_BORDERLESS
]

{ #category : #'host space - accessing' }
BlSDLSpace >> borderless: aBoolean [
	self toggleBorder: aBoolean not.
]

{ #category : #'host space - displaying' }
BlSDLSpace >> close [
	self destroy
]

{ #category : #'private - cursor' }
BlSDLSpace >> convertCursor: aCursor [
	| result bits|
	aCursor unhibernate.
	bits := aCursor bits.
	result := ByteArray new: 32.
	0 to: 15 do: [ :i |
		result at: i*2 + 1 put: (bits at: i + 1) >> 24 & 255.
		result at: i*2 + 2 put: (bits at: i + 1) >> 16 & 255.
	].
	^ result
]

{ #category : #'host space - cursor' }
BlSDLSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	self setMouseCursor: aCursor mask: aCursor maskForm
]

{ #category : #'host space - accessing' }
BlSDLSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	| anIndex |
	
	anIndex := self sdlWindow getDisplayIndex.
	anIndex < 0
		"There is no display, guess dpi"
		ifTrue: [ ^ 96.0 ].
	
	^ 96.0
	
	"SDL does not support DPI yet"
	
	"aDDPI := ByteArray new: ExternalType float byteSize.
	aHDPI := ByteArray new: ExternalType float byteSize.
	aVDPI := ByteArray new: ExternalType float byteSize.
	
	sdlWindow getDisplay: anIndex ddpi: aDDPI hdpi: aHDPI vdpi: aVDPI.
	
	^ aDDPI signedLongAt: 1"
]

{ #category : #'private - displaying' }
BlSDLSpace >> destroy [
	sdlWindow ifNotNil: [ :validHandle | validHandle destroy ].
	renderer := nil.
	sdlWindow := nil
]

{ #category : #'private - accessing' }
BlSDLSpace >> drawableExtent [
	"Return the size of a window's underlying OpenGL drawable in pixels.
	Returned extent may differ from #extent on high dpi (retina) displays"
	<return: #Point>
	| w h |

	w := ByteArray new: ExternalType long byteSize.
	h := ByteArray new: ExternalType long byteSize.
	sdlWindow getDrawableSize: sdlWindow w: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)
]

{ #category : #'host space - events' }
BlSDLSpace >> enqueueEvent: aBlEvent [

	eventQueue nextPut: aBlEvent.
	BlUniverse default requestNextPulse
]

{ #category : #'host space - events' }
BlSDLSpace >> fetchedEventsDo: aBlock [
	| theEvents |

	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	theEvents do: aBlock
]

{ #category : #'host space - displaying' }
BlSDLSpace >> fullscreen [
	^ sdlWindow getFlags anyMask: SDL_WINDOW_FULLSCREEN
]

{ #category : #'host space - displaying' }
BlSDLSpace >> fullscreen: aBoolean [
	aBoolean ifTrue: [
		sdlWindow fullscreen: SDL_WINDOW_FULLSCREEN_DESKTOP
	] ifFalse: [ 
		sdlWindow fullscreen: 0
	]
]

{ #category : #'private - accessing' }
BlSDLSpace >> getFlags [
	^ sdlWindow getFlags
]

{ #category : #'private - accessing' }
BlSDLSpace >> getWMInfo [
	| wmInfo |
	wmInfo := SDL_SysWMinfo new version: SDL_Version bindingVersion.
	sdlWindow getWMInfo: wmInfo.
	^ wmInfo
]

{ #category : #'host space - testing' }
BlSDLSpace >> hasResized [
	^ renderer hasResized
]

{ #category : #'host space - displaying' }
BlSDLSpace >> hide [
	sdlWindow hide
]

{ #category : #'host space - accessing' }
BlSDLSpace >> icon: aForm [
	| convertedIcon surface |
	aForm ifNil: [ ^self ].
	
	convertedIcon := aForm unhibernate; asFormOfDepth: 32.
	surface := SDL2 createRGBSurfaceFromPixels: convertedIcon bits
			width: convertedIcon width height: convertedIcon height
			depth: 32 pitch: convertedIcon width *4
			rmask: 16r00ff0000 
			gmask: 16r000ff00
			bmask: 16r00000ff
			amask: 16rff000000.
	sdlWindow icon: surface.
	iconSurface ifNotNil: [ SDL2 freeSurface: surface ].
	iconSurface := surface.
]

{ #category : #initialization }
BlSDLSpace >> initialize [
	super initialize.
	eventQueue := WaitfreeQueue new
]

{ #category : #'host space - testing' }
BlSDLSpace >> isVisible [
	^ (self getFlags bitAnd: SDL_WINDOW_SHOWN) = SDL_WINDOW_SHOWN
]

{ #category : #'host space - displaying' }
BlSDLSpace >> maximize [

	sdlWindow maximize.
]

{ #category : #'host space - displaying' }
BlSDLSpace >> maximized [
	^ sdlWindow getFlags anyMask: SDL_WINDOW_MAXIMIZED
]

{ #category : #'host space - displaying' }
BlSDLSpace >> minimize [

	sdlWindow minimize.
]

{ #category : #'host space - displaying' }
BlSDLSpace >> minimized [
	^ sdlWindow getFlags anyMask: SDL_WINDOW_MINIMIZED
]

{ #category : #'private - accessing' }
BlSDLSpace >> mousePosition [
	| x y |
	x := ByteArray new: ExternalType long byteSize.
	y := ByteArray new: ExternalType long byteSize.
	SDL2 mouseStateX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)
]

{ #category : #'host space - displaying' }
BlSDLSpace >> open [
	self show
]

{ #category : #'host space - accessing' }
BlSDLSpace >> position [
	| x y |
	self flag: 'Why is sdlWindow nil sometimes?'.
	sdlWindow ifNil: [ ^ 0@0 ].
	x := ByteArray new: ExternalType long byteSize.
	y := ByteArray new: ExternalType long byteSize.
	sdlWindow getPositionX: x y: y.
	^ ( x signedLongAt: 1) @ (y signedLongAt: 1)
]

{ #category : #'host space - accessing' }
BlSDLSpace >> position: aPoint [
	sdlWindow setPositionX: aPoint x asInteger y: aPoint y asInteger
]

{ #category : #'host space - drawing' }
BlSDLSpace >> render: aSpace [
	renderer render: aSpace
]

{ #category : #'private - accessing' }
BlSDLSpace >> rendererExtent [
	"Return the size of a window's underlying drawable in pixels.
	Returned extent may differ from #extent on high dpi (retina) displays"
	<return: #Point>
	| width height |
	
	width := FFIExternalArray externalNewType: 'int' size: 1.
	height := FFIExternalArray externalNewType: 'int' size: 1.
	sdlWindow
		getRendererSize: sdlWindow getRenderer
		w: width getHandle
		h: height getHandle.
	^ (width at: 1) @ (height at: 1)
]

{ #category : #'host space - accessing' }
BlSDLSpace >> resizable [
	^ sdlWindow getFlags anyMask: SDL_WINDOW_RESIZABLE
]

{ #category : #'host space - accessing' }
BlSDLSpace >> resizable: aBoolean [
	"This is not supported"
]

{ #category : #'host space - accessing' }
BlSDLSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ renderer scaleFactor
]

{ #category : #'private - accessing' }
BlSDLSpace >> sdlWindow [
	^ sdlWindow
]

{ #category : #'private - accessing' }
BlSDLSpace >> sdlWindow: anObject [
	sdlWindow := anObject
]

{ #category : #'private - cursor' }
BlSDLSpace >> setMouseCursor: cursor mask: mask [
	| cursorBits maskBits extent offset sdlCursor |
	cursorBits := self convertCursor: cursor.
	maskBits := self convertCursor: mask.
	extent := cursor extent.
	offset := cursor offset.
	sdlCursor := SDL2 createCursor: cursorBits mask: maskBits w: extent x h: extent y hotX: offset x negated hotY: offset y negated.
	sdlCursor ifNotNil: [ sdlCursor setCursor ].
	currentCursor ifNotNil: [ currentCursor freeCursor ].
	currentCursor := sdlCursor
]

{ #category : #'host space - displaying' }
BlSDLSpace >> show [
	sdlWindow show
]

{ #category : #'private - cursor' }
BlSDLSpace >> showCursor: aBoolean [
	SDL2 showCursor: (aBoolean ifTrue: [SDL_ENABLE] ifFalse: [SDL_DISABLE]).

]

{ #category : #'host space - accessing' }
BlSDLSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
BlSDLSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'host space - accessing' }
BlSDLSpace >> title [
	^ sdlWindow title
]

{ #category : #'host space - accessing' }
BlSDLSpace >> title: aTitle [
	sdlWindow title: aTitle
]

{ #category : #'host space - displaying' }
BlSDLSpace >> toBack [
]

{ #category : #'host space - displaying' }
BlSDLSpace >> toFront [
	sdlWindow raiseWindow
]

{ #category : #'private - accessing' }
BlSDLSpace >> toggleBorder: aBoolean [
	sdlWindow toggleBorder: aBoolean.
]

{ #category : #'host space - accessing' }
BlSDLSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"
	<return: #Point>
	| w h |

	w := ByteArray new: ExternalType long byteSize.
	h := ByteArray new: ExternalType long byteSize.
	sdlWindow getSizeW: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)
]

{ #category : #'host space - accessing' }
BlSDLSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	self windowExtent ~= newExtent
		ifTrue: [ sdlWindow setSizeW: newExtent x h: newExtent y ].

	"we must always let renderer now that size changed
	(dpi might changed, even if extent is still the same)"
	renderer resized
]

{ #category : #'private - accessing' }
BlSDLSpace >> windowID [
	^ sdlWindow windowID
]

{ #category : #initialization }
BlSDLSpace >> withSkiaRendereer [
	renderer := BlSDLSkiaRenderer for: self
]

{ #category : #initialization }
BlSDLSpace >> withSpartaRenderer [
	renderer := BlSDLSpartaRenderer for: self
]
