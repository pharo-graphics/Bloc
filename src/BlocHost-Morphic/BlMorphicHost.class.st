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
	#category : #'BlocHost-Morphic-Host - Morph'
}

{ #category : #testing }
BlMorphicHost class >> isSupported [
	"I can not be used as one of the default Bloc host because I require users to provide containerMorph"

	^ false
]

{ #category : #printing }
BlMorphicHost class >> label [

	^ 'Morphic - Embedded'
]

{ #category : #testing }
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

	| aMorph aHostSpace|
	aMorph := self createMorphFor: aSpace.

	aHostSpace := BlMorphicHostSpace new
		spaceHostMorph: aMorph;
		universe: self universe;
		host: self;
		space: aSpace;
		renderer: BARenderer new;
		yourself.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlMorphicHost >> createMorphFor: aSpace [

	^ BlMorphicSpaceHostMorph new
		  color: Color transparent;
		  extent: aSpace extent;
		  yourself
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
