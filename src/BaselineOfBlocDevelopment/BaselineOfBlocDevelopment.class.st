Class {
	#name : #BaselineOfBlocDevelopment,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocDevelopment
}

{ #category : #baselines }
BaselineOfBlocDevelopment >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		baseline: 'Bloc' with: [ spec
			repository: 'github://feenkcom/Bloc/src' ];

	   baseline: 'SpartaDevelopment' with: [ spec
			repository: 'github://feenkcom/Sparta/src' ];

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
			
			"Contains a converter from SVG to Bloc"
			package: #'Bloc-SVG' with: [ spec 
				requires: #('Bloc' XMLParser) ];
			
			package: #'BlocHost-OSWindow' with: [ spec requires: #(#Bloc #OSWindow). ];
			package: #'BlocHost-SDL' with: [ spec requires: #(#Bloc #OSWindow UFFIOpenGL). ]

	]
]
