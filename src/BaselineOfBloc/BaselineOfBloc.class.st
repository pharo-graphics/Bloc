"
This Baseline contains the code for Bloc that may be included in the future in Pharo. 
It retrofits a part of the development made at http://github.com/feenkcom/bloc.
This version will focus on core features and stability.
We are currently identifying the core we want for Pharo.

See BaselineOfBloc for more information about Bloc in general.

"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfBloc
}

{ #category : #baselines }
BaselineOfBloc >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Bloc-Display"
		spec
			package: 'Bloc-Display';
			package: 'Bloc-Display-Tests'
			with: [ spec requires: #( 'Bloc-Display' ) ].

		"Core"
		spec
			package: #Bloc with: [ spec requires: #( 'Bloc-Display' ) ];
			package: #'BlocHost-Mock' with: [ spec requires: #( #Bloc ) ];
			package: #'Bloc-Tests'
			with: [ spec requires: #( #Bloc 'BlocHost-Mock' ) ].

		"Add-ons"
		spec
			package: #'Bloc-PullAndSlide' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-FocusFinder' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-Overlay' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-Scalable' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-CommandApplier' with: [ spec requires: #( 'Bloc' ) ].

		"Animation"
		spec
			package: #'Bloc-Animation' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-Animation-Tests'
			with: [ spec requires: #( 'Bloc-Animation' ) ].

		"Morphic host"
		spec
			package: #'BlocHost-Morphic'
			with: [ spec requires: #( 'Bloc' ) ].

		"OSWindow host"
		spec
			package: #'BlocHost-OSWindow' with: [ spec requires: #( 'Bloc' ) ];
			package: #'BlocHost-OSWindow-SDL2'
			with: [ spec requires: #( 'BlocHost-OSWindow' ) ].

		"Text"
		spec
			package: #'Bloc-Text' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-Text-Rope'
			with: [ spec requires: #( 'Bloc' 'Bloc-Text' ) ];
			package: #'Bloc-Text-Elements'
			with: [
				spec requires: #( 'Bloc' 'Bloc-Text' 'Bloc-Layout-Resizer' ) ];
			package: #'Bloc-Text-Rope-Tests'
			with: [ spec requires: #( 'Bloc-Text-Rope' ) ];
			package: #'Bloc-Text-Tests'
			with: [ spec requires: #( 'Bloc-Text' ) ].

		"Alexandrie canvas"
		self declareAlexandrieOn: spec.
		spec
			package: #'Bloc-Alexandrie'
			with: [
				spec requires:
						#( 'Alexandrie' 'Bloc' 'Bloc-Text' 'Bloc-Infinite' ) ];
			package: #'Bloc-Alexandrie-Tests'
			with: [ spec requires: #( 'Bloc-Alexandrie' 'Bloc-Text-Examples' ) ];
			package: #'Bloc-Text-Alexandrie-Examples'
			with: [ spec requires: #( 'Bloc-Alexandrie' 'Bloc-Layout' ) ].
		"Exporters depend on Alexandrie"
		spec
			package: #'Bloc-Alexandrie-Exporter'
			with: [ spec requires: #( 'Bloc-Alexandrie' ) ].

		"Layout"
		spec
			package: #'Bloc-Layout' with: [ spec requires: #( 'Bloc' ) ];
			package: #'Bloc-Layout-Resizer'
			with: [ spec requires: #( 'Bloc-Layout' ) ];
			package: #'Bloc-LayoutZoomable'
			with: [ spec requires: #( 'Bloc-Layout' 'Bloc-Animation' ) ].
		"Layout depends also on compositor. See https://github.com/pharo-graphics/Bloc/issues/87"

		"Infinite"
		spec package: #'Bloc-Infinite' with: [ spec requires: #( 'Bloc' ) ].

		"Development tools, examples and tests"
		spec
			package: #'Bloc-Spec2';
			package: #'Bloc-PharoExtensions';
			package: #'Bloc-Spec2-Tests'
			with: [ spec requires: #( 'Bloc-Spec2' ) ].
		spec
			package: #'Bloc-UnitedTests'
			with: [ spec requires: #( 'Bloc' 'Bloc-Layout' 'Bloc-Animation' ) ];
			package: #'Bloc-DevTool'
			with: [ spec requires: #( 'Bloc-Layout' 'Bloc-UnitedTests' ) ];
			package: #'Bloc-Scripter' with: [
				spec requires:
						#( 'Bloc-Layout' 'BlocHost-Mock' 'Bloc-UnitedTests' ) ];
			package: #'Bloc-Examples'
			with: [ spec requires: #( #'Bloc-DevTool' ) ];
			package: #'Bloc-Text-Examples'
			with: [ spec requires: #( #'Bloc-Examples' ) ];
			package: #'Bloc-Infinite-Tests'
			with: [ spec requires: #( 'Bloc-Infinite' ) ];
			package: #'Bloc-Layout-Tests'
			with: [
				spec requires: #( 'Bloc-Layout' 'Bloc-Text' 'Bloc-DevTool' ) ];
			package: #'Bloc-Layout-Examples'
			with: [ spec requires: #( 'Bloc-Layout' 'Bloc-Text-Elements' ) ];
			package: #'Bloc-Overlay-Examples'
			with: [ spec requires: #( 'Bloc-Overlay' ) ];
			package: #'Bloc-Scalable-Examples'
			with: [ spec requires: #( 'Bloc-Scalable' ) ];
			package: #'Bloc-FocusFinder-Examples'
			with: [ spec requires: #( 'Bloc-FocusFinder' ) ].

		spec package: #'Bloc-Rules' with: [ spec requires: #( #Bloc ) ].

		spec package: #'Bloc-Demo' with: [
			spec requires:
				#( #'Bloc-Layout' #'Bloc-Spec2' #'Bloc-Text-Elements' ) ].
		spec package: #'Bloc-DragNDrop' with: [ spec requires: #( #Bloc ) ].
		spec package: #'Bloc-ColorPicker' with: [ spec requires: #( #Bloc ) ].

		"SVG"
		self declareXMLParserOn: spec.
		spec
			package: #'Bloc-SVG'
			with: [ spec requires: #( #Bloc #XMLParser ) ];
			package: #'Bloc-SVG-Tests'
			with: [ spec requires: #( #'Bloc-SVG' ) ];
			package: #'Bloc-Alexandrie-SVG'
			with: [ spec requires: #( #'Bloc-Alexandrie' #'Bloc-SVG' ) ] ]
]

{ #category : #baselines }
BaselineOfBloc >> declareAlexandrieOn: spec [

	spec baseline: 'Alexandrie' with: [
		spec repository: 'github://pharo-graphics/Alexandrie:v2.5.0/src' ]
]

{ #category : #baselines }
BaselineOfBloc >> declareXMLParserOn: spec [

	spec baseline: 'XMLParser' with: [
		spec
			repository: 'github://pharo-contributions/XML-XMLParser:v3.6.2/src';
			loads: #( Core ) ]
]
