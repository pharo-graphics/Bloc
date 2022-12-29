Class {
	#name : #BAMorphicWindowHost,
	#superclass : #BlMorphicSteppingHost,
	#category : #'Bloc-Alexandrie-Renderer'
}

{ #category : #'driver selection' }
BAMorphicWindowHost class >> isSupported [

	^ true
]

{ #category : #'driver selection' }
BAMorphicWindowHost class >> label [

	^ 'Morphic Alexandrie'
]

{ #category : #'driver selection' }
BAMorphicWindowHost class >> priority [
	"I am a default host, hence return zero.
	Morphic host is the most stable and will work on any machine"

	^ 20
]

{ #category : #'host - api' }
BAMorphicWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"

	| aWindow aHostSpace|
	aWindow := self createMorphicWindowFor: aSpace.

	aHostSpace := BlMorphicWindowHostSpace new
		morphicWindow: aWindow;
		host: self;
		universe: self universe;
		space: aSpace;
		renderer: BARenderer new;
		yourself.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BAMorphicWindowHost >> createMorphicWindowFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"

	^ BlMorphicWindow new
		spaceExtent: aSpace extent;
		borderless: aSpace borderless;
		fullsize: aSpace fullsize;
		title: aSpace title;
		yourself

]

{ #category : #'host - api' }
BAMorphicWindowHost >> destroyHostSpaceFor: aSpace [

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #testing }
BAMorphicWindowHost >> isStillAvailable [

	^ self class isSupported
]

{ #category : #'host - api' }
BAMorphicWindowHost >> offscreenMeasureTextParagraph: aBlTextParagraph [

	BAOffscreen instance measureTextParagraph: aBlTextParagraph
]
