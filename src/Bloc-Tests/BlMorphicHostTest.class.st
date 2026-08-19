Class {
	#name : #BlMorphicHostTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests'
}

{ #category : #tests }
BlMorphicHostTest >> testSquaresEmbeddedInMorph [
	| aMorph aHost aSpace rootElement |
	aMorph := Morph new.
	aMorph extent: 400 asPoint.
	aMorph layoutPolicy: TableLayout new.
	aMorph openInWindowLabeled: 'Morphic Host Test'.
	[
		aHost := BlMorphicHost new.
		aHost containerMorph: aMorph.

		aSpace := BlSpace new.
		aSpace host: aHost.
		aSpace show.

		rootElement := aSpace root.
		rootElement background: Color paleBlue.
		
		"Wait for space to open/render"
		aSpace settle.

		self assert: aSpace isOpened.
		self assert: aSpace hostSpace isNotNil.
		self assert: aSpace hostSpace spaceHostMorph isNotNil.
		self assert: aSpace hostSpace spaceHostMorph form isNotNil.
		self assert: aSpace hostSpace spaceHostMorph form depth equals: 32.
		
		aSpace close.
		aSpace settle.
		self assert: aSpace isOpened not.
	] ensure: [
		aMorph window ifNotNil: [ :w | w delete ] ifNil: [ aMorph delete ] ]
]
