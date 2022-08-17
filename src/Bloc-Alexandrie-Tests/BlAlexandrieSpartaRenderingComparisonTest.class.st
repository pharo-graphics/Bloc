Class {
	#name : #BlAlexandrieSpartaRenderingComparisonTest,
	#superclass : #Object,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonTest >> alexandrieFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root aeAsForm

]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonTest >> allComparisons [
	<script: 'self new allComparisons inspect'>

	^ BlSpaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ]

]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonTest >> pixelComparisonFor: aSymbol [
	
	^ AePixelComparison
		expectedForm: (self spartaFormFor: aSymbol)
		actualForm: (self alexandrieFormFor: aSymbol)
		label: aSymbol
]

{ #category : #tests }
BlAlexandrieSpartaRenderingComparisonTest >> spartaFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BlOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root asSpartaForm

]
