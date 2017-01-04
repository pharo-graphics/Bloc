private
createSDLWindowFor: aSpace
	"Note, that I use given space only to find out what window
	properties (flag) to use for created window.
	I do not create any strong or weak references to provided space"
	| flags sdlWindow x y |

	flags := aSpace isVisible
		ifTrue: [ SDL_WINDOW_SHOWN ]
		ifFalse: [ SDL_WINDOW_HIDDEN ].

	aSpace fullscreen
		ifTrue: [ flags := flags | SDL_WINDOW_FULLSCREEN_DESKTOP ].
	aSpace borderless
		ifTrue: [ flags := flags | SDL_WINDOW_BORDERLESS ].
	
	flags := flags | SDL_WINDOW_ALLOW_HIGHDPI.
	
	" Set the OpenGL attributes."
	"glAttributes := self glAttributes.
	glAttributes ifNotNil: [ 
		flags := flags | SDL_WINDOW_OPENGL.
		self setGLAttributes: glAttributes ]."
	
	"Get the actual initial position value."
	x := aSpace position x.
	y := aSpace position y.
	"attributes windowCentered ifTrue: [
		x := SDL_WINDOWPOS_CENTERED.
		y := SDL_WINDOWPOS_CENTERED ]."

	"Extra creation flags"
	aSpace resizable ifTrue: [ 
		flags := flags | SDL_WINDOW_RESIZABLE ].

	aSpace maximized ifTrue: [ 
		flags := flags | SDL_WINDOW_MAXIMIZED ].
	
	aSpace minimized ifTrue: [ 
		flags := flags | SDL_WINDOW_MINIMIZED ].

	"Create the window"
	sdlWindow := SDL2 createWindow: aSpace title
		x: x
		y: y
		width: aSpace width 
		height: aSpace height 
		flags: flags.
	
	^ sdlWindow