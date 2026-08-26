"
I am a host that opens spaces as windows in the Morphic World.
"
Class {
	#name : #BlMorphicWindowHost,
	#superclass : #BlMorphicSteppingHost,
	#category : #'BlocHost-Morphic-Window'
}

{ #category : #testing }
BlMorphicWindowHost class >> isSingleton [
	^ true
]

{ #category : #'driver selection' }
BlMorphicWindowHost class >> isSupported [

	^ UIManager default className = #MorphicUIManager
]

{ #category : #'driver selection' }
BlMorphicWindowHost class >> priority [

	^ 20
]

{ #category : #printing }
BlMorphicWindowHost >> label [

	^ 'Morphic'
]

{ #category : #private }
BlMorphicWindowHost >> newHostSpaceFor: aSpace [

	^ BlMorphicWindowHostSpace new
		morphicWindow: (self newMorphicWindowFor: aSpace);
		space: aSpace;
		host: self;
		renderer: self newHostRenderer;
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
