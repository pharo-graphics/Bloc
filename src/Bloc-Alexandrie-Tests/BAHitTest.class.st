Class {
	#name : #BAHitTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #exporting }
BAHitTest class >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BAHitTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
BAHitTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #convenience }
BAHitTest class >> inspectMismatches [
	<script: 'self inspectMismatches' >

	super inspectMismatches
]

{ #category : #tests }
BAHitTest >> actualForm [

	^ self hitFormFor: formSelector host: BAOSWindowSDL2Host new
]

{ #category : #tests }
BAHitTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / 'hit'
]

{ #category : #tests }
BAHitTest >> formBehavior [

	^ BlSpaceFixture new
]

{ #category : #tests }
BAHitTest >> hitFormFor: aSymbol host: aHost [
		
	| aSpace |
	aSpace := self formBehavior
		host: aHost;
		perform: aSymbol;
		space.

	^ BAHitFormFactory newFormFor: aSpace
]
