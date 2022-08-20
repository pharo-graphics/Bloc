Class {
	#name : #BAHitTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #tests }
BAHitTest >> actualFormFor: aSymbol [

	^ self hitFormFor: aSymbol host: BAOSWindowSDL2Host new
]

{ #category : #exporting }
BAHitTest >> allFormSelectors [

	^ BlSpaceFixture allFixtureSelectors
]

{ #category : #convenience }
BAHitTest >> deleteAllExports [
	<script: 'self new deleteAllExports' >

	super deleteAllExports
]

{ #category : #tests }
BAHitTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / 'hit'
]

{ #category : #convenience }
BAHitTest >> exportAll [
	<script: 'self new exportAll' >

	super exportAll
]

{ #category : #tests }
BAHitTest >> hitFormFor: aSymbol host: aHost [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: aHost;
		perform: aSymbol;
		space.

	^ BAHitFormFactory newFormFor: aSpace
]
