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

			baseline: 'TaskIt' with: [ spec
				repository: 'github://sbragagnolo/taskit-2:dev-0.3' ];
			
			project: 'UnifiedFFI' with: [ spec
				className: #ConfigurationOfUnifiedFFI;
				versionString: '0.25.1';
				repository: 'http://smalltalkhub.com/mc/Pharo/FFI-NB/main/' ];
			
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
			package: #'Bloc-Tests';
			
			"contains most common layout types. May be optional"
			package: #'Bloc-Layout' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-Layout-Tests' with: [ spec requires: #('Bloc-Layout' ) ];
			
			"implements a scrolling element (practically infinite) for displaying large data sets"
			package: #'Bloc-Infinite' with: [ spec requires: #(Bloc) ];
			"adds most common layout types for infinite element"
			package: #'Bloc-Infinite-Layouts' with: [ spec requires: #('Bloc-Infinite') ];
			package: #'Bloc-Infinite-Examples' with: [ spec requires: #('Bloc-Infinite' 'Bloc-Infinite-Layouts') ];
			
			"adds high level support of animations"
			package: #'Bloc-Animation' with: [ spec requires: #(Bloc) ];

			"Sparta provides us with a canvas and text support"
			package: #'Bloc-Sparta' with: [ spec requires: #(Bloc Sparta) ];

			package: #'Bloc-Examples' with: [ spec requires: #(#'Bloc-Layout' #'Bloc-DevTool' ). ];
			package: #'Bloc-Extension' with: [ spec requires: #(Bloc) ];
			package: #'Bloc-DevTool' with: [ spec requires: #(#Bloc #'Bloc-Layout'). ];
			package: #'Bloc-Style' with: [ spec requires: #(#Bloc #PetitCSS). ];
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ];
			package: #'BlocHost-SDL' with: [ spec requires: #(#Bloc #OSWindow). ];  
			package: #'Bloc-ThreadSupport' with: [ spec requires: #(#Bloc #TaskIt). ]; 

			"groups with only sources"
			group: 'file:core' with: #(
				'Bloc' "main core package"
				'Bloc-Layout'

				'BlocHost-SDL'
				'Bloc-Animation'
				'Bloc-Examples'
				'Bloc-Sparta'
				'Bloc-Extension'

				'Bloc-Infinite'
				'Bloc-Infinite-Layouts'
				'Bloc-Infinite-Examples');

			group: 'file:development' with: #('file:core' 'Bloc-Tests' 'Bloc-Layout-Tests');

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