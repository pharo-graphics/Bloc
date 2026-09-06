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

	| aSpace form |
	aSpace := self formBehavior
		          host: BlHeadlessHost default;
		          perform: formSelector;
		          space.
	aSpace show; settle.
	form := aSpace root aeAsForm.
	aSpace close; settle.
	^ form
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
