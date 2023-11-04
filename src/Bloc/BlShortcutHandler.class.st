"
I am a special type of event handler designed to handle keyboard events in order to detect when it is time to perform a shortcut action.
All defined shortcuts are stored in `=BlShortcutRegistry`= which can be accessed using #shortcutRegistry.

I am a part of `=BlDirectEventDispatcher`=

"
Class {
	#name : 'BlShortcutHandler',
	#superclass : 'BlBasicEventHandler',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#package : 'Bloc',
	#tag : 'Events-Handler'
}

{ #category : 'api - adding / removing' }
BlShortcutHandler >> addShortcut: aBlShortcut [
	"Return a shortcut handler with an added given shortcut.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ self subclassResponsibility
]

{ #category : 'api - event managing' }
BlShortcutHandler >> handleEvent: aShortcutEvent [
	self subclassResponsibility
]

{ #category : 'api - adding / removing' }
BlShortcutHandler >> removeAllWithCombination: aBlKeyCombination [
	"Return a shortcut handler without all shortcuts with a given key combination.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ self subclassResponsibility
]

{ #category : 'api - adding / removing' }
BlShortcutHandler >> removeShortcut: aBlShortcut [
	"Return a shortcut handler without a given shortcut.
	Note: The returned instance may or may not be the same as the receiver"
	<return: #BlShortcutHandler>

	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlShortcutHandler >> shortcuts [
	<return: #Collection of: #BlBasicShortcut>

	^ self subclassResponsibility
]

{ #category : 'api - event managing' }
BlShortcutHandler >> wantsEvent: anEvent [
	^ self subclassResponsibility
]
