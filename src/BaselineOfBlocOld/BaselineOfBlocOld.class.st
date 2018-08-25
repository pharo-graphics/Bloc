Class {
	#name : #BaselineOfBlocOld,
	#superclass : #BaselineOf,
	#instVars : [
		'group'
	],
	#category : #BaselineOfBlocOld
}

{ #category : #baselines }
BaselineOfBlocOld >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
			preLoadDoIt:  #preLoadActions:;
			postLoadDoIt: #postLoadBloc:;
		   baseline: 'Sparta' with: [ spec
				postLoadDoIt: #postLoadSparta:;
				loads: #(stub); "Stub does not load anything here. We load sparta in postLoadSparta:"
				repository: 'github://syrel/sparta/src' ];

		   baseline: 'Beacon' with: [ spec repository: 'github://pharo-project/pharo-beacon/repository' ];

			"GT-Examples is examples and testing framework"
			baseline: 'GToolkitExamplesEngine' with: [ spec repository: 'github://feenkcom/gtoolkit-examples/src' ];

			project: 'OSWindow' with: [ spec
				className: #ConfigurationOfOSWindow;
				versionString: #'stable';
				loads: #(WithOpenGL);
				repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];

			project: 'UFFIOpenGL' with: [
				spec
					className: #ConfigurationOfUFFIOpenGL;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/UFFIOpenGL/main/' ];
			
			"XMLParser is needed to parse svg files"	
			project: 'XMLParser' with: [ spec
				className: #ConfigurationOfXMLParser;
				versionString: #'stable';
				loads: #('Core');
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			
			"main core package, implements element composition, event handling and universe infrastructure.
			*core* must not depend on anything"
			package: #Bloc;
			package: #'Bloc-Tests' with: [ spec requires: #(Bloc GToolkitExamplesEngine 'BlocHost-Mock') ];
	
			"contains most common layout types. May be optional"
			package: #'Bloc-Layout' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-Layout-Tests' with: [ spec requires: #('Bloc-Layout' GToolkitExamplesEngine) ];

			"contains geometry elements that provide anchor and attachment points"
			package: #'Bloc-Geometry' with: [ spec requires: #(Bloc) ];
			
			"implements a scrolling element (practically infinite) that displays large data sets"
			package: #'Bloc-Infinite' with: [ spec requires: #(Bloc 'Bloc-Animation') ];
			"adds most common layout types for infinite element"
			package: #'Bloc-Infinite-Layouts' with: [ spec requires: #('Bloc-Infinite') ];
			
			"adds high level support of animations"
			package: #'Bloc-Animation' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-Animation-Tests' with: [ spec requires: #('Bloc-Animation' GToolkitExamplesEngine) ];

			package: #'Bloc-Text' with: [ spec requires: #(Bloc). ];
			package: #'Bloc-Text-Rope' with: [ spec requires: #(Bloc 'Bloc-Text'). ];
			package: #'Bloc-Text-Elements' with: [ spec requires: #(Bloc 'Bloc-Text' 'Bloc-Text-Rope'). ];

			"Contains a converter from SVG to Bloc"
			package: #'Bloc-SVG' with: [ spec requires: #('Bloc' 'Bloc-Geometry' 'Bloc-Text' 'Bloc-Text-Rope' XMLParser) ];
	
			"Sparta provides us with a canvas and text support"
			package: #'Bloc-Sparta' with: [ spec requires: #(Bloc 'Bloc-Text' Sparta) ];
			
			"Provides a collection of element exporters to different formats (svg, pdf, png, jpeg, form)"
			package: #'Bloc-Exporter' with: [ spec requires: #(Bloc 'Bloc-Sparta') ];
			
			package: #'Bloc-Examples' with: [
				spec requires: #(
					'Bloc-Geometry'
					'Bloc-Layout'
					'Bloc-Infinite'
					'Bloc-Infinite-Layouts'
					'Bloc-DevTool'
					'Bloc-Text-Elements'
					GToolkitExamplesEngine). ];
			package: #'Bloc-DevTool' with: [ spec requires: #(#Bloc #'Bloc-Layout'). ];
			package: #'BlocHost-Mock' with: [ spec requires: #(Bloc) ];
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ];
			package: #'BlocHost-SDL' with: [ spec requires: #(#Bloc #OSWindow UFFIOpenGL). ];
			package: #'BlocHost-Morphic' with: [ spec requires: #(#Bloc). ];  

			"Contains moldable extensions to various GT tools
				- requires sparta to perform custom rendering"
			package: #'Bloc-Extensions' with: [ spec requires: #('Bloc' 'Bloc-Sparta' 'Bloc-Animation' 'Bloc-DevTool') ];
			
			"groups with only sources"
			group: 'core' with: #(
				'Bloc' "main core package"
				'Bloc-Geometry'
				'Bloc-Layout'
				'Bloc-Text'
				'Bloc-Text-Rope'
				'Bloc-Text-Elements'
				
				"core only loads very basic stuff"
				'BlocHost-Morphic'
				'Bloc-Animation'
				'Bloc-Examples'
				'Bloc-Sparta'
				'Bloc-Infinite'
				'Bloc-Infinite-Layouts'
				
				"Exporters"
				'Bloc-Exporter'
				
				"GToolkit Extensions"
				'Bloc-Extensions'
				
				"tests"
				'Bloc-Tests'
				'Bloc-Layout-Tests'
				'Bloc-Animation-Tests');

			group: 'development' with: #(
				'core'
				'Beacon'
				'BlocHost-OSWindow'
				'BlocHost-SDL'
				'Bloc-SVG');

			group: 'stub' with: #();
			group: 'default' with: #('core');
			
			"below we define groups to load only specific packages in order to test dependencies"
			group: 'minimal:bloc' with: #(Bloc 'Bloc-Tests');
			group: 'minimal:bloc+layout' with: #('minimal:bloc' 'Bloc-Layout' 'Bloc-Layout-Tests')
	].

	spec for: #'pharo6.x' do: [ 
		spec package: 'Bloc-DevTool-Nautilus'
	].
]

