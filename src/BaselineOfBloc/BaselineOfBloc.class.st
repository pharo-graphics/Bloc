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

	spec
		for: #common
		do: [ 
			self
				declareAlexandrieOn: spec;
				declareXMLParserOn: spec.

			spec package: 'Bloc-Display'.

			spec
				package: 'Bloc'
				with: [ spec requires: #('Bloc-Display') ].

			spec
				package: 'Bloc-Animation'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Animation-Tests'
				with: [ spec requires: #('Bloc' 'Bloc-Animation') ].

			spec
				package: 'Bloc-CommandApplier'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Display-Tests'
				with: [ spec requires: #('Bloc-Display') ].

			spec
				package: 'Bloc-FocusFinder'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Layout'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Layout-Resizer'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-LayoutZoomable'
				with: [ spec requires: #('Bloc' 'Bloc-Animation' 'Bloc-Layout') ].

			spec
				package: 'Bloc-Overlay'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-PharoExtensions'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-PullAndSlide'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Infinite'
				with: [ spec requires: #('Bloc' 'Bloc-Layout' 'Bloc-PullAndSlide') ].

			spec
				package: 'Bloc-Rules'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Scalable'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Text'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Text-Rope'
				with: [ spec requires: #('Bloc' 'Bloc-Text') ].

			spec
				package: 'Bloc-Text-Elements'
				with: [ spec requires: #('Bloc' 'Bloc-Text' 'Bloc-Text-Rope') ].

			spec
				package: 'Bloc-Alexandrie'
				with: [ spec requires: #(
					'Alexandrie'
					'Bloc'
					'Bloc-Infinite'
					'Bloc-Text'
					'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-Alexandrie-Exporter'
				with: [ spec requires: #('Alexandrie' 'Bloc' 'Bloc-Alexandrie') ].

			spec
				package: 'Bloc-ColorPicker'
				with: [ spec requires: #('Bloc' 'Bloc-Layout' 'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-DragNDrop'
				with: [ spec requires: #('Bloc' 'Bloc-Animation' 'Bloc-Layout' 'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-Layout-Examples'
				with: [ spec requires: #('Bloc' 'Bloc-Layout' 'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-SVG'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Text'
					'Bloc-Text-Elements'
					'Bloc-Text-Rope'
					'XMLParser') ].

			spec
				package: 'Bloc-Alexandrie-SVG'
				with: [ spec requires: #('Bloc' 'Bloc-SVG') ].

			spec
				package: 'Bloc-Text-Examples'
				with: [ spec requires: #('Bloc-Alexandrie' 'Bloc-Text') ].

			spec
				package: 'Bloc-Text-Rope-Tests'
				with: [ spec requires: #('Bloc-Text' 'Bloc-Text-Rope') ].

			spec
				package: 'Bloc-Text-Tests'
				with: [ spec requires: #('Bloc' 'Bloc-Text') ].

			spec
				package: 'BlocHost-Mock'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Scripter'
				with: [ spec requires: #('Bloc' 'Bloc-Layout' 'BlocHost-Mock') ].

			spec
				package: 'BlocHost-Morphic'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'Bloc-Spec2'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Layout'
					'Bloc-Text'
					'Bloc-Text-Rope'
					'BlocHost-Morphic') ].

			spec
				package: 'Bloc-Demo'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Animation'
					'Bloc-DragNDrop'
					'Bloc-Layout'
					'Bloc-PullAndSlide'
					'Bloc-Spec2'
					'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-Spec2-Tests'
				with: [ spec requires: #('Bloc' 'Bloc-Spec2') ].

			spec
				package: 'BlocHost-OSWindow'
				with: [ spec requires: #('Bloc') ].

			spec
				package: 'BlocHost-OSWindow-SDL2'
				with: [ spec requires: #('Bloc' 'BlocHost-OSWindow') ].

			spec
				package: 'Bloc-Alexandrie-Tests'
				with: [ spec requires: #(
					'Alexandrie'
					'Bloc'
					'Bloc-Alexandrie'
					'Bloc-Layout'
					'Bloc-Text-Elements'
					'Bloc-Text-Examples'
					'BlocHost-OSWindow-SDL2') ].

			"Cycles ignored ('Bloc-Examples')"
			spec
				package: 'Bloc-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Text-Elements'
					'BlocHost-Mock'
					'BlocHost-Morphic'
					'BlocHost-OSWindow-SDL2') ].

			spec
				package: 'Bloc-DevTool'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Layout'
					'Bloc-Tests'
					'Bloc-Text-Elements'
					'Bloc-Text-Rope') ].

			spec
				package: 'Bloc-Examples'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Animation'
					'Bloc-DevTool'
					'Bloc-Layout'
					'Bloc-Scripter'
					'Bloc-Tests'
					'Bloc-Text'
					'Bloc-Text-Elements'
					'Bloc-Text-Rope'
					'BlocHost-Morphic') ].

			spec
				package: 'Bloc-FocusFinder-Examples'
				with: [ spec requires: #('Bloc' 'Bloc-FocusFinder' 'Bloc-Layout' 'Bloc-Tests') ].

			spec
				package: 'Bloc-Infinite-Tests'
				with: [ spec requires: #('Bloc' 'Bloc-Infinite' 'Bloc-Layout' 'Bloc-Tests') ].

			spec
				package: 'Bloc-Layout-Tests'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-DevTool'
					'Bloc-Layout'
					'Bloc-Tests'
					'Bloc-Text'
					'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-Overlay-Examples'
				with: [ spec requires: #('Bloc' 'Bloc-Overlay' 'Bloc-PullAndSlide' 'Bloc-Tests') ].

			spec
				package: 'Bloc-SVG-Tests'
				with: [ spec requires: #('Bloc' 'Bloc-Alexandrie-Tests' 'Bloc-SVG' 'Bloc-Tests') ].

			spec
				package: 'Bloc-Scalable-Examples'
				with: [ spec requires: #('Bloc' 'Bloc-Scalable' 'Bloc-Tests') ].

			spec
				package: 'Bloc-Text-Alexandrie-Examples'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Alexandrie'
					'Bloc-Layout'
					'Bloc-Tests'
					'Bloc-Text'
					'Bloc-Text-Elements') ].

			spec
				package: 'Bloc-UnitedTests'
				with: [ spec requires: #(
					'Bloc'
					'Bloc-Layout'
					'Bloc-Tests'
					'Bloc-Text'
					'Bloc-Text-Elements'
					'BlocHost-Morphic') ] ]
]

{ #category : #'external projects' }
BaselineOfBloc >> declareAlexandrieOn: spec [

	spec baseline: 'Alexandrie' with: [
		spec repository: 'github://pharo-graphics/Alexandrie:master/src' ]
]

{ #category : #'external projects' }
BaselineOfBloc >> declareXMLParserOn: spec [

	spec baseline: 'XMLParser' with: [
		spec
			repository: 'github://pharo-contributions/XML-XMLParser:master/src';
			loads: #( Core ) ]
]
