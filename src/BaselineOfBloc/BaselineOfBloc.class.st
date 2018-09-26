Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfBloc
}

{ #category : #baselines }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec

		baseline: 'BlocCore' with: [ spec
			repository: 'github://pharo-graphics/Bloc/src' ];

		baseline: 'BlocLayout' with: [ spec
			repository: 'github://pharo-graphics/Bloc/src' ];

		baseline: 'SpartaDevelopment' with: [ spec
			repository: 'github://syrel/Sparta/src' ];

		baseline: 'TaskIt' with: [ spec 
			repository: 'github://sbragagnolo/taskit:dev-0.5' ];

		"GT-Examples is examples and testing framework"
		baseline: 'GToolkitExamplesEngine' with: [ spec repository: 'github://feenkcom/gtoolkit-examples/src' ];

		"contains geometry elements that provide anchor and attachment points"
		package: #'Bloc-Geometry' with: [ spec requires: #(BlocCore) ];
			
		"implements a scrolling element (practically infinite) that displays large data sets"
		package: #'Bloc-Infinite' with: [ spec requires: #(BlocCore 'Bloc-Animation') ];
		"adds most common layout types for infinite element"
		package: #'Bloc-Infinite-Layouts' with: [ spec requires: #('Bloc-Infinite') ];
			
		"adds high level support of animations"
		package: #'Bloc-Animation' with: [ spec requires: #(BlocCore) ];
		package: #'Bloc-Animation-Tests' with: [ spec requires: #('Bloc-Animation' GToolkitExamplesEngine) ];

		package: #'Bloc-Text' with: [ spec requires: #(BlocCore). ];
		package: #'Bloc-Text-Rope' with: [ spec requires: #(BlocCore 'Bloc-Text'). ];
		package: #'Bloc-Text-Elements' with: [ spec requires: #(BlocCore 'Bloc-Text' 'Bloc-Text-Rope'). ];

		"Sparta provides us with a canvas and text support"
		package: #'Bloc-Sparta' with: [ spec requires: #(BlocCore 'Bloc-Text' SpartaDevelopment) ];
			
		"Provides a collection of element exporters to different formats (svg, pdf, png, jpeg, form)"
		package: #'Bloc-Exporter' with: [ spec requires: #(BlocCore 'Bloc-Sparta') ];
			
		package: #'Bloc-Examples' with: [ spec 
			requires: #(
				'GToolkitExamplesEngine'
				'BlocLayout'
				'Bloc-Geometry'
				'Bloc-Infinite'
				'Bloc-Infinite-Layouts'
				'Bloc-DevTool'
				'Bloc-Text-Elements' ) ];
		package: #'Bloc-DevTool' with: [ spec requires: #(#BlocCore #'BlocLayout'). ];
		package: #'BlocHost-Mock' with: [ spec requires: #(BlocCore) ];
		package: #'BlocHost-Morphic' with: [ spec requires: #(#BlocCore). ];  

		"Contains moldable extensions to various GT tools
			- requires sparta to perform custom rendering"
		package: #'Bloc-Extensions' with: [ spec 
			requires: #('BlocCore' 'Bloc-Sparta' 'Bloc-Animation' 'Bloc-DevTool') ];

		package: 'Bloc-TaskIt' with: [ spec
			requires: #( 'TaskIt' 'BlocCore' #'Bloc-Animation' #'Bloc-Text-Elements' ) ]
	].

	spec for: #'pharo6.x' do: [ 
		spec package: 'Bloc-DevTool-Nautilus'
	].
]
