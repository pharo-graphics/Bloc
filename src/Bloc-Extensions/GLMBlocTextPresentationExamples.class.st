Class {
	#name : #GLMBlocTextPresentationExamples,
	#superclass : #GLMMorphicBlocRenderer,
	#category : #'Bloc-Extensions-Examples'
}

{ #category : #public }
GLMBlocTextPresentationExamples >> simple [
	<gtExample>
	^ GLMCompositePresentation new blocText; startOn: '42'
]
