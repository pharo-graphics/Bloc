Class {
	#name : #BlDevScripterShortcutStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'combination'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterShortcutStep >> combination [
	^ combination
]

{ #category : #accessing }
BlDevScripterShortcutStep >> combination: anObject [
	combination := anObject
]

{ #category : #actions }
BlDevScripterShortcutStep >> playOn: aScripter [
	| aTarget aBuffer anEvent |
	aTarget := self target findTargetStartingInScripter: aScripter.

	aBuffer := BlKeyboardBuffer new.
	combination asBufferKeys do: [ :eachKeyboardKey | aBuffer add: (BlKeyDownEvent new key: eachKeyboardKey) ].

	anEvent := BlShortcutEvent new
		buffer: aBuffer.

	BlEvent fireEvent: anEvent target: aTarget.

	aScripter pulse
]
