"
I am a  {{gtClass:BlUniverse}} space manager.

I contain Bloc {{gtClass:BlSpace|label=spaces}} which can be added or removed. I am also responsible for sending pulses (tick) messages to my {{gtClass:BlSpace|label=spaces}}.

I am used by {{gtClass:BlUniverse}} so that it can support multiple {{gtClass:BlSpace|label=spaces}}.
Here are some of my core operations:
- {{gtMethod:BlSpaceManager>>#addSpace:}}
- {{gtMethod:BlSpaceManager>>#removeSpace:}}
- {{gtMethod:BlSpaceManager>>#pulse}} - send a pulse message to all spaces

"
Class {
	#name : 'BlSpaceManager',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'spaces'
	],
	#category : 'Bloc-Universe',
	#package : 'Bloc',
	#tag : 'Universe'
}

{ #category : 'adding' }
BlSpaceManager >> addSpace: aSpace [

	self
		assert: [ (spaces includes: aSpace) not ]
		description: [ 'Can not add space that is already managed!' ].

	spaces := spaces copyWith: aSpace
]

{ #category : 'enumerating' }
BlSpaceManager >> do: aBlock [
	self spaces do: aBlock
]

{ #category : 'testing' }
BlSpaceManager >> hasSpace: aSpace [
	"Return true if a given space is registered, false otherwise"
	<return: #Boolean>

	^ self spaces includes: aSpace
]

{ #category : 'testing' }
BlSpaceManager >> hasSpaces [
	"Return true if there are registered spaces, false otherwise"

	^ self spaces isNotEmpty
]

{ #category : 'initialization' }
BlSpaceManager >> initialize [
	super initialize.

	spaces := #()
]

{ #category : 'printing' }
BlSpaceManager >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: spaces size;
		nextPut: $)

]

{ #category : 'pulse' }
BlSpaceManager >> pulse [
	spaces do: [ :aSpace | aSpace pulse ]
]

{ #category : 'adding' }
BlSpaceManager >> removeSpace: aSpace [

	self
		assert: [ spaces includes: aSpace ]
		description: [ 'Can not remove space that is not managed!' ].

	spaces := spaces copyWithout: aSpace
]

{ #category : 'accessing' }
BlSpaceManager >> spaces [
	"Return a collection of all existing spaces"
	<return: #Array>

	^ spaces
]
