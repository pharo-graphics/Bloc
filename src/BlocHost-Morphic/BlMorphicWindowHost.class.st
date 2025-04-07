"
I am a host that opens spaces as windows in the Morphic World.
"
Class {
	#name : #BlMorphicWindowHost,
	#superclass : #BlMorphicSteppingHost,
	#category : #'BlocHost-Morphic-Window'
}

{ #category : #'driver selection' }
BlMorphicWindowHost class >> isSupported [

	^ true
]

{ #category : #printing }
BlMorphicWindowHost class >> label [

	^ 'Morphic'
]

{ #category : #'driver selection' }
BlMorphicWindowHost class >> priority [

	^ 20
]

{ #category : #'host - api' }
BlMorphicWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for received Bloc space"

	aSpace hostSpace: (self newHostSpaceFor: aSpace)
]

{ #category : #'host - api' }
BlMorphicWindowHost >> destroyHostSpaceFor: aSpace [

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #testing }
BlMorphicWindowHost >> isStillAvailable [

	^ self class isSupported
]

{ #category : #private }
BlMorphicWindowHost >> newHostSpaceFor: aSpace [

	^ BlMorphicWindowHostSpace new
		morphicWindow: (self newMorphicWindowFor: aSpace);
		space: aSpace;
		host: self;
		universe: self universe;
		renderer: BlHostRenderer preferableClass new;
		yourself
]

{ #category : #private }
BlMorphicWindowHost >> newMorphicWindowFor: aSpace [
	"Answer a new Morphic window based on the provided space."

	^ BlMorphicWindow new
		spaceExtent: aSpace extent;
		borderless: aSpace isBorderless;
		fullsize: aSpace isFullsize;
		title: aSpace title;
		yourself
]
