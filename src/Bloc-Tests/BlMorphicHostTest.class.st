Class {
	#name : #BlMorphicHostTest,
	#superclass : #TestCase,
	#instVars : [
		'containerMorph'
	],
	#category : #'Bloc-Tests'
}

{ #category : #running }
BlMorphicHostTest >> setUp [

	super setUp.
	containerMorph := Morph new.
	containerMorph extent: 400 asPoint.
	containerMorph layoutPolicy: TableLayout new.
	containerMorph openInWindowLabeled: 'Morphic Host Test'
]

{ #category : #running }
BlMorphicHostTest >> tearDown [

	containerMorph ifNotNil: [
		containerMorph window
			ifNotNil: [ :w | w delete ]
			ifNil: [ containerMorph delete ].
		containerMorph := nil ].
	super tearDown
]

{ #category : #tests }
BlMorphicHostTest >> testEnsureWindowOpenRendersWhenHostSpaceIsValidOnSessionChange [

	| aHost aSpace rootElement hostSpace spaceHostMorph oldForm |
	aHost := BlMorphicHost new.
	aHost containerMorph: containerMorph.

	aSpace := BlSpace new.
	aSpace host: aHost.
	rootElement := aSpace root.
	rootElement background: Color green.

	aSpace show.
	aSpace settle.
	self assert: aSpace isOpened.
	hostSpace := aSpace hostSpace.
	spaceHostMorph := hostSpace spaceHostMorph.
	self assert: spaceHostMorph form isNotNil.
	self deny: spaceHostMorph form isNull.

	"Simulate session restart nullifying the form buffer"
	oldForm := spaceHostMorph form.
	oldForm setManualSurfacePointer: ExternalAddress null.
	self assert: spaceHostMorph form isNull.

	"onSessionChanged should request pulse, redraw, and restore valid buffer"
	aSpace deferAndSettle: [ aSpace onSessionChanged ].
	self assert: aSpace isOpened.
	self assert: spaceHostMorph form isNotNil.
	self deny: spaceHostMorph form isNull.

	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened
]

{ #category : #tests }
BlMorphicHostTest >> testSpaceClosedEventOnProgrammaticClose [

	| s closedCount |
	closedCount := 0.
	s := BlSpace new.
	s useMorphicHost.
	s addEventHandlerOn: BlSpaceClosedEvent do: [ closedCount := closedCount + 1 ].
	s show; settle.
	self assert: closedCount equals: 0.

	s close; settle.
	self assert: closedCount equals: 1.
	self deny: s isOpened
]

{ #category : #tests }
BlMorphicHostTest >> testSpaceClosedEventOnWindowCloseButton [

	| s win closedCount |
	closedCount := 0.
	s := BlSpace new.
	s useMorphicHost.
	s addEventHandlerOn: BlSpaceClosedEvent do: [ closedCount := closedCount + 1 ].
	s show; settle.
	self assert: closedCount equals: 0.

	win := s hostSpace morphicWindow.
	win delete.
	s settle.
	self assert: closedCount equals: 1.
	self deny: s isOpened
]

{ #category : #tests }
BlMorphicHostTest >> testSquaresEmbeddedInMorph [

	| aHost aSpace rootElement square1 square2 |
	aHost := BlMorphicHost new.
	aHost containerMorph: containerMorph.

	aSpace := BlSpace new.
	aSpace host: aHost.

	rootElement := aSpace root.
	rootElement background: Color paleBlue.

	square1 := BlElement new
		extent: 60 @ 60;
		position: 20 @ 20;
		background: Color red;
		yourself.
	square1 addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent |
		square1 background: Color yellow ].
	square1 addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent |
		square1 background: Color red ].

	square2 := BlElement new
		extent: 60 @ 60;
		position: 100 @ 20;
		background: Color green;
		yourself.

	rootElement addChild: square1.
	rootElement addChild: square2.

	aSpace show.
	aSpace settle.
	self assert: aSpace isOpened.
	self assert: aSpace hostSpace isNotNil.
	self assert: aSpace hostSpace spaceHostMorph isNotNil.
	self assert: aSpace hostSpace spaceHostMorph form isNotNil.
	self assert: aSpace hostSpace spaceHostMorph form depth equals: 32.
	self assert: square1 background paint color equals: Color red.

	square1 eventSimulator mouseMoveInside.
	self assert: square1 background paint color equals: Color yellow.

	square1 eventSimulator mouseMoveAt: 300 @ 300.
	self assert: square1 background paint color equals: Color red.

	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened
]
