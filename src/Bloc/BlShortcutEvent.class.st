"
Is sent by Keyboard processor to currently focused element in order to allow it to detect if any shortcuts are triggered based on currently pressed key stored in a buffer.

Public API and Key Messages

- buffer return a ===BlKeyboardBuffer=== that knows what keys are pressed at the moment.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	buffer:		<BlKeyboardBuffer>

    Implementation Points

I must be set to ===consumed=== if there was a matching shortcut.
"
Class {
	#name : #BlShortcutEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'buffer'
	],
	#category : 'Bloc-Event'
}

{ #category : #accessing }
BlShortcutEvent >> buffer [
	^ buffer
]

{ #category : #accessing }
BlShortcutEvent >> buffer: anObject [
	buffer := anObject
]

{ #category : #sending }
BlShortcutEvent >> sendTo: anObject [
	anObject shortcutEvent: self
]
