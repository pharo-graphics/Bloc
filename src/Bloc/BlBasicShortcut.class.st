"
!Shortcut
Represents a keyboard shortcut that can be registered to any arbitrary ${class:BlElement}$.
Shortcut consist of an Action that is evaluated when a Shortcut is triggered and ${class:BlKeyCombination}$ that describes when shortcut should be triggered. A combination is a logical formula expression that is composed of various key combinations such as alternative, compulsory or single key. See subclasses of ${class:BlKeyCombination}$.
Additionally, shortcut may provide its optional textual description and name.

All shortcuts of an element are stored in ${class:BlShortcutRegistry}$ and matched / triggered by ${class:BlShortcutHandler}$

A shortcut can be added or removed from the element by using ${method:BlElement>>#addShortcut:}$ or ${method:BlElement>>#removeShortcut:}$ methods.
${method:BlElement>>#shortcuts}$ message can be sent to an element in order to access a list of all registered shortcuts.
!! Public API and Key Messages

- combination: get /set shortcut's key combination
"
Class {
	#name : #BlBasicShortcut,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'combination',
		'repeatable'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlBasicShortcut >> combination [
	^ combination
]

{ #category : #accessing }
BlBasicShortcut >> combination: anObject [
	combination := anObject
]

{ #category : #accessing }
BlBasicShortcut >> description [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlBasicShortcut >> initialize [
	super initialize.
	
	repeatable := true
]

{ #category : #'key matching' }
BlBasicShortcut >> match: anEventBuffer [
	^ self combination match: anEventBuffer
]

{ #category : #'key matching' }
BlBasicShortcut >> matches: anKeyboardBuffer [
	| aCombinationInDNF |

	aCombinationInDNF := self combination accept: BlKeyCombinationConverterDNF new.
	^ aCombinationInDNF matches: anKeyboardBuffer
]

{ #category : #accessing }
BlBasicShortcut >> name [
	^ self subclassResponsibility
]

{ #category : #evaluation }
BlBasicShortcut >> performDueTo: aShortcutEvent [
	self subclassResponsibility
]

{ #category : #accessing }
BlBasicShortcut >> repeatable [
	^ repeatable
]

{ #category : #accessing }
BlBasicShortcut >> repeatable: aBoolean [
	repeatable := aBoolean
]
