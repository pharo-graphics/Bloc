"
I'm a tool to visually inspect any rendering differences between Alexandrie and Sparta.

Note: Use should select Sparta Cairo in the Bloc section of System settings.
"
Class {
	#name : #BlRenderDifferenceInspector,
	#superclass : #Object,
	#category : #'Bloc-Alexandrie-Tests-Utilities'
}

{ #category : #accessing }
BlRenderDifferenceInspector >> alexandrieFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ [aSpace aeAsForm
] onErrorDo: [ Form extent: 10 asPoint depth: 32 ]
]

{ #category : #convenience }
BlRenderDifferenceInspector >> allComparisons [
	<script: 'self new allComparisons inspect'>

	^ BlSpaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ]

]

{ #category : #accessing }
BlRenderDifferenceInspector >> pixelComparisonFor: aSymbol [
	
	^ AePixelComparison
		expectedForm: (self spartaFormFor: aSymbol)
		actualForm: (self alexandrieFormFor: aSymbol)
		label: aSymbol
]

{ #category : #accessing }
BlRenderDifferenceInspector >> spartaFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BlOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root asSpartaForm
]
