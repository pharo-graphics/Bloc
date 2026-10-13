"
I am a host that opens spaces as OSWindow SDL3 windows.
"
Class {
	#name : #BlOSSDL3Host,
	#superclass : #BlSDLHost,
	#traits : 'TBlSingletonHost',
	#classTraits : 'TBlSingletonHost classTrait',
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'driver selection' }
BlOSSDL3Host class >> driverClassName [

	^ #OSSDL3Driver
]

{ #category : #initialization }
BlOSSDL3Host >> hostSpaceClass [

	^ BlOSSDL3SimpleHostSpace
]

{ #category : #initialization }
BlOSSDL3Host >> keyboardKeyTable [

	^ BlOSSDL3KeyTable default
]

{ #category : #accessing }
BlOSSDL3Host >> label [

	^ 'SDL3'
]
