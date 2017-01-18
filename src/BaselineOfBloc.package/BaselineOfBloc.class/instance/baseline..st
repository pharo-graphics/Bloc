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
			
			project: 'OSWindow' with: [ spec
				className: #ConfigurationOfOSWindow;
				versionString: '1.2.15';
				loads:#(#SDL2);
				repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];
		
		   project: 'XMLParser' with: [ spec
				className: #ConfigurationOfXMLParser;
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			
			project: 'PetitCSS' with: [ spec
				className: #ConfigurationOfPetitCSS;
				versionString: '1.1';
				repository: 'http://smalltalkhub.com/mc/GlennCavarle/PetitCSS/main/' ];
			 
			package: #Bloc with: [ spec requires: #(#Sparta). ];
			package: #'Bloc-Animation' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Examples' with: [ spec requires: #(#'Bloc-Layout' #'Bloc-DevTool' ). ];
			package: #'Bloc-Extension' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Layout' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Layout-Tests' with: [ spec requires: #(#'Bloc-Layout' ). ];
			package: #'Bloc-Infinite' with: [ spec requires: #(#'Bloc' ). ];
			package: #'Bloc-Infinite-Layouts' with: [ spec requires: #(#'Bloc' ). ];
			package: #'Bloc-Infinite-Examples' with: [ spec requires: #(#'Bloc' ). ];
			package: #'Bloc-DevTool' with: [ spec requires: #(#Bloc #'Bloc-Layout'). ];
			package: #'Bloc-Sparta' with: [ spec requires: #(#Bloc #Sparta). ];
			package: #'Bloc-Style' with: [ spec requires: #(#Bloc #PetitCSS). ];
			package: #'Bloc-Tests' with: [ spec requires: #('Bloc-Examples' ). ];
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ];
			package: #'BlocHost-SDL' with: [ spec requires: #(#Bloc #OSWindow). ];  
			package: #'Bloc-ThreadSupport' with: [ spec requires: #(#Bloc #TaskIt). ]; 
			"groups with only sources"
			group: 'file:core' 
				with: #( 'BlocHost-SDL' 'Bloc-Animation' 'Bloc-Examples' 'Bloc-Sparta' 'Bloc-Extension' );
			group: 'file:development' with: #('file:core' 'Bloc-Tests' 'Bloc-Layout-Tests');

			"groups with sources and plugin installation"
			group: 'core' with: #('file:core');
			group: 'development' with: #('file:development');
			
			"groups with sources, plugin installion and git support"
			group: 'git:core' with: #('core');
			group: 'git:development' with: #('development');
			
			group: 'stub' with: #();
			group: 'default' with: #('core')
		].

