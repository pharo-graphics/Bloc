Class {
	#name : #BlShortcutHandlerWithShortcuts,
	#superclass : #BlShortcutHandler,
	#instVars : [
		'shortcutRegistry'
	],
	#category : #'Bloc-Events-Handler'
}

{ #category : #'api - adding / removing' }
BlShortcutHandlerWithShortcuts >> addShortcut: aBlShortcut [
	"Return a shortcut handler with an added given shortcut.
	Note: We do not return a new instance in case of a handler with shortcuts"
	<return: #BlShortcutHandler>

	self shortcuts add: aBlShortcut.
	^ self
]

{ #category : #'private - accessing' }
BlShortcutHandlerWithShortcuts >> eventClass [ 
 	^ BlShortcutEvent
]

{ #category : #'api - accessing' }
BlShortcutHandlerWithShortcuts >> eventsToHandle [
	"I return a collection of element types I may be interested in"
	<return: #Collection of: #'BlEvent class'>	

	^ { BlShortcutEvent }
]

{ #category : #'api - event managing' }
BlShortcutHandlerWithShortcuts >> handleEvent: aShortcutEvent [
	| matchingShortcuts |

	matchingShortcuts := self shortcuts
		select: [ :eachShortcut | eachShortcut matches: aShortcutEvent buffer ]
		thenCollect: [ :eachShortcut | eachShortcut -> (eachShortcut match: aShortcutEvent buffer) ].
	matchingShortcuts sort: [ :a :b | a value > b value ].
	
	"when shortcut event is repeated we only want to process repeatable shortcuts"
	aShortcutEvent isRepeated
		ifTrue: [ matchingShortcuts := matchingShortcuts select: [ :anAssociation | anAssociation key repeatable ] ].

	matchingShortcuts
		ifNotEmpty: [ :theShortcuts |
			| aShortcut |
			aShortcut := theShortcuts first key.
			"let users explicitely set consumed to false so it bubbles up"
			aShortcutEvent consume.
			aShortcut performDueTo: aShortcutEvent ]
]

{ #category : #initialization }
BlShortcutHandlerWithShortcuts >> initialize [
	super initialize.

	shortcutRegistry := BlShortcutRegistry new
]

{ #category : #'api - adding / removing' }
BlShortcutHandlerWithShortcuts >> removeAllWithCombination: aBlKeyCombination [
	"Return a shortcut handler without all shortcuts with a given key combination.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	self shortcutRegistry removeAllWithCombination: aBlKeyCombination.
	
	^ self shortcutRegistry
		ifEmpty: [ BlShortcutHandlerWithoutShortcuts uniqueInstance ]
		ifNotEmpty: [ self ]
]

{ #category : #'api - adding / removing' }
BlShortcutHandlerWithShortcuts >> removeShortcut: aBlShortcut [
	"Return a shortcut handler without a given shortcut.
	Note: If after removing a given shortcut the shortcut registry is empty, return a handler
	without shortcuts"
	<return: #BlShortcutHandler>

	self shortcutRegistry
		remove: aBlShortcut
		ifAbsent: [ ^ self ].
		
	^ self shortcutRegistry
		ifEmpty: [ BlShortcutHandlerWithoutShortcuts uniqueInstance ]
		ifNotEmpty: [ self ]
]

{ #category : #accessing }
BlShortcutHandlerWithShortcuts >> shortcutRegistry [
	^ shortcutRegistry 
]

{ #category : #accessing }
BlShortcutHandlerWithShortcuts >> shortcuts [
	<return: #Collection of: #BlBasicShortcut>

	^ self shortcutRegistry shortcuts
]

{ #category : #'api - event managing' }
BlShortcutHandlerWithShortcuts >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
