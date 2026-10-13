"
I am a host that opens spaces as OSWindow SDL3 GPU windows using OSSDL3GPUDriver.
"
Class {
	#name : #BlOSSDL3GPUHost,
	#superclass : #BlSDLHost,
	#traits : 'TBlSingletonHost',
	#classTraits : 'TBlSingletonHost classTrait',
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'driver selection' }
BlOSSDL3GPUHost class >> driverClassName [

	^ #OSSDL3GPUDriver
]

{ #category : #initialization }
BlOSSDL3GPUHost >> hostSpaceClass [

	^ BlOSSDL3GPUHostSpace
]

{ #category : #initialization }
BlOSSDL3GPUHost >> keyboardKeyTable [

	^ BlOSSDL3KeyTable default
]

{ #category : #accessing }
BlOSSDL3GPUHost >> label [

	^ 'SDL3 GPU'
]
