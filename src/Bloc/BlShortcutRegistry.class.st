"
I am a shortcut registry and contain a collection of ===BlShortcut===
"
Class {
	#name : #BlShortcutRegistry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'shortcuts'
	],
	#category : 'Bloc-KeyBinding'
}

{ #category : #'adding / removing' }
BlShortcutRegistry >> add: aBlShortcut [
	self shortcuts add: aBlShortcut
]

{ #category : #'adding / removing' }
BlShortcutRegistry >> addAll: aCollectionOfaBlShortcut [
	self shortcuts addAll: aCollectionOfaBlShortcut
]

{ #category : #initialization }
BlShortcutRegistry >> initialize [
	super initialize.
	
	shortcuts := OrderedCollection new
]

{ #category : #'adding / removing' }
BlShortcutRegistry >> remove: aBlShortcut [
	self shortcuts remove: aBlShortcut
]

{ #category : #accessing }
BlShortcutRegistry >> shortcuts [
	^ shortcuts
]

{ #category : #accessing }
BlShortcutRegistry >> shortcuts: anObject [
	shortcuts := anObject
]
