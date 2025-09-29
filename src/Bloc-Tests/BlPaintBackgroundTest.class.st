Class {
	#name : #BlPaintBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Background'
}

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorBackground [

	| aBackground |
	aBackground := Color gray asBlBackground.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorBackgroundExplicitInitializationWithPaint [

	| aBackground |
	aBackground :=
		BlPaintBackground new
			paint: (BlColorPaint color: Color gray);
			yourself.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorBackgroundExplicitInstantiationWithColor [

	| aBackground |
	aBackground := BlPaintBackground paint: Color gray.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorBackgroundExplicitInstantiationWithPaint [

	| aBackground |
	aBackground := BlPaintBackground paint: (BlColorPaint color: Color gray).

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorWithLowOpacityBackground [
	
	| aBackground |
	aBackground := Color blue asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.2.
	self deny: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color blue
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testGrayColorWithZeroOpacityBackground [

	| aBackground |
	aBackground := Color blue asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color blue
]

{ #category : #'background - gradient' }
BlPaintBackgroundTest >> testLinearGradientBackground [

	| aBackground |
	aBackground :=
		BlPaintBackground new
			paint: (BlLinearGradientPaint new
				stops: { 0 -> Color red. 1 -> Color blue };
				start: 0@0;
				end: 100@100);
			yourself.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2
]

{ #category : #'background - gradient' }
BlPaintBackgroundTest >> testLinearGradientBackgroundWithOpacity [

	| aBackground |
	aBackground :=
		BlPaintBackground new
			paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color red. 1 -> Color blue};
					start: 0@0;
					end: 100@100;
					yourself);
			opacity: 0.2;
			yourself.

	self assert: aBackground opacity equals: 0.2.
	self deny: aBackground isTransparent.
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2
]

{ #category : #'background - gradient' }
BlPaintBackgroundTest >> testLinearPaintBackground [

	| aBackground |
	aBackground :=
		BlPaintBackground new
			paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color red . 1 -> Color blue};
					start: 0@0;
					end: 100@100;
					yourself);
			yourself.

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2
]

{ #category : #'background - gradient' }
BlPaintBackgroundTest >> testRadiusGradientBackground [

	| aBackground |
	aBackground :=
		BlPaintBackground paint:
			(BlRadialGradientPaint new
				stops: { 0 -> Color blue. 1 -> Color red };
				innerCenter: 100@100;
				innerRadius: 0;
				outerCenter: 100@100;
				outerRadius: 200;
				yourself).

	self assert: aBackground opacity equals: 1.0.
	self deny: aBackground isTransparent.
	self assert: aBackground paint innerCenter equals: 100@100.
	self assert: aBackground paint outerRadius  equals: 200.
	self assert: aBackground paint stops size equals: 2
]

{ #category : #'background - color' }
BlPaintBackgroundTest >> testTransparentColorBackground [
	
	| aBackground |
	aBackground := Color transparent asBlBackground.
	
	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color transparent
]
