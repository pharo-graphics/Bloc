"
I am a Universe space manager.

I contain Bloc spaces, can add or remove them. I am also responsible for sending pulses(tick) messages to spaces I know.

I am used by Universe in order to provide support of multiple spaces within the Universe.

- addSpace: add a space
- removeSpace: remove a given space
- clear close all spaces
- pulse send pulse message to all spaces

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	spaces:		<Object>


    Implementation Points
"
Class {
	#name : #BlSpaceManager,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'spaces'
	],
	#category : #'Bloc-Universe'
}

{ #category : #adding }
BlSpaceManager >> addSpace: aSpace [

	self
		assert: [ (spaces includes: aSpace) not ]
		description: [ 'Can not add space that is already managed!' ].

	spaces := spaces copyWith: aSpace
]

{ #category : #testing }
BlSpaceManager >> hasSpace: aSpace [
	"Return true if a given space is registered, false otherwise"
	<return: #Boolean>

	^ self spaces includes: aSpace
]

{ #category : #testing }
BlSpaceManager >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"
	<return: #Boolean>

	^ self spaces isNotEmpty
]

{ #category : #initialization }
BlSpaceManager >> initialize [
	super initialize.

	spaces := #()
]

{ #category : #pulse }
BlSpaceManager >> pulse [
	spaces do: [ :aSpace | aSpace pulse ]
]

{ #category : #adding }
BlSpaceManager >> removeSpace: aSpace [

	self
		assert: [ spaces includes: aSpace ]
		description: [ 'Can not remove space that is not managed!' ].

	spaces := spaces copyWithout: aSpace
]

{ #category : #accessing }
BlSpaceManager >> spaces [
	"Return a collection of all existing spaces"
	<return: #Array>

	^ spaces
]
