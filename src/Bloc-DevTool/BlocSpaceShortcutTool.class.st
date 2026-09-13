"
I am a tool to add and manage different shortcuts to a BlSpace.
Each shortcut is link to a tool.

To add a new tool you can subclass me and implement the following methods:
 - #defaultIndex : return a number between 1 and 12. It corresponds to the fonction key that will be used as shortcut.
 - #groupName : return a symbol that correspond to the settings group (each tool must have a unique symbol).
 - #settingDescription : return a String that correspond to the description present in the settings.
 - #settingLabel : return a String that correspond to the name of the tool in the settings.
 - #shortcutActionOn: : use the BlSpace (the argument of the method) to add the desire effect.
"
Class {
	#name : #BlocSpaceShortcutTool,
	#superclass : #Object,
	#classInstVars : [
		'shortcut',
		'enabled',
		'shortcutDomainValues'
	],
	#category : #'Bloc-DevTool-Space-tools'
}

{ #category : #'adding shortcuts' }
BlocSpaceShortcutTool class >> addShortcutOn: aBlSpace [

	self shortcut ifNil: [ self resetShortcut ].

	aBlSpace userData
		at: #devTools
		ifPresent: [ :col | col add: self ]
		ifAbsentPut: [ OrderedCollection with: self ].

	aBlSpace
		addEventHandlerOn: BlKeyDownEvent
		do: [ :evt | self executeShortcutActionOn: aBlSpace withEvent: evt ]
]

{ #category : #configuration }
BlocSpaceShortcutTool class >> defaultIndex [

	^ self explicitRequirement
]

{ #category : #accessing }
BlocSpaceShortcutTool class >> enabled [

	^ enabled
]

{ #category : #accessing }
BlocSpaceShortcutTool class >> enabled: anObject [

	enabled := anObject
]

{ #category : #'adding shortcuts' }
BlocSpaceShortcutTool class >> executeShortcutActionOn: aBlSpace withEvent: anEvent [

	self enabled ifFalse: [ ^ self ].
	anEvent key = self shortcut ifFalse: [ ^ self ].
	self shortcutActionOn: aBlSpace
]

{ #category : #configuration }
BlocSpaceShortcutTool class >> groupName [

	^ self explicitRequirement
]

{ #category : #reset }
BlocSpaceShortcutTool class >> resetAllShortcuts [

	<script>
	BlocSpaceShortcutTool subclassesDo: [ :each | each resetShortcut ]
]

{ #category : #reset }
BlocSpaceShortcutTool class >> resetShortcut [

	self shortcut:
		(BlocSpaceShortcutTool shortcutDomainValues at: self defaultIndex)
			value
]

{ #category : #settings }
BlocSpaceShortcutTool class >> rootGroupSymbol [

	^ #BlocSpaceTools
]

{ #category : #configuration }
BlocSpaceShortcutTool class >> settingDescription [

	^ self explicitRequirement
]

{ #category : #configuration }
BlocSpaceShortcutTool class >> settingLabel [

	^ self explicitRequirement
]

{ #category : #settings }
BlocSpaceShortcutTool class >> settingOn: aBuilder [

	(aBuilder group: self groupName)
		parent: self rootGroupSymbol;
		label: self settingLabel capitalized;
		description: self settingDescription.
	(aBuilder setting: #enabled)
		parent: self groupName;
		label: 'Enables ' , self settingLabel uncapitalized;
		default: true;
		target: self;
		description: 'Enables the shortcut'.
	(aBuilder pickOne: #shortcut)
		parent: self groupName;
		target: self;
		label: 'Shortcut for ' , self settingLabel uncapitalized;
		domainValues: self shortcutDomainValues;
		default:
			(BlocSpaceShortcutTool shortcutDomainValues at: self defaultIndex)
				value;
		description: 'Choose a shortcut.'
]

{ #category : #settings }
BlocSpaceShortcutTool class >> settingsRootOn: aBuilder [

	<systemsettings>
	(aBuilder group: self rootGroupSymbol)
		label: 'Bloc Space Tools';
		description: 'Bloc Space Tools settings';
		parent: Bloc groupSymbolForBloc;
		order: 9;
		with: [
				BlocSpaceShortcutTool subclasses do: [ :each |
						each settingOn: aBuilder ] ]
]

{ #category : #accessing }
BlocSpaceShortcutTool class >> shortcut [

	^ shortcut
]

{ #category : #accessing }
BlocSpaceShortcutTool class >> shortcut: anObject [

	shortcut := anObject
]

{ #category : #configuration }
BlocSpaceShortcutTool class >> shortcutActionOn: aBlSpace [

	self explicitRequirement
]

{ #category : #defaults }
BlocSpaceShortcutTool class >> shortcutDomainValues [

	^ shortcutDomainValues ifNil: [
			  shortcutDomainValues := {
				                          ('F1' -> KeyboardKey F1).
				                          ('F2' -> KeyboardKey F2).
				                          ('F3' -> KeyboardKey F3).
				                          ('F4' -> KeyboardKey F4).
				                          ('F5' -> KeyboardKey F5).
				                          ('F6' -> KeyboardKey F6).
				                          ('F7' -> KeyboardKey F7).
				                          ('F8' -> KeyboardKey F8).
				                          ('F9' -> KeyboardKey F9).
				                          ('F10' -> KeyboardKey F10).
				                          ('F11' -> KeyboardKey F11).
				                          ('F12' -> KeyboardKey F12) } ]
]

{ #category : #'see class side' }
BlocSpaceShortcutTool >> seeClassSide [ 
]
