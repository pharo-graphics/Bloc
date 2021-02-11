Class {
	#name : #BaselineOfBlocLayout,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocLayout
}

{ #category : #baseline }
BaselineOfBlocLayout >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ];
			baseline: 'BlocAnimation' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ].
		spec 
			package: #'Bloc-Layout' with: [
				spec requires: #(#BlocCore #BlocAnimation). ];
			"Layout depends also on compositor see https://github.com/pharo-graphics/Bloc/issues/87"
			
			package: #'Bloc-Layout-Tests' with: [
				spec requires: #('Bloc-Layout')];
			
			package: #'Bloc-Layout-Examples' with: [
				spec requires: #('Bloc-Layout'). ]. ].
]
