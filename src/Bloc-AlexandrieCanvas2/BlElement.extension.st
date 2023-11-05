Extension { #name : 'BlElement' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlElement >> setBABorderCenteredFigure [

	self background isTransparent
		ifTrue: [ figure := AeBorderCenterAndNoBackgroundFigure new ]
		ifFalse: [
			figure := AeBorderCenterAndBackgroundFigure new.
			figure background: self background asBABackground ].
	self geometry aeApplyTo: figure element: self.	

	figure borderBlock: [ :cairoContext | "TODO" ].
	figure strokeSource: self border paint asBAStrokeSource.
	figure strokeWidth: self border width
]

{ #category : '*Bloc-AlexandrieCanvas2' }
BlElement >> setBABorderInsideFigure [
	
	self background isTransparent
		ifTrue: [ figure := AeBorderInsideAndNoBackgroundFigure new ]
		ifFalse: [
			figure := AeBorderInsideAndBackgroundFigure new.
			figure background: self background asBABackground.
			self geometry aeApplyTo: figure element: self ].
	
	figure borderBlock: [ :cairoContext |
"		style dashArray ifNotEmpty: [ :da |
			aeCanvas setDashes: da offset: style dashOffset ].
		aBlElement geometry hasJoins ifTrue: [
			style lineJoin
				aeApplyTo: aeCanvas
				style: style ].
		(aBlElement geometry hasCaps or: [ style isDashed ]) ifTrue: [
			style lineCap aeApplyTo: aeCanvas ]." ].
	figure strokeSource: self border paint asBAStrokeSource.
	figure strokeWidth: self border width.


	self geometry
		aeApplyWithInsideBorderTo: figure
		element: self
		borderWidth: self border width
]

{ #category : '*Bloc-AlexandrieCanvas2' }
BlElement >> setBAOnlyBackgroundFigure [

	figure := AeBackgroundAndNoBorderFigure new.
	self geometry aeApplyTo: figure element: self.
	figure background: self background asBABackground.
	^ figure
]
