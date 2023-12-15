"
Is sent by Keyboard processor to currently focused element in order to allow it to detect if any shortcuts are triggered based on currently pressed key stored in a buffer.

Public API and Key Messages

- buffer return a `=BlKeyboardBuffer`= that knows what keys are pressed at the moment.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	buffer:		<BlKeyboardBuffer>

    Implementation Points

I must be set to `=consumed`= if there was a matching shortcut.

"
Class {
	#name : #BlShortcutEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'buffer',
		'isRepeated'
	],
	#category : 'Bloc-Events'
}

{ #category : #accessing }
BlShortcutEvent >> beRepeated [
	isRepeated := true
]

{ #category : #accessing }
BlShortcutEvent >> buffer [
	<return: #BlKeyboardBuffer>

	^ buffer
]

{ #category : #accessing }
BlShortcutEvent >> buffer: aBlKeyboardBuffer [
	buffer := aBlKeyboardBuffer
]

{ #category : #initialization }
BlShortcutEvent >> initialize [
	super initialize.
	
	isRepeated := false
]

{ #category : #accessing }
BlShortcutEvent >> isRepeated [
	"Return true if this shortcut is a repeated event giving handlers a chance to ignore such shortcuts"
	<return: #Boolean>

	^ isRepeated
]

{ #category : #sending }
BlShortcutEvent >> sendTo: anObject [
	anObject shortcutEvent: self
]
