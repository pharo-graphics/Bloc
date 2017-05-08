*Bloc-Sparta
asSpartaForm
	| aCanvas anExtent aStep aPoints aMax aMin aTranslation aFactorX aFactorY aLinePainter aPreviousPoint aZeroDelta |

	anExtent := 600@400.
	aZeroDelta := 20.
	aStep := 0.001.

	aCanvas := BlSettings preferableSpartaCanvas extent: anExtent.
	aCanvas fill
		paint: Color white;
		path: aCanvas bounds;
		draw.

	aPoints := (0.0 to: 1.0 by: aStep)
		collect: [ :aNumber | aNumber -> (self interpolate: aNumber) ].
	aMax := aPoints inject: Float negativeInfinity into: [ :aMemo :anAssociation | aMemo max: anAssociation value ].
	aMin := aPoints inject: Float infinity into: [ :aMemo :anAssociation | aMemo min: anAssociation value ].

	aFactorX := anExtent x asFloat.
	aFactorY := ((anExtent y - aZeroDelta) / (aMax - aMin)) asFloat.

	aTranslation := aMin < 0
		ifTrue: [ aMin ]
		ifFalse: [ 0 ].

	aLinePainter := aCanvas stroke.
	
	aLinePainter paint: Color black.
	aLinePainter path: (SpartaLine
		from: 0 @ (anExtent y - aZeroDelta + (aTranslation * aFactorY)) rounded + 0.5
		to: anExtent x @ (anExtent y - aZeroDelta + (aTranslation * aFactorY)) rounded + 0.5).
	aLinePainter draw.
	
	aLinePainter paint: Color red.
	
	aPreviousPoint := nil.
	aPoints withIndexDo: [ :anAssociation :anIndex |
		| aPoint |
		aPoint := (aFactorX * anAssociation key) @ (anExtent y - aZeroDelta - (aFactorY * (anAssociation value - aTranslation))).
		aPreviousPoint ifNotNil: [ 
			aLinePainter path: (SpartaLine from: aPreviousPoint to: aPoint).
			aLinePainter draw ].
		aPreviousPoint := aPoint ].
	
	^ aCanvas asForm