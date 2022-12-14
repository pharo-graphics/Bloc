Class {
	#name : #BARenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #exporting }
BARenderTest class >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BARenderTest class >> deleteAllExports [
	<script: 'self deleteAllExports' >

	super deleteAllExports
]

{ #category : #convenience }
BARenderTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
BARenderTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #tests }
BARenderTest >> actualForm [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: BAOSWindowSDL2Host new; 
		perform: formSelector;
		space.
	^ aSpace aeAsForm

]

{ #category : #tests }
BARenderTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / 'render'
]

{ #category : #tests }
BARenderTest >> formBehavior [

	^ BlSpaceFixture
]
