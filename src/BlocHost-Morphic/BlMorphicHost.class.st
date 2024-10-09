"
I am a host that allows users to embed a Bloc space in an arbitrary morph.

The user must set the `containerMorph` where to embed the space.

I don't support window-specific properties like `#borderless`, `#minimized` or `#maximized`.

Morphic doesn't provide sending an event when space is opened in the World.

See example in class-side.


"
Class {
	#name : #BlMorphicHost,
	#superclass : #BlMorphicSteppingHost,
	#instVars : [
		'containerMorph'
	],
	#category : #'BlocHost-Morphic-Embedded'
}

{ #category : #'driver selection' }
BlMorphicHost class >> isSupported [
	"I can not be used as one of the default Bloc host because I require users to provide containerMorph"

	^ false
]

{ #category : #printing }
BlMorphicHost class >> label [

	^ 'Morphic - Embedded'
]

{ #category : #'driver selection' }
BlMorphicHost class >> priority [
	"I have the lowest possible priority (I am also not supported)"

	^ Float infinity
]

{ #category : #accessing }
BlMorphicHost >> containerMorph [

	^ containerMorph
]

{ #category : #accessing }
BlMorphicHost >> containerMorph: aMorph [

	containerMorph := aMorph
]

{ #category : #'host - api' }
BlMorphicHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"

	aSpace hostSpace: (self newHostSpaceFor: aSpace)
]

{ #category : #'host - api' }
BlMorphicHost >> destroyHostSpaceFor: aSpace [

	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #initialization }
BlMorphicHost >> initialize [

	super initialize.

	containerMorph := Morph new
]

{ #category : #private }
BlMorphicHost >> newHostSpaceFor: aSpace [

	^ BlMorphicHostSpace new
		spaceHostMorph: (self newSpaceHostMorphFor: aSpace);
		space: aSpace;
		host: self;
		universe: self universe;
		renderer: BlHostRenderer preferableClass new;
		yourself
]

{ #category : #private }
BlMorphicHost >> newSpaceHostMorphFor: aSpace [

	^ BlMorphicSpaceHostMorph new
		extent: aSpace extent;
		yourself
]
