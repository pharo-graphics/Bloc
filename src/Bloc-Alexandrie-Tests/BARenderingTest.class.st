Class {
	#name : #BARenderingTest,
	#superclass : #TestCase,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #exporting }
BARenderingTest class >> exportAllFilesUsingAeCanvas [
	<script>

	BlSpaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := BlSpaceFixture new
			host: BAOSWindowSDL2Host new; 
			perform: each;
			space.
		self exportFileNamed: each with: aSpace root aeAsForm ].
	
	self inform: ('Exported files using AeCanvas')

]

{ #category : #exporting }
BARenderingTest class >> exportAllFilesUsingCurrentSpartaCanvas [
	<script>

	BlSpaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := BlSpaceFixture new
			host: BlOSWindowSDL2Host new; 
			perform: each;
			space.
		self exportFileNamed: each with: aSpace root asSpartaForm ].
	
	self inform: ('Exported files using Sparta ', Bloc preferableSpartaCanvas label)

]

{ #category : #exporting }
BARenderingTest class >> exportFileNamed: aSymbol with: aForm [ 

	| aFileName aPCRenderingTest |
	aPCRenderingTest := self new.
	aFileName := aPCRenderingTest fileNameFor: aSymbol.
	aFileName asFileReference ensureDelete.

	aForm writePNGFileNamed: aFileName
]

{ #category : #tests }
BARenderingTest >> fileNameFor: aSymbol [

	^ self filesystemResourcesDirectory / (aSymbol asString, '.png')

]

{ #category : #tests }
BARenderingTest >> filesystemResourcesDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'alexandrie' ].
	^ repo location / 'tests' 
]

{ #category : #tests }
BARenderingTest >> pixelComparisonFor: aSymbol [
	
	| aSpace expectedForm actualForm |
	expectedForm := Form fromFileNamed: (self fileNameFor: aSymbol).

	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	actualForm := aSpace root aeAsForm.

	^ BlPixelComparison
		expectedForm: expectedForm
		actualForm: actualForm
		label: aSymbol
]

{ #category : #tests }
BARenderingTest >> testAllFixtures [

	| results mismatchingResults |
	results := BlSpaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ].

	mismatchingResults := results reject: [ :each | each isMatch ].

"	DEBUG WITH:

		mismatchingResults do: [ :each | each inspect ].
"

	self assertEmpty: mismatchingResults
]
