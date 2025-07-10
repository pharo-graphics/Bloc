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
		'PreferableChildrenDataStructure'
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

{ #category : #children }
Bloc class >> preferableChildrenDataStructure [
	"Answer a `BlChildrenCollection class`."

	^ PreferableChildrenDataStructure ifNil: [ self defaultChildrenDataStructure ]
]

{ #category : #children }
Bloc class >> preferableChildrenDataStructure: anChildrenCollectionClass [

	PreferableChildrenDataStructure := anChildrenCollectionClass
]

{ #category : #settings }
Bloc class >> preferencesOn: aBuilder [
	<systemsettings>

	(aBuilder group: self groupSymbolForBloc)
		label: 'Bloc';
		description: 'Bloc settings';
		parent: self groupSymbolForAppearance;
		with: [
			(aBuilder pickOne: #preferableChildrenDataStructure)
				target: self;
				order: 4;
				label: 'Preferable children data structure' ;
				domainValues: { BlChildrenArray . BlChildrenRope . BlChildrenLinkedList };
				description: 'Choose which data structure should be used to store element''s children'.

			(aBuilder setting: #assertionsEnabled)
				order: 6;
				target: self;
				label: 'Assertions';
				description: 'Set enabled to turn assertions on or disable to turn them off';
				default: [ true ].
				
			(aBuilder setting: #debugModeEnabled)
				order: 7;
				target: self;
				label: 'Debug Mode';
				description: 'Set enabled to turn extensive debugging mode on or disable to turn it off';
				default: [ false ].
		]
]

{ #category : #'world menu items' }
Bloc class >> registerBlocInWorldMenuOn: aBuilder [
	<worldMenu>

	(aBuilder item: #Bloc) 
		parent: #Tools;
		order: 778;
		label: 'Bloc';
		iconName: #image;
		help: 'Bloc is a low-level UI infrastructure & framework for Pharo.'
]

{ #category : #'world menu items' }
Bloc class >> registerGithubInWorldMenuOn: aBuilder [
	<worldMenu>

	(aBuilder item: #BlocGitHub)
		parent: #Bloc;
		order: 1;
		label: 'GitHub';
		help: 'Open Bloc GitHub page';
		iconName: #github;
		action: [ WebBrowser openOn: 'https://github.com/pharo-graphics/Bloc/' ]
]
