"
I am an abstract host for OSWindow SDL-based windows. My concrete subclasses represent specific SDL versions (such as SDL2 or SDL3).
"
Class {
	#name : #BlSDLHost,
	#superclass : #BlPulseLoopHost,
	#category : #'BlocHost-OSWindow'
}

{ #category : #'driver selection' }
BlSDLHost class >> default [

	^ self supportedHostClass default
]

{ #category : #'driver selection' }
BlSDLHost class >> supportedHostClass [

	^ self allSubclasses
		detect: [ :each | each isSupported ]
		ifNone: [ self error: 'No supported SDL host for current driver' ]
]
