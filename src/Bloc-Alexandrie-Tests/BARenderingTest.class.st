Class {
	#name : #BARenderingTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #tests }
BARenderingTest >> actualFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root aeAsForm

]

{ #category : #exporting }
BARenderingTest >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BARenderingTest >> deleteAllExports [
	<script: 'self new deleteAllExports' >

	super deleteAllExports
]

{ #category : #tests }
BARenderingTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests'
]

{ #category : #convenience }
BARenderingTest >> exportAll [
	<script: 'self new exportAll' >

	super exportAll
]
