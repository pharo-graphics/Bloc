Class {
	#name : #BlSDL3GPUHostDemo,
	#superclass : #Object,
	#category : #'BlocHost-OSWindow-SDL3-Tests'
}

{ #category : #examples }
BlSDL3GPUHostDemo class >> openGPURendererSpace [
	<script>
	| space element text originalRendererClass |
	
	"Temporarily use the GPU renderer for this demo"
	originalRendererClass := BlOSSDL3Renderer defaultClass.
	BlOSSDL3Renderer defaultClass: BlOSSDL3GPURenderer.
	
	space := BlSpace new.
	space extent: 600 @ 400.
	space title: 'Bloc SDL3 GPU Host Demo'.
	space host: BlOSSDL3Host new.

	element := BlElement new
		extent: 200 @ 200;
		background: Color blue;
		position: 100 @ 100;
		yourself.

	text := BlTextElement new
		text: ('Hello SDL3 GPU Host' asRopedText
			fontSize: 24;
			foreground: Color white);
		position: 20 @ 20.

	element addChild: text.

	element addEventHandler: (BlEventHandler
		on: BlMouseDownEvent
		do: [ :evt | element background: Color red ]).

	element addEventHandler: (BlEventHandler
		on: BlMouseUpEvent
		do: [ :evt | element background: Color blue ]).

	space root addChild: element.
	
	"Restore the original renderer class after creating the space"
	space addEventHandler: (BlEventHandler
		on: BlSpaceClosedEvent
		do: [ :evt | BlOSSDL3Renderer defaultClass: originalRendererClass ]).
		
	space show.
	^ space
]

{ #category : #examples }
BlSDL3GPUHostDemo class >> openSimpleSpace [
	<script>
	| space element text originalRendererClass |
	
	"Temporarily use the GPU renderer for this demo"
	originalRendererClass := BlOSSDL3Renderer defaultClass.
	BlOSSDL3Renderer defaultClass: BlOSSDL3SimpleRenderer.
	
	space := BlSpace new.
	space extent: 600 @ 400.
	space title: 'Bloc SDL3 GPU Host Demo'.
	space host: BlOSSDL3Host new.

	element := BlElement new
		extent: 200 @ 200;
		background: Color blue;
		position: 100 @ 100;
		yourself.

	text := BlTextElement new
		text: ('Hello SDL3 GPU Host' asRopedText
			fontSize: 24;
			foreground: Color white);
		position: 20 @ 20.

	element addChild: text.

	element addEventHandler: (BlEventHandler
		on: BlMouseDownEvent
		do: [ :evt | element background: Color red ]).

	element addEventHandler: (BlEventHandler
		on: BlMouseUpEvent
		do: [ :evt | element background: Color blue ]).

	space root addChild: element.
	
	"Restore the original renderer class after creating the space"
	space addEventHandler: (BlEventHandler
		on: BlSpaceClosedEvent
		do: [ :evt | BlOSSDL3Renderer defaultClass: originalRendererClass ]).
		
	space show.
	^ space
]
