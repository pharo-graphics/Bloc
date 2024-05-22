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
	<script: 'super exportAll' >

	super exportAll
]

{ #category : #convenience }
BAHitTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
BAHitTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #tests }
BAHitTest >> actualForm [

	^ self hitFormFor: formSelector host: BlOSWindowSDL2Host new
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

{ #category : #tests }
BAHitTest >> testFormSelector [

	| aPixelComparison tolerance |
	aPixelComparison := self newPixelComparison.
	tolerance := 0.001.
	
	aPixelComparison mismatchingPixelRatio <= tolerance ifFalse: [
		self fuelOutMismatch: aPixelComparison ].
	
	self
		assert: aPixelComparison isMatch
		description: 'Pixel mismatch: #', formSelector.
	
"DEBUG?

		aPixelComparison inspect.

		self formMethod browse.
		
		self exportAsExpected.
"

]
