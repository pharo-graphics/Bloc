"
I am a shortcut registry and contain a collection of `=BlShortcut`=

"
Class {
	#name : 'BlShortcutRegistry',
	#superclass : 'Collection',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'shortcuts'
	],
	#category : 'Bloc-Events-Handler'
}

{ #category : 'adding / removing' }
BlShortcutRegistry >> add: aBlShortcut [
	self shortcuts add: aBlShortcut
]

{ #category : 'adding / removing' }
BlShortcutRegistry >> addAll: aCollectionOfaBlShortcut [
	self shortcuts addAll: aCollectionOfaBlShortcut
]

{ #category : 'enumerating' }
BlShortcutRegistry >> do: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument."

	self shortcuts do: aBlock
]

{ #category : 'initialization' }
BlShortcutRegistry >> initialize [
	super initialize.
	
	shortcuts := OrderedCollection new
]

{ #category : 'removing' }
BlShortcutRegistry >> remove: aBlShortcut ifAbsent: anExceptionBlock [ 
	"Remove oldObject from the receiver's elements. If several of the 
	elements are equal to oldObject, only one is removed. If no element is 
	equal to oldObject, answer the result of evaluating anExceptionBlock. 
	Otherwise, answer the argument, oldObject. ArrayedCollections cannot 
	respond to this message."

	self shortcuts remove: aBlShortcut ifAbsent: anExceptionBlock 
]

{ #category : 'removing' }
BlShortcutRegistry >> removeAllWithCombination: aBlKeyCombination [
	self shortcuts removeAllSuchThat: [ :eachShortcut | eachShortcut combination = aBlKeyCombination ]
]

{ #category : 'accessing' }
BlShortcutRegistry >> shortcuts [
	^ shortcuts
]

{ #category : 'accessing' }
BlShortcutRegistry >> shortcuts: anObject [
	shortcuts := anObject
]

{ #category : 'accessing' }
BlShortcutRegistry >> size [
	^ shortcuts size
]
