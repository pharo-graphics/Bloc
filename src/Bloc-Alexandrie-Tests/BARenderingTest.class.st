Class {
	#name : #BARenderingTest,
	#superclass : #TestCase,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #exporting }
BARenderingTest class >> clearExports [
	<script>

	self new filesystemResourcesDirectory deleteAllChildren
]

{ #category : #exporting }
BARenderingTest class >> export: aSymbol form: aForm [ 

	| aFileName aPCRenderingTest |
	aPCRenderingTest := self new.
	aFileName := aPCRenderingTest fileNameFor: aSymbol.
	aFileName asFileReference ensureDelete.

	aForm writePNGFileNamed: aFileName
]

{ #category : #exporting }
BARenderingTest class >> exportAll [
	"Export each fixture space to disk, to be used as the expected result in the test."
	<script>

	BlSpaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := BlSpaceFixture new
			host: BAOSWindowSDL2Host new; 
			perform: each;
			space.
		self export: each form: aSpace root aeAsForm ].
	
	self inform: 'Exported files using AeCanvas'

]

{ #category : #tests }
BARenderingTest >> alexandrieFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root aeAsForm

]

{ #category : #tests }
BARenderingTest >> expectedFormFor: aSymbol [

	^ Form fromFileNamed: (self fileNameFor: aSymbol)
]

{ #category : #tests }
BARenderingTest >> fileNameFor: aSymbol [

	^ self filesystemResourcesDirectory / (aSymbol asString, '.png')

]

{ #category : #tests }
BARenderingTest >> filesystemResourcesDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ (repo location / 'tests') ensureCreateDirectory; yourself
]

{ #category : #tests }
BARenderingTest >> pixelComparisonFor: aSymbol [

	^ BlPixelComparison
		expectedForm: (self expectedFormFor: aSymbol)
		actualForm: (self alexandrieFormFor: aSymbol)
		label: aSymbol
]

{ #category : #tests }
BARenderingTest >> testAllFixtures [

	| results mismatchingResults |
	results := BlSpaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ].

	mismatchingResults := results reject: [ :each | each isMatch ].

"	INSPECT MISMATCHES WITH:

		mismatchingResults inspect
"

	self assert: mismatchingResults size equals: 0
]
