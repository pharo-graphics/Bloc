baselines
baseline: spec
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
]
