layout
align: element bounds: elementBounds in: allowedBounds
	| x y delta|
	x := element constraints horizontal alignment horizontalTranslationFor: elementBounds in: allowedBounds.
	y := element constraints vertical alignment verticalTranslationFor: elementBounds in: allowedBounds.
	delta := x @ y.
	"fast return if there is no translation needed"
	delta isZero
		ifTrue: [ ^ elementBounds ].
	^ elementBounds translateBy: x @ y