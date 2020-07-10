"
I represent a keyboard shortcut that can be registered to any arbitrary ===BlElement===
I consist of an Action that is evaluated when a Shortcut is triggered and ===BlKeyCombination=== that describes when shortcut should be triggered. A combination is a logical formula expression that is composed of various key combinations such as alternative, compulsory or single key. See subclasses of ===BlKeyCombination===.
Additionally, shortcut may provide its optional textual description and name.

All shortcuts of an element are stored in ===BlShortcutRegistry=== and matched / triggered by ===BlShortcutHandler===

A shortcut can be added or removed from the element by using #addShortcut: or #removeShortcut: methods.
#shortcuts message can be sent to an element in order to access a list of all registered shortcuts.

Public API and Key Messages

- combination: get /set shortcut's key combination
- action: get / set action should be executed when shortcut is triggered
- description: get / set shortcut's description text
- name: get / set a name of a shortcut

Example of a shortcut that is triggered when user presses shift + meta + arrowLeft:

   BlShortcut new
	  combination: (BlKeyCombination builder shift; meta; key: Key arrowLeft; build);
	  action: [ :aShortcutEvent :aShortcut | self inform: 'Triggered ', aShortcut combination asString ]
 
Internal Representation and Key Implementation Points.

    Instance Variables
	action:		<Object>
	combination:		<BlKeyCombination>
	description:		<Object>
	name:		<Object>
"
Class {
	#name : #BlShortcut,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'name',
		'description',
		'combination',
		'action',
		'repeatable'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlShortcut >> action [
	^ action
]

{ #category : #accessing }
BlShortcut >> action: aBlockClosure [
	"An action should be a block closure in a form [ :aShortcutEvent :aShortcut | ]"
	self
		assert: [ aBlockClosure isNotNil ]
		description: [ 'Action must not be nil' ].

	action := aBlockClosure
]

{ #category : #accessing }
BlShortcut >> combination [
	^ combination
]

{ #category : #accessing }
BlShortcut >> combination: anObject [
	combination := anObject
]

{ #category : #accessing }
BlShortcut >> description [
	^ description
]

{ #category : #accessing }
BlShortcut >> description: anObject [
	description := anObject
]

{ #category : #initialization }
BlShortcut >> initialize [
	super initialize.
	
	repeatable := true.
	action := [ :aShortcutEvent :aShortcut | ]
]

{ #category : #'key matching' }
BlShortcut >> match: anEventBuffer [
	^ self combination match: anEventBuffer
]

{ #category : #'key matching' }
BlShortcut >> matches: anKeyboardBuffer [
	| aCombinationInDNF |

	aCombinationInDNF := self combination accept: BlKeyCombinationConverterDNF new.
	^ aCombinationInDNF matches: anKeyboardBuffer
]

{ #category : #accessing }
BlShortcut >> name [
	^ name
]

{ #category : #accessing }
BlShortcut >> name: anObject [
	name := anObject
]

{ #category : #evaluation }
BlShortcut >> performDueTo: aShortcutEvent [
	self action
		cull: aShortcutEvent
		cull: self
]

{ #category : #printing }
BlShortcut >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self name ifNotNil: [ 
		aStream 
			nextPutAll: self name;
			nextPutAll: ', ' ].
	self combination printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
BlShortcut >> repeatable [
	^ repeatable
]

{ #category : #accessing }
BlShortcut >> repeatable: aBoolean [
	repeatable := aBoolean
]
