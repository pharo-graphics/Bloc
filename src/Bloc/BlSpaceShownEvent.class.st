"
I am sent by a space after it is shown.

Example:

[[[
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceShownEvent
	do: [ self inform: 'Space shown' ].
space show
]]]

Note:
Behaves as SDL_WINDOWEVENT_SHOWN
"
Class {
	#name : #BlSpaceShownEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSpaceShownEvent >> space [
	^ space
]

{ #category : #accessing }
BlSpaceShownEvent >> space: anObject [
	space := anObject
]
