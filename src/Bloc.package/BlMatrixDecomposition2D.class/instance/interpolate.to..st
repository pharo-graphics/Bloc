matrix - mathematical functions
interpolate: aFactor to: anotherDecomposition
	"Algorithm is based on https://drafts.csswg.org/css-transforms/#interpolation-of-decomposed-2d-matrix-values"
	<return: #BlMatrixDecomposition2D>
	| aScaleX aScaleY anAngle anOtherAngle aTranslation aScale aMatrix |
	
	aScaleX := self scale x.
	aScaleY := self scale y.
	anAngle := self angle.
	anOtherAngle := anotherDecomposition angle.

	((aScaleX < 0 and: [ anotherDecomposition scale y ])
		or: [ aScaleY < 0 and: [ anotherDecomposition scale x < 0 ] ])
			ifTrue: [
				aScaleX := aScaleX negated.
				aScaleY := aScaleY negated.
				anAngle < 0
					ifTrue: [ anAngle := anAngle + 180 ]
					ifFalse: [ anAngle := anAngle - 180 ] ].
	
	"Don't rotate the long way around."
	anAngle isZero
		ifTrue: [ anAngle := 360 ].
	anOtherAngle isZero
		ifTrue: [ anOtherAngle := 360 ].

	(anAngle - anOtherAngle) abs > 180
		ifTrue: [ 
			anAngle > anOtherAngle
				ifTrue: [ anAngle := anAngle - 360 ]
				ifFalse: [ anOtherAngle := anOtherAngle - 360 ] ].
	
	"Interpolate all values."
	aTranslation := self translation + ((anotherDecomposition translation - self translation) * aFactor).
	aScale := self scale + ((anotherDecomposition scale - (BlVector x: aScaleX y: aScaleY)) * aFactor).
	anAngle := anAngle + ((anOtherAngle - anAngle) * aFactor).
	aMatrix := self matrix
		with: anotherDecomposition matrix
		collect: [ :aComponent :anOtherComponent | aComponent + ((anOtherComponent - aComponent) * aFactor) ].
	
	^ self class new
		translation: aTranslation;
		scale: aScale;
		angle: anAngle;
		matrix: aMatrix