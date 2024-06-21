"
I'm a shortcut with action.

I extend `BlBasicShortcut` with ability to specify a runtime action that should be evaluated when shortcut is performed.
In addition to that, shortcuts with action allow users to customise the name and description of the shortcut.

## Public API and Key Messages

- action: get / set action should be executed when shortcut is triggered
- description: get / set shortcut's description text
- name: get / set a name of a shortcut

## Example of a shortcut that is triggered when user presses shift + meta + arrowLeft:
```
BlShortcutWithAction new
	combination: (BlKeyCombination builder shift; meta; key: KeyboardKey left; build);
	action: [ :aShortcutEvent :aShortcut |
		self inform: 'Triggered ', aShortcut combination asString ]
```

"
Class {
	#name : #BlShortcutWithAction,
	#superclass : #BlBasicShortcut,
	#instVars : [
		'name',
		'description',
		'action'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlShortcutWithAction >> action [
	^ action
]

{ #category : #accessing }
BlShortcutWithAction >> action: aBlockClosure [
	"An action should be a block closure in a form [ :aShortcutEvent :aShortcut | ]"

	action := aBlockClosure
]

{ #category : #accessing }
BlShortcutWithAction >> description [
	^ description
]

{ #category : #accessing }
BlShortcutWithAction >> description: anObject [
	description := anObject
]

{ #category : #initialization }
BlShortcutWithAction >> initialize [
	super initialize.

	action := [ :aShortcutEvent :aShortcut | ]
]

{ #category : #accessing }
BlShortcutWithAction >> name [
	^ name
]

{ #category : #accessing }
BlShortcutWithAction >> name: anObject [
	name := anObject
]

{ #category : #evaluation }
BlShortcutWithAction >> performDueTo: aShortcutEvent [
	self action
		cull: aShortcutEvent
		cull: self
]

{ #category : #printing }
BlShortcutWithAction >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self name ifNotNil: [ 
		aStream 
			nextPutAll: self name;
			nextPutAll: ', ' ].
	self combination printOn: aStream.
	aStream nextPut: $).
]
