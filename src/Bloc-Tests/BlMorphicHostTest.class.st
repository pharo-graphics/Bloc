Class {
	#name : #BlMorphicHostTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #tests }
BlMorphicHostTest >> testSquaresEmbeddedInMorph [
	| aMorph aHost aSpace rootElement square1 square2 |
	aMorph := Morph new.
	aMorph extent: 400 asPoint.
	aMorph layoutPolicy: TableLayout new.
	aMorph openInWindowLabeled: 'Morphic Host Test'.
	[
		aHost := BlMorphicHost new.
		aHost containerMorph: aMorph.

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
	] ensure: [
		aMorph window ifNotNil: [ :w | w delete ] ifNil: [ aMorph delete ] ]
]
