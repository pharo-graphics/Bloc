Class {
	#name : 'BlShortcutHandlerWithoutShortcuts',
	#superclass : 'BlShortcutHandler',
	#classInstVars : [
		'uniqueInstance'
	],
	#package : 'Bloc',
	#tag : 'Events-Handler'
}

{ #category : 'accessing' }
BlShortcutHandlerWithoutShortcuts class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlShortcutHandlerWithoutShortcuts class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'api - adding / removing' }
BlShortcutHandlerWithoutShortcuts >> addShortcut: aBlShortcut [
	"Return a shortcut handler with an added given shortcut.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ BlShortcutHandlerWithShortcuts new addShortcut: aBlShortcut
]

{ #category : 'api - event managing' }
BlShortcutHandlerWithoutShortcuts >> handleEvent: aShortcutEvent [
]

{ #category : 'api - adding / removing' }
BlShortcutHandlerWithoutShortcuts >> removeAllWithCombination: aBlKeyCombination [
	"Return a shortcut handler without all shortcuts with a given key combination.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ self
]

{ #category : 'api - adding / removing' }
BlShortcutHandlerWithoutShortcuts >> removeShortcut: aBlShortcut [
	"Return a shortcut handler without a given shortcut.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ self
]

{ #category : 'accessing' }
BlShortcutHandlerWithoutShortcuts >> shortcuts [
	<return: #Collection of: #BlBasicShortcut>

	^ #()
]

{ #category : 'api - event managing' }
BlShortcutHandlerWithoutShortcuts >> wantsEvent: anEvent [
	^ false
]
