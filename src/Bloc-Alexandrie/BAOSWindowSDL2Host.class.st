"
I am a host that opens spaces as OSWindow SDL2 windows.
"
Class {
	#name : #BAOSWindowSDL2Host,
	#superclass : #BlOSWindowHost,
	#classVars : [
		'PulseLoop'
	],
	#category : #'Bloc-Alexandrie-Renderer'
}

{ #category : #'class initialization' }
BAOSWindowSDL2Host class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self
]

{ #category : #'api - lifecycle' }
BAOSWindowSDL2Host class >> isRunning [
	^ PulseLoop isRunning
]

{ #category : #'driver selection' }
BAOSWindowSDL2Host class >> isSupported [
	^ true
]

{ #category : #'driver selection' }
BAOSWindowSDL2Host class >> label [

	^ 'SDL2 Alexandrie'
]

{ #category : #'driver selection' }
BAOSWindowSDL2Host class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 401
]

{ #category : #'api - lifecycle' }
BAOSWindowSDL2Host class >> pulsePeriod: aDuration [

	PulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BAOSWindowSDL2Host class >> start [
	PulseLoop start
]

{ #category : #'api - lifecycle' }
BAOSWindowSDL2Host class >> stop [
	PulseLoop stop
]

{ #category : #'api - ui process' }
BAOSWindowSDL2Host class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #private }
BAOSWindowSDL2Host >> createHostSpace [

	^ BlOSWindowSDL2HostSpace new
]

{ #category : #'host - api' }
BAOSWindowSDL2Host >> createHostSpaceFor: aSpace [
	"Create and assign a new host space for given bloc space"

	| aHostSpace|
	aHostSpace := self createWindowSpaceFor: aSpace.
	aHostSpace renderer: BARenderer new.

	aSpace hostSpace: aHostSpace
]

{ #category : #initialization }
BAOSWindowSDL2Host >> keyboardKeyTable [

	^ BlOSWindowSDL2KeyboardKeyTable default
]

{ #category : #'host - api' }
BAOSWindowSDL2Host >> offscreenMeasureTextParagraph: aBlTextParagraph [

	BAOffscreen instance measureTextParagraph: aBlTextParagraph
]
