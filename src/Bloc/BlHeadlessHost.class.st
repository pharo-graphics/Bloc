"
I am a headless host that manages space lifecycles, pulse loops, layout, and event processing in-memory without opening an OS display window.
"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlPulseLoopHost,
	#traits : 'TBlSingletonHost',
	#classTraits : 'TBlSingletonHost classTrait',
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'driver selection' }
BlHeadlessHost class >> isSupported [
	"Headless host requires no display server or window manager and is always supported."

	^ true
]

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Lowest priority (highest value) so that GUI window hosts take precedence when available."

	^ 1000
]

{ #category : #accessing }
BlHeadlessHost >> label [

	^ 'Headless'
]

{ #category : #'host - api' }
BlHeadlessHost >> newHostSpaceFor: aSpace [

	^ BlHeadlessHostSpace new
		host: self;
		space: aSpace;
		renderer: self newHostRenderer;
		windowExtent: aSpace extent;
		canvasExtent: aSpace extent;
		yourself
]
