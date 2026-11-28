"
I am an abstract test case for Bloc visual regression tests using Alexandrie.
"
Class {
	#name : #BAImageMatchTest,
	#superclass : #AeImageMatchTest,
	#category : #'Bloc-Alexandrie-Tests'
}

{ #category : #accessing }
BAImageMatchTest class >> allImageSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #actions }
BAImageMatchTest class >> exportAll [
	<script: 'super exportAll'>

	super exportAll
]

{ #category : #actions }
BAImageMatchTest class >> inspectAll [
	<script: 'super inspectAll'>

	super inspectAll
]

{ #category : #actions }
BAImageMatchTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>

	super inspectMismatches
]

{ #category : #testing }
BAImageMatchTest class >> isAbstract [

	^ self == BAImageMatchTest
]

{ #category : #hooks }
BAImageMatchTest >> expectedImagesDirectory [

		| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / self expectedImagesSubdirectory
]

{ #category : #hooks }
BAImageMatchTest >> expectedImagesSubdirectory [

	self subclassResponsibility
]

{ #category : #accessing }
BAImageMatchTest >> imageBehavior [

	^ BlSpaceFixture new
]

{ #category : #hooks }
BAImageMatchTest >> settings [
	"Allow 1.5% ratio for vertical 1-pixel text baseline shifts across platform font metrics."

	imageSelector = #buildTextAttributes ifTrue: [
		^ AeImageMatchSettings colorTolerance: 0.01 maxMismatchCount: 0 maxMismatchRatio: 0.015 ].

	^ super settings
]

{ #category : #hooks }
BAImageMatchTest >> surfaceForSpace: aBlock [

	| aSpace surface |
	aSpace := self imageBehavior
		host: BlHeadlessHost default;
		perform: imageSelector;
		space.
	aSpace
		show;
		settle.
	surface := [ aBlock value: aSpace ] ensure: [ aSpace close ].
	aSpace settle.
	^ surface
]
