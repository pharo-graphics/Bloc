Extension { #name : 'BlPaintBackground' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlPaintBackground >> asBABackground [

	^ paint asBABackgroundAlpha: self opacity
]
