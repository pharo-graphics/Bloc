Class {
	#name : #BARenderTest,
	#superclass : #AePixelMatchTest,
	#category : 'Bloc-Alexandrie-Tests-Base'
}

{ #category : #exporting }
BARenderTest class >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BARenderTest class >> exportAll [
	<script: 'super exportAll' >

	super exportAll
]

{ #category : #convenience }
BARenderTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
BARenderTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #hooks }
BARenderTest >> actualForm [
		
	| aSpace |
	aSpace := self formBehavior
		host: BlOSWindowSDL2Host new; 
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

	^ BlSpaceFixture new
]
