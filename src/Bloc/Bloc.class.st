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
		'PreferableEventHandlerRegistry',
		'PreferableHostClass',
		'PreferableSpartaCanvasBuilder'
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

{ #category : #testing }
Bloc class >> hasSparta [
	^ self environment includesKey: #BlSpartaRenderer
]

{ #category : #children }
Bloc class >> preferableChildrenDataStructure [
	<return: #'BlChildrenCollection class'>

	^ PreferableChildrenDataStructure ifNil: [ self defaultChildrenDataStructure ]
]

{ #category : #children }
Bloc class >> preferableChildrenDataStructure: anChildrenCollectionClass [
	PreferableChildrenDataStructure := anChildrenCollectionClass
]

{ #category : #'event handling' }
Bloc class >> preferableEventHandlerRegistry [
	<return: #'BlHandlerRegistry class'>

	^ PreferableEventHandlerRegistry ifNil: [ self defaultEventHandlerRegistry ]
]

{ #category : #'event handling' }
Bloc class >> preferableEventHandlerRegistry: anEventHandlerRegistryClass [
	PreferableEventHandlerRegistry := anEventHandlerRegistryClass
]

{ #category : #accessing }
Bloc class >> preferableHostClass [
	^ PreferableHostClass ifNil: [ BlHost suitableHostClass ]
]

{ #category : #accessing }
Bloc class >> preferableHostClass: aHostClass [
	
	PreferableHostClass := aHostClass.
	SettingBrowser allSubInstances do: [ :aSettingsBrowser | aSettingsBrowser treeChanged: Announcement new ]
]

{ #category : #accessing }
Bloc class >> preferableSpartaCanvas [
	^ PreferableSpartaCanvasBuilder ifNil: [ (self environment at: #BlSpartaRenderer) defaultCanvasBuilder class ]
]

{ #category : #accessing }
Bloc class >> preferableSpartaCanvas: aBuilderClass [
	PreferableSpartaCanvasBuilder := aBuilderClass.
	
	"change preferable universe host according to new setting"
	(self environment at: #BlSpartaRenderer) defaultCanvasBuilder: aBuilderClass new
]

{ #category : #settings }
Bloc class >> preferencesGroup [
	^ 	#appearance
]

{ #category : #settings }
Bloc class >> preferencesOn: aBuilder [
	<systemsettings>
	(aBuilder group: #Bloc)
		label: 'Bloc';
		description: 'Bloc settings';
		parent: self preferencesGroup;
		with: [
			(aBuilder pickOne: #preferableHostClass)
				target: self;
				order: 1;
				label: 'Preferable host';
				domainValues: { 'Automatic' -> nil } , (BlHost availableHostClasses collect: [ :aHostClass | aHostClass label -> aHostClass ]);
				description: 'Choose which host to be used for opening spaces'.

			(aBuilder pickOne: #preferableSpartaCanvas)
				target: self;
				order: 2;
				precondition: [ self environment includesKey: #BlSpartaRenderer ];
				label: 'Preferable Sparta renderering backend' ;
				domainValues: ((self environment at: #BlSpartaRenderer) availableCanvasBuilderClasses collect: [ :aBuilderClass | aBuilderClass label -> aBuilderClass ]);
				description: 'Choose which graphical library should be used to render bloc spaces'.
				
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
