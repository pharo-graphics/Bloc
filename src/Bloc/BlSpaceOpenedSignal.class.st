"
I am a BeaconSignal emitted when a BlSpace has been opened and shown in its universe.
I carry a reference to the opened space.
"
Class {
	#name : #BlSpaceOpenedSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space'
}

{ #category : #'instance creation' }
BlSpaceOpenedSignal class >> forSpace: aSpace [

	^ self new
		space: aSpace;
		yourself
]

{ #category : #accessing }
BlSpaceOpenedSignal >> space [

	^ space
]

{ #category : #accessing }
BlSpaceOpenedSignal >> space: aSpace [

	space := aSpace
]
