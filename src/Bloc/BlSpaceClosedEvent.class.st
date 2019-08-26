"
I am sent by a space after it is closed.

Example:

[[[
space := BlSpace new.
space
	addEventHandlerOn: BlSpaceClosedEvent
	do: [ self inform: 'Space closed' ].
space close
]]]
"
Class {
	#name : #BlSpaceClosedEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlSpaceClosedEvent >> space [
	<return: #BlSpace>

	^ space
]

{ #category : #accessing }
BlSpaceClosedEvent >> space: aSpace [
	space := aSpace
]
