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

			"GT-Examples is examples and testing framework"
			project: 'GTExamples' with: [ spec
				className: #ConfigurationOfGTExamples;
				loads: #('GT-Examples');
				repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ];

			baseline: 'TaskIt' with: [ spec
				repository: 'github://sbragagnolo/taskit-2:dev-0.3' ];

			project: 'OSWindow' with: [ spec
				className: #ConfigurationOfOSWindow;
				versionString: '1.2.16';
				loads:#(#SDL2);
				repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];
		
		   project: 'XMLParser' with: [ spec
				className: #ConfigurationOfXMLParser;
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			
			project: 'PetitCSS' with: [ spec
				className: #ConfigurationOfPetitCSS;
				versionString: '1.1';
				repository: 'http://smalltalkhub.com/mc/GlennCavarle/PetitCSS/main/' ];
			
			"main core package, implements element composition, event handling and universe infrastructure.
			*core* must not depend on anything"
			package: #Bloc;
			package: #'Bloc-Tests' with: [ spec requires: #(Bloc GTExamples) ];
	
			"contains most common layout types. May be optional"
			package: #'Bloc-Layout' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-Layout-Tests' with: [ spec requires: #('Bloc-Layout' GTExamples) ];

			"contains geometry elements that provide anchor and attachment points"
			package: #'Bloc-Geometry' with: [ spec requires: #(Bloc) ];
			
			"implements a scrolling element (practically infinite) that displays large data sets"
			package: #'Bloc-Infinite' with: [ spec requires: #(Bloc) ];
			"adds most common layout types for infinite element"
			package: #'Bloc-Infinite-Layouts' with: [ spec requires: #('Bloc-Infinite') ];
			package: #'Bloc-Infinite-Examples' with: [ spec requires: #('Bloc-Infinite' 'Bloc-Infinite-Layouts' GTExamples) ];
			
			"adds high level support of animations"
			package: #'Bloc-Animation' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-Animation-Tests' with: [ spec requires: #('Bloc-Animation' GTExamples) ];

			package: #'Bloc-Text' with: [ spec requires: #(Bloc). ];
			package: #'Bloc-Text-Rope' with: [ spec requires: #(Bloc 'Bloc-Text'). ];
			package: #'Bloc-Text-Rope-Examples' with: [ spec requires: #(Bloc 'Bloc-Text' 'Bloc-Text-Rope' GTExamples). ];
			
			"Sparta provides us with a canvas and text support"
			package: #'Bloc-Sparta' with: [ spec requires: #(Bloc 'Bloc-Text' Sparta) ];
			
			package: #'Bloc-Examples' with: [ spec requires: #(#'Bloc-Layout' #'Bloc-DevTool' GTExamples). ];
			package: #'Bloc-Extension' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-DevTool' with: [ spec requires: #(#Bloc #'Bloc-Layout'). ];
			package: #'Bloc-Style' with: [ spec requires: #(#Bloc #PetitCSS). ];
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ];
			package: #'BlocHost-SDL' with: [ spec requires: #(#Bloc #OSWindow). ];  
			package: #'BlocHost-Morphic' with: [ spec requires: #(#Bloc). ];  
			package: #'Bloc-ThreadSupport' with: [ spec requires: #(#Bloc #TaskIt). ]; 

			"groups with only sources"
			group: 'file:core' with: #(
				'Bloc' "main core package"
				'Bloc-Geometry'
				'Bloc-Layout'
				'Bloc-Text'
				'Bloc-Text-Rope'

				'BlocHost-SDL'
				'BlocHost-Morphic'
				'Bloc-Animation'
				'Bloc-Examples'
				'Bloc-Sparta'
				'Bloc-Extension'

				'Bloc-Infinite'
				'Bloc-Infinite-Layouts'
				'Bloc-Infinite-Examples');

			group: 'file:development' with: #(
				'file:core'
				'Bloc-Tests'
				'Bloc-Text-Tests'
				'Bloc-Layout-Tests'
				'Bloc-Animation-Tests');

			"groups with sources and plugin installation"
			group: 'core' with: #('file:core');
			group: 'development' with: #('file:development');

			"groups with sources, plugin installion and git support"
			group: 'git:core' with: #('core');
			group: 'git:development' with: #('development');

			group: 'stub' with: #();
			group: 'default' with: #('core');
			
			"below we define groups to load only specific packages in order to test dependencies"
			group: 'minimal:bloc' with: #(Bloc 'Bloc-Tests');
			group: 'minimal:bloc+layout' with: #('minimal:bloc' 'Bloc-Layout' 'Bloc-Layout-Tests')
		]