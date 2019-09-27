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
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlShortcutHandler >> addShortcut: aBlShortcut [
	self shortcuts add: aBlShortcut
]

{ #category : #'private - accessing' }
BlShortcutHandler >> eventClass [ 
 	^ BlShortcutEvent
]

{ #category : #'api - event managing' }
BlShortcutHandler >> handleEvent: aShortcutEvent [
	| matchingShortcuts |

	matchingShortcuts := self shortcuts
		select: [ :aShortcut | aShortcut matches: aShortcutEvent buffer ]
		thenCollect: [ :aShortcut | aShortcut -> (aShortcut match: aShortcutEvent buffer) ].
	matchingShortcuts sort: [ :a :b | a value > b value ].
	
	"when shortcut event is repeated we only want to process repeatable shortcuts"
	aShortcutEvent isRepeated
		ifTrue: [ matchingShortcuts := matchingShortcuts select: [ :anAssociation | anAssociation key repeatable ] ].

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
BlShortcutHandler >> removeAllWithCombination: aBlKeyCombination [
	self shortcutRegistry removeAllWithCombination: aBlKeyCombination
]

{ #category : #accessing }
BlShortcutHandler >> removeShortcut: aBlShortcut [
	self shortcutRegistry add: aBlShortcut
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
