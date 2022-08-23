Class {
	#name : #BARenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #tests }
BARenderTest >> actualFormFor: aSymbol [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: aSymbol;
		space.
	^ aSpace root aeAsForm

]

{ #category : #exporting }
BARenderTest >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BARenderTest >> deleteAllExports [
	<script: 'self new deleteAllExports' >

	super deleteAllExports
]

{ #category : #tests }
BARenderTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / 'render'
]

{ #category : #convenience }
BARenderTest >> exportAll [
	<script: 'self new exportAll' >

	super exportAll
]
