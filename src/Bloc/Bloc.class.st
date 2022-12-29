"
I represent bloc setting that can be customised from Menu > Settings.

I allow users to:
 - manually select preferable BlHost

"
Class {
	#name : #Bloc,
	#superclass : #Object,
	#classVars : [
		'AssertionsEnabled',
		'DebugModeEnabled',
		'PreferableChildrenDataStructure',
		'PreferableEventHandlerRegistry'
	],
	#category : #'Bloc-Settings'
}

{ #category : #assertions }
Bloc class >> assertionsEnabled [
	^ AssertionsEnabled ifNil: [ true ]
]

{ #category : #assertions }
Bloc class >> assertionsEnabled: aBoolean [
	AssertionsEnabled := aBoolean
]

{ #category : #debugging }
Bloc class >> debugModeEnabled [
	^ DebugModeEnabled ifNil: [ false ]
]

{ #category : #debugging }
Bloc class >> debugModeEnabled: aBoolean [
	DebugModeEnabled := aBoolean
]

{ #category : #children }
Bloc class >> defaultChildrenDataStructure [
	^ BlChildrenArray
]

{ #category : #'event handling' }
Bloc class >> defaultEventHandlerRegistry [
	^ BlHandlerAnnouncerRegistry
]

{ #category : #assertions }
Bloc class >> disableAssertions [
	self assertionsEnabled: false
]

{ #category : #debugging }
Bloc class >> disableDebugMode [
	self debugModeEnabled: false
]

{ #category : #assertions }
Bloc class >> enableAssertions [
	self assertionsEnabled: true
]

{ #category : #debugging }
Bloc class >> enableDebugMode [
	self debugModeEnabled: true
]

{ #category : #settings }
Bloc class >> groupSymbolForAppearance [

	^ 	#appearance
]

{ #category : #settings }
Bloc class >> groupSymbolForBloc [

	^ 	#Bloc
]

{ #category : #settings }
Bloc class >> hackyRefreshAllSettingBrowsers [

	SettingBrowser allSubInstances do: [ :aSettingsBrowser | aSettingsBrowser treeChanged: Announcement new ]
]

{ #category : #children }
Bloc class >> preferableChildrenDataStructure [
	"Answer a `BlChildrenCollection class`."

	^ PreferableChildrenDataStructure ifNil: [ self defaultChildrenDataStructure ]
]

{ #category : #children }
Bloc class >> preferableChildrenDataStructure: anChildrenCollectionClass [

	PreferableChildrenDataStructure := anChildrenCollectionClass
]

{ #category : #'event handling' }
Bloc class >> preferableEventHandlerRegistry [
	"Answer a `BlHandlerRegistry class`"

	^ PreferableEventHandlerRegistry ifNil: [ self defaultEventHandlerRegistry ]
]

{ #category : #'event handling' }
Bloc class >> preferableEventHandlerRegistry: anEventHandlerRegistryClass [

	PreferableEventHandlerRegistry := anEventHandlerRegistryClass
]

{ #category : #settings }
Bloc class >> preferencesOn: aBuilder [
	<systemsettings>
	(aBuilder group: self groupSymbolForBloc)
		label: 'Bloc';
		description: 'Bloc settings';
		parent: self groupSymbolForAppearance;
		with: [
			(aBuilder pickOne: #preferableEventHandlerRegistry)
				target: self;
				order: 3;
				label: 'Preferable event handler registry backend' ;
				domainValues: ((BlHandlerRegistry availableRegistryClasses collect: [ :aClass | aClass label -> aClass ]) sort: [ :a :b | a key < b key ]);
				description: 'Choose which data structure should be used for event handler registry'.
				
			(aBuilder pickOne: #preferableChildrenDataStructure)
				target: self;
				order: 4;
				label: 'Preferable children data structure' ;
				domainValues: { BlChildrenArray . BlChildrenRope . BlChildrenLinkedList };
				description: 'Choose which data structure should be used to store element''s children'.

			(aBuilder setting: #assertionsEnabled)
				order: 5;
				target: self;
				label: 'Assertions';
				description: 'Set enabled to turn assertions on or disable to turn them off';
				default: [ true ].
				
			(aBuilder setting: #debugModeEnabled)
				order: 6;
				target: self;
				label: 'Debug Mode';
				description: 'Set enabled to turn extensive debugging mode on or disable to turn it off';
				default: [ false ].
		]
]
