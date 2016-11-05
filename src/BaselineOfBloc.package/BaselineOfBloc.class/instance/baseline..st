as yet unclassified
baseline: spec
	<baseline>
	spec for: #common do: [ spec
			postLoadDoIt: #postLoadActions:;
		
		   baseline: 'Sparta' with: [ spec
				loads: #(#'core' );
				repository: 'github://syrel/sparta/src' ];
			
			baseline: 'TaskIt' with: [ spec
				repository: 'github://sbragagnolo/taskit-2:dev-0.3' ];
			
			project: 'OSWindow' with: [ spec
				className: #ConfigurationOfOSWindow;
				versionString: '0.8-baseline';
				repository: 'http://smalltalkhub.com/mc/Pharo/OSWindow/main/' ];
			
			project: 'PetitCSS' with: [ spec
				className: #ConfigurationOfPetitCSS;
				versionString: '1.1';
				repository: 'http://smalltalkhub.com/mc/GlennCavarle/PetitCSS/main/' ];
			 
			package: #Bloc with: [ spec requires: #(#TaskIt #Sparta). ];
			package: #'Bloc-Animation' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-DevTool' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Examples' with: [ spec requires: #(#'Bloc-Layout' #'Bloc-Style' #'Bloc-DevTool' ). ];
			package: #'Bloc-Extension' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Layout' with: [ spec requires: #(#Bloc ). ];
			package: #'Bloc-Sparta' with: [ spec requires: #(#Bloc #Sparta). ];
			package: #'Bloc-Style' with: [ spec requires: #(#Bloc #PetitCSS). ];
			package: #'Bloc-Tests' with: [ spec requires: #('Bloc-Examples' ). ];
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ]; 
			
			"groups with only sources"
			group: 'file:core' 
				with: #( 'BlocHost-OSWindow' 'Bloc-Animation' 'Bloc-Examples' 'Bloc-Sparta' 'Bloc-Extension' );
			group: 'file:development' with: #('file:core' 'Bloc-Tests');
			
			"groups with sources and plugin installation"
			group: 'core' with: #('file:core');
			group: 'development' with: #('file:development');
			
			"groups with sources, plugin installion and git support"
			group: 'git:core' with: #('core');
			group: 'git:development' with: #('development');
			
			group: 'default' with: #('core')
		].