{ #category : #private }
BaselineOfBlocOld >> directive [
	"Return current group's directive as symbol.
	For example if group is #'git:development' I return #'git' "
	<return: #Symbol>
	self
		assert: [ self hasDirective ]
		description: [ 'Group must have directive in order to query for it' ].
		
	^ (group first: (group indexOf: $:) - 1) asSymbol
]

{ #category : #private }
BaselineOfBlocOld >> group [
	"Return a loading group requested by user.
	Group is initialized during preLoadActions:"
	<return: #Symbol>
	
	^ group
]

{ #category : #private }
BaselineOfBlocOld >> groupOf: aSpecLoader [
	"Return a requested group to load. It may be prefixed with file: or git:"
	<return: #Symbol>

	^ (aSpecLoader spec required difference: aSpecLoader spec packages keys) asArray first asSymbol
]

{ #category : #private }
BaselineOfBlocOld >> hasDirective [
	"Return true if there is a special directive defined by group prefix.
	For example if group is 'git:development', then directive is 'git' and I return true.
	If group is just 'core', which means there is no directive I return false"
	<return: #Boolean>
	
	^ (group indexOf: $:) > 0
]

{ #category : #private }
BaselineOfBlocOld >> isMinimal [
	"Return true if we are loading a minimal version with manually selected packages"
	<return: #Boolean>

	^ self hasDirective
		and: [ self directive = #minimal ]
]

{ #category : #private }
BaselineOfBlocOld >> load: aBaselineName from: aRepository [
	"I choose appropriate loading method for a baseline from repository
	depending on requested directive"
	| aDirective |

	"we load code only using metacello, not actions needed"
	self hasDirective
		ifFalse: [ ^ self ].
	
	aDirective := self directive.
	
	"we do nothing for minimal directive"
	aDirective = #minimal
		ifTrue: [ ^ self ].

	Warning signal: 'Unknown load directive ' , aDirective asString
]

{ #category : #actions }
BaselineOfBlocOld >> postLoadBloc: aSpecLoader [

	self
		load: 'Bloc'
		from: aSpecLoader spec versionSpec repositories map keys first.

	"Make sure that external structures have valid accessors"
	Author
		useAuthor: 'UFFI'
		during: [ FFIExternalStructure withAllSubclassesDo: #rebuildFieldAccessors ].

	"register right Meta key for OSX"
	Key macOSVirtualKeyTable
		at: 16r36 put: (Key value: 16rffe8). "  kVK_Command_R = 0x36"
]

{ #category : #actions }
BaselineOfBlocOld >> postLoadSparta: aSpecLoader [
	"Let sparta load as it wish"
	| aGroup |

	"For minimal directive we just need core sparta functionality"
	aGroup := self isMinimal
		ifTrue: [ #core ]
		ifFalse: [ self group ].

	OSPlatform current isUnix64
		"on Unix64 always load development version of Sparta"
		ifTrue: [ aGroup := #development ].

	OSPlatform current isMacOS
		"on OSX always load development version of Sparta"
		ifTrue: [ aGroup := #development ].

	OSPlatform current isWindows
		"on Windows we should always load Moz2D"
		ifTrue: [ aGroup := #development ].

	Metacello new
		baseline: aSpecLoader spec name;
		repository: aSpecLoader spec repositories map keys first;
		load: aGroup
]

{ #category : #actions }
BaselineOfBlocOld >> preLoadActions: aSpecLoader [
	"Extract requested group from spec loader to work with during loading"

	group := self groupOf: aSpecLoader
]

{ #category : #private }
BaselineOfBlocOld >> target [
	"Return current group's target as symbol.
	For example if group is #'git:development' I return #'development'"
	<return: #Symbol>
		
	^ (group last: group size - (group indexOf: $:)) asSymbol
]
