"
I am a special type of event handler designed to handle keyboard events in order to detect when it is time to perform a shortcut action.
All defined shortcuts are stored in ===BlShortcutRegistry=== which can be accessed using #shortcutRegistry.

I am a part of ===BlSimpleEventDispatcher=== which is a default event dispatcher in ===BlElement===
"
Class {
	#name : #BlShortcutHandler,
	#superclass : #BlBasicEventHandler,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'shortcutRegistry'
	],
	#category : 'Bloc-KeyBinding'
}

{ #category : #'private - accessing' }
BlShortcutHandler >> eventClass [ 
 	^ BlShortcutEvent
]

{ #category : #'api - event managing' }
BlShortcutHandler >> handleEvent: aShortcutEvent [
	| matchingShortcuts |

	"no process for repeated key events"
	aShortcutEvent repeat isZero
		ifFalse: [ ^ self ].

	matchingShortcuts := self shortcuts
		select: [ :aShortcut | aShortcut matches: aShortcutEvent buffer ]
		thenCollect: [ :aShortcut | aShortcut -> (aShortcut match: aShortcutEvent buffer) ].
	matchingShortcuts sort: [ :a :b | a value > b value ].

	matchingShortcuts
		ifNotEmpty: [ :theShortcuts |
			| aShortcut |
			aShortcut := theShortcuts first key.
			aShortcut action cull: aShortcut.
			aShortcutEvent consumed: true ]
]

{ #category : #initialization }
BlShortcutHandler >> initialize [
	super initialize.
	shortcutRegistry := BlShortcutRegistry new
]

{ #category : #accessing }
BlShortcutHandler >> shortcutRegistry [
	^ shortcutRegistry 
]

{ #category : #accessing }
BlShortcutHandler >> shortcuts [
	^ self shortcutRegistry shortcuts 
]

{ #category : #'api - event managing' }
BlShortcutHandler >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
