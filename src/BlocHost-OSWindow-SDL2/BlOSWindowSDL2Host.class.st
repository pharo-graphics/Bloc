Class {
	#name : #BlOSWindowSDL2Host,
	#superclass : #BlOSWindowHost,
	#classVars : [
		'PulseLoop'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'class initialization' }
BlOSWindowSDL2Host class >> initialize [
	PulseLoop := BlHostPulseLoop forHost: self
]

{ #category : #testing }
BlOSWindowSDL2Host class >> isRunning [
	^ PulseLoop isRunning
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> isSupported [
	^ true
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> label [
	^ 'OSWindow - SLD2'
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 400
]

{ #category : #testing }
BlOSWindowSDL2Host class >> start [
	PulseLoop start
]

{ #category : #testing }
BlOSWindowSDL2Host class >> stop [
	PulseLoop stop
]

{ #category : #'api - ui process' }
BlOSWindowSDL2Host class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #'host - api' }
BlOSWindowSDL2Host >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ self class isRunning
]

{ #category : #initialization }
BlOSWindowSDL2Host >> keyboardKeyTable [
	^ BlOSWindowSDL2KeyboardKeyTable default
]

{ #category : #'host - events' }
BlOSWindowSDL2Host >> pollEvents [
	
]

{ #category : #initialization }
BlOSWindowSDL2Host >> preferableDriver [
	<return: #OSWindowDriver>
	| aDriver |
	
	aDriver := OSSDL2Driver new.
	OSSDL2Driver current: aDriver.

	^ aDriver
]

{ #category : #'host - api' }
BlOSWindowSDL2Host >> start [
	self class start
]

{ #category : #'host - api' }
BlOSWindowSDL2Host >> stop [
	self class stop
]
