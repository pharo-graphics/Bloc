"
# Shortcut
Represents a keyboard shortcut that can be registered to any arbitrary {{gtClass:BlElement}}.
Shortcut consist of an Action that is evaluated when a Shortcut is triggered and {{gtClass:BlKeyCombination}} that describes when shortcut should be triggered. A combination is a logical formula expression that is composed of various key combinations such as alternative, compulsory or single key. See subclasses of {{gtClass:BlKeyCombination}}.
Additionally, shortcut may provide its optional textual description and name.

All shortcuts of an element are stored in {{gtClass:BlShortcutRegistry}} and matched / triggered by {{gtClass:BlShortcutHandler}}

A shortcut can be added or removed from the element by using {{gtMethod:BlElement>>#addShortcut:}} or {{gtMethod:BlElement>>#removeShortcut:}} methods.
{{gtMethod:BlElement>>#shortcuts}} message can be sent to an element in order to access a list of all registered shortcuts.
## Public API and Key Messages

- combination: get /set shortcut's key combination

"
Class {
	#name : 'BlBasicShortcut',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'combination',
		'repeatable'
	],
	#category : 'Bloc-Events-KeyBinding',
	#package : 'Bloc',
	#tag : 'Events-KeyBinding'
}

{ #category : 'converting' }
BlBasicShortcut >> asShortcut [
	<return: #BlBasicShortcut>
	
	^ self
]

{ #category : 'accessing' }
BlBasicShortcut >> combination [
	^ combination
]

{ #category : 'accessing' }
BlBasicShortcut >> combination: anObject [
	combination := anObject
]

{ #category : 'api - combination' }
BlBasicShortcut >> combinationForMacOS [
	^ self combination
]

{ #category : 'api - combination' }
BlBasicShortcut >> combinationForPlatform [
	OSPlatform current isMacOS
		ifTrue: [ ^ self combinationForMacOS ].
		
	OSPlatform current isUnix
		ifTrue: [ ^ self combinationForUnix ].
		
	OSPlatform current isWindows
		ifTrue: [ ^ self combinationForWindows ].
		
	^ self combination
]

{ #category : 'api - combination' }
BlBasicShortcut >> combinationForUnix [
	^ self combination
]

{ #category : 'api - combination' }
BlBasicShortcut >> combinationForWindows [
	^ self combination
]

{ #category : 'accessing' }
BlBasicShortcut >> description [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
BlBasicShortcut >> initialize [
	super initialize.
	
	repeatable := true
]

{ #category : 'key matching' }
BlBasicShortcut >> match: anEventBuffer [
	^ self combinationForPlatform match: anEventBuffer
]

{ #category : 'key matching' }
BlBasicShortcut >> matches: anKeyboardBuffer [
	| aCombinationInDNF |

	aCombinationInDNF := self combinationForPlatform accept: BlKeyCombinationConverterDNF new.
	^ aCombinationInDNF matches: anKeyboardBuffer
]

{ #category : 'accessing' }
BlBasicShortcut >> name [
	^ self subclassResponsibility
]

{ #category : 'evaluation' }
BlBasicShortcut >> performDueTo: aShortcutEvent [
	self subclassResponsibility
]

{ #category : 'accessing' }
BlBasicShortcut >> repeatable [
	^ repeatable
]

{ #category : 'accessing' }
BlBasicShortcut >> repeatable: aBoolean [
	repeatable := aBoolean
]
