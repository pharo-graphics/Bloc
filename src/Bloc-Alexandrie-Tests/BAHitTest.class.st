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

	^ self hitFormFor: formSelector
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
BAHitTest >> hitFormFor: aSymbol [
		
	| aSpace |
	aSpace := self formBehavior
		host: BlMockedHost new;
		perform: aSymbol;
		space.

	^ self newHitFormFor: aSpace
]

{ #category : #tests }
BAHitTest >> newHitFormFor: aSpace [

	| allElements colors colorByElement aForm |
	allElements := aSpace root withAllChildrenBreadthFirst.

	colors := { Color white }, (Color wheel: allElements size - 1).
	colorByElement := IdentityDictionary newFromKeys: allElements andValues: colors.
	aForm := Form extent: aSpace extent depth: 32.
	
	1 to: aSpace width do: [ :x |
		1 to: aSpace height do: [ :y |
			| eachPosition hittedElementOrNil hittedColor |
			eachPosition := x@y.
			hittedElementOrNil := aSpace root findMouseEventTargetAt: eachPosition.
			hittedColor := colorByElement
				at: hittedElementOrNil
				ifAbsent: [ Color black ].
			aForm colorAt: eachPosition put: hittedColor ] ].

	^ aForm
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
