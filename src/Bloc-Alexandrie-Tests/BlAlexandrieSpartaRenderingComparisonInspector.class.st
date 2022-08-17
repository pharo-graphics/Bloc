Class {
	#name : #BlAlexandrieSpartaRenderingComparisonInspector,
	#superclass : #Object,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonInspector >> alexandrieFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root aeAsForm

]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonInspector >> allComparisons [
	<script: 'self new allComparisons inspect'>

	^ BlSpaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ]

]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonInspector >> pixelComparisonFor: aSymbol [
	
	^ AePixelComparison
		expectedForm: (self spartaFormFor: aSymbol)
		actualForm: (self alexandrieFormFor: aSymbol)
		label: aSymbol
]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonInspector >> spartaFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BlOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root asSpartaForm

]
