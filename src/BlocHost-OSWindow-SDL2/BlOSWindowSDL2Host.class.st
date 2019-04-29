Class {
	#name : #BlOSWindowSDL2Host,
	#superclass : #BlOSWindowHost,
	#category : #'BlocHost-OSWindow-SDL2'
}

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
	
	^ 40
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
