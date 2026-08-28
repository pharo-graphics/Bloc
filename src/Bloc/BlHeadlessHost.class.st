"
I am a headless host that manages space lifecycles, pulse loops, layout, and event processing in-memory without opening an OS display window.
"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlSingletonHost,
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Infinite priority means that I am selected only if there are no other available hosts"

	^ Float infinity
]

{ #category : #printing }
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
