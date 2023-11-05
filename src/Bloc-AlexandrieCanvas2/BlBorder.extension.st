Extension { #name : 'BlBorder' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlBorder >> setBAFigureWithBackgroundOn: aBlElement [
	
	self haltIf: aBlElement background isTransparent. "not implemented"

	self isTransparent
		ifTrue: [ aBlElement setBAOnlyBackgroundFigure ]
		ifFalse: [
			aBlElement geometry isClosed
				ifTrue: [
					aBlElement outskirts
						setBABorderedFigureOn: aBlElement ]
				ifFalse: [
					aBlElement setBAOpenFigureFrom: self ] ]
]
