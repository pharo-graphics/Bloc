"
I am a host that opens spaces as windows in the Morphic World.
"
Class {
	#name : 'BlMorphicWindowHost',
	#superclass : 'BlMorphicSteppingHost',
	#category : 'BlocHost-Morphic-Host - Window',
	#package : 'BlocHost-Morphic',
	#tag : 'Host - Window'
}

{ #category : 'driver selection' }
BlMorphicWindowHost class >> isSupported [

	^ true
]

{ #category : 'printing' }
BlMorphicWindowHost class >> label [

	^ 'Morphic'
]

{ #category : 'driver selection' }
BlMorphicWindowHost class >> priority [

	^ 20
]

{ #category : 'host - api' }
BlMorphicWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"

	| aWindow aHostSpace|
	aWindow := self createMorphicWindowFor: aSpace.

	aHostSpace := BlMorphicWindowHostSpace new
		morphicWindow: aWindow;
		host: self;
		universe: self universe;
		space: aSpace;
		renderer: BlHostRenderer preferableClass new;
		yourself.

	aSpace hostSpace: aHostSpace
]

{ #category : 'private' }
BlMorphicWindowHost >> createMorphicWindowFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"

	^ BlMorphicWindow new
		spaceExtent: aSpace extent;
		borderless: aSpace borderless;
		fullsize: aSpace fullsize;
		title: aSpace title;
		yourself

]

{ #category : 'host - api' }
BlMorphicWindowHost >> destroyHostSpaceFor: aSpace [

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : 'testing' }
BlMorphicWindowHost >> isStillAvailable [

	^ self class isSupported
]
