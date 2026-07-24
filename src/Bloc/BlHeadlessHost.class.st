"
I am a mocked host that looks like real but does not create any windows

"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlPulseLoopHost,
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
		universe: self universe;
		space: aSpace;
		renderer: self newHostRenderer;
		windowExtent: aSpace extent;
		canvasExtent: aSpace extent;
		yourself
]
