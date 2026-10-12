"
I am a host that opens spaces as OSWindow SDL2 windows.
"
Class {
	#name : #BlOSWindowSDL2Host,
	#superclass : #BlSDLHost,
	#traits : 'TBlSingletonHost',
	#classTraits : 'TBlSingletonHost classTrait',
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> driverClassName [

	^ #OSSDL2Driver
]

{ #category : #initialization }
BlOSWindowSDL2Host >> hostSpaceClass [

	^ BlOSWindowSDL2HostSpace
]

{ #category : #initialization }
BlOSWindowSDL2Host >> keyboardKeyTable [

	^ BlOSWindowSDL2KeyboardKeyTable default
]

{ #category : #accessing }
BlOSWindowSDL2Host >> label [

	^ 'SDL2'
]

{ #category : #private }
BlOSWindowSDL2Host >> newAttributesFor: aSpace [

	| theAttributes |
	theAttributes := super newAttributesFor: aSpace.
	theAttributes glAttributes:
		(OSWindowGLAttributes new
			redSize: 8;
			greenSize: 8;
			blueSize: 8;
			stencilSize: 8;
			yourself).

	^ theAttributes
]
