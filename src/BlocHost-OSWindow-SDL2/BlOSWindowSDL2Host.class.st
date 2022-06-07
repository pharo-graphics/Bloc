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

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> isRunning [
	^ PulseLoop isRunning
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> isSupported [
	^ true
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> label [
	^ 'SDL2'
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 400
]

{ #category : #accessing }
BlOSWindowSDL2Host class >> pulsePeriod: aDuration [

	PulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> start [
	PulseLoop start
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> stop [
	PulseLoop stop
]

{ #category : #'api - ui process' }
BlOSWindowSDL2Host class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	PulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #private }
BlOSWindowSDL2Host >> createHostSpace [

	^ BlOSWindowSDL2HostSpace new
]

{ #category : #initialization }
BlOSWindowSDL2Host >> keyboardKeyTable [

	^ BlOSWindowSDL2KeyboardKeyTable default
]
