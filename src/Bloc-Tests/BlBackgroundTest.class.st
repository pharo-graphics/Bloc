Class {
	#name : #BlBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Background'
}

{ #category : #'background - builder' }
BlBackgroundTest >> testBuildBackgroundWithImagesAndColor [

	| aBackground aBuilder |	
	aBuilder := BlBackground builder.
	aBuilder image
		form: PolymorphSystemSettings pharoLogoForm;
		opacity: 0.6.
	aBuilder image
		form: (Smalltalk ui icons iconNamed: #info).
	aBuilder paint
		paint: Color gray;
		opacity: 0.2.

	aBackground := aBuilder build.

	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground backgrounds size equals: 3.

	self assert: aBackground backgrounds first opacity equals: 0.6.
	self assert: aBackground backgrounds first image bits equals: PolymorphSystemSettings pharoLogoForm bits.

	self assert: aBackground backgrounds second opacity equals: 1.0.
	self assert: aBackground backgrounds second image bits equals: (Smalltalk ui icons iconNamed: #info) bits.

	self assert: aBackground backgrounds third opacity equals: 0.2.
	self assert: aBackground backgrounds third paint color equals: Color gray.

	^ aBackground
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlCompositeBackground [

	| background |
	background := BlCompositeBackground new withAll: {
			              (BlPaintBackground new paint:
				               (BlColorPaint new color: Color blue)).
			              (BlImageBackground new image:
				               (Smalltalk ui icons iconNamed: #pharoIcon)) }.
	self assert: background equals: background.

	self
		assert: (BlCompositeBackground new withAll: {
					 (BlPaintBackground new paint:
						  (BlColorPaint new color: Color blue)).
					 (BlImageBackground new image:
						  (Smalltalk ui icons iconNamed: #pharoIcon)) })
		equals: (BlCompositeBackground new withAll: {
					 (BlPaintBackground new paint:
						  (BlColorPaint new color: Color blue)).
					 (BlImageBackground new image:
						  (Smalltalk ui icons iconNamed: #pharoIcon)) }).
	"Not the same size"
	self
		deny: (BlCompositeBackground new withAll: {
					 (BlPaintBackground new paint:
						  (BlColorPaint new color: Color blue)).
					 (BlImageBackground new image:
						  (Smalltalk ui icons iconNamed: #pharoIcon)) })
		equals: (BlCompositeBackground new withAll:
				 { (BlPaintBackground new paint:
					  (BlColorPaint new color: Color blue)) }).
	"Not the same backgrounds"
	self
		deny: (BlCompositeBackground new withAll: {
					 (BlPaintBackground new paint:
						  (BlColorPaint new color: Color blue)).
					 (BlImageBackground new image:
						  (Smalltalk ui icons iconNamed: #pharoIcon)) })
		equals: (BlCompositeBackground new withAll: {
					 (BlPaintBackground new paint:
						  (BlColorPaint new color: Color red)).
					 (BlImageBackground new image:
						  (Smalltalk ui icons iconNamed: #pharoIcon)) }).

	self
		assert: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 0.5)
		equals: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 0.5).
	"Test opacity"
	self
		assert: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 0.5)
		equals: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 0.5).
	
	self
		deny: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 1.0)
		equals: (BlCompositeBackground new
				 withAll: {
						 (BlPaintBackground new paint:
								  (BlColorPaint new color: Color blue)).
						 (BlImageBackground new image:
								  (Smalltalk ui icons iconNamed: #pharoIcon)) };
				 opacity: 0.5)
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlImageBackground [

	| background |
	background := BlImageBackground new image:
		              (Smalltalk ui icons iconNamed: #pharoIcon).
	self assert: background equals: background.

	self
		assert: (BlImageBackground new image:
				 (Smalltalk ui icons iconNamed: #pharoIcon))
		equals: (BlImageBackground new image:
				 (Smalltalk ui icons iconNamed: #pharoIcon)).
	self
		deny: (BlImageBackground new image:
				 (Smalltalk ui icons iconNamed: #pharoIcon))
		equals: (BlImageBackground new image:
				 (Smalltalk ui icons iconNamed: #smallPaint)).
	
	"Test opacity"
	self
		assert: (BlImageBackground new
				 image: (Smalltalk ui icons iconNamed: #pharoIcon);
				 opacity: 1.0;
				 yourself)
		equals: (BlImageBackground new
				 image: (Smalltalk ui icons iconNamed: #pharoIcon);
				 opacity: 1.0;
				 yourself).
	self
		deny: (BlImageBackground new
				 image: (Smalltalk ui icons iconNamed: #pharoIcon);
				 opacity: 0.5;
				 yourself)
		equals: (BlImageBackground new
				 image: (Smalltalk ui icons iconNamed: #pharoIcon);
				 opacity: 1.0;
				 yourself)
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlPaintBackground1 [

	| background |
	background := BlPaintBackground new paint:
		              (BlColorPaint new color: Color blue).
	self assert: background equals: background.

	self
		assert:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue))
		equals:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue)).
	self
		deny:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue))
		equals:
		(BlPaintBackground new paint: (BlColorPaint new color: Color red)).
	self
		assert:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue); opacity: 0.5)
		equals:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue); opacity: 0.5).
	self
		deny:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue); opacity: 1.0)
		equals:
		(BlPaintBackground new paint: (BlColorPaint new color: Color blue); opacity: 0.5).
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlPaintBackground2 [

	| background |
	background := BlPaintBackground new paint: BlTransparentPaint new.
	self assert: background equals: background.

	self
		assert: (BlPaintBackground new paint: BlTransparentPaint new)
		equals: (BlPaintBackground new paint: BlTransparentPaint new).
	self
		deny: (BlPaintBackground new
				 paint: BlTransparentPaint new;
				 opacity: 1.0)
		equals: (BlPaintBackground new
				 paint: BlTransparentPaint new;
				 opacity: 0.5)
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlPaintBackground3 [

	| background |
	background := BlPaintBackground new paint:
		              (BlLinearGradientPaint new
			               stops: {
					               (0 -> Color blue).
					               (1 -> Color red) };
			               start: 0 @ 1;
			               end: 1 @ 0).
	self assert: background equals: background.

	self
		assert: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 0))
		equals: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 0)).

	self
		deny: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color yellow).
							  (1 -> Color green) };
					  start: 0 @ 1;
					  end: 1 @ 0))
		equals: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 0)).

	self
		deny: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 1 @ 1;
					  end: 1 @ 0))
		equals: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 0)).

	self
		deny: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 0))
		equals: (BlPaintBackground new paint: (BlLinearGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  start: 0 @ 1;
					  end: 1 @ 1)).
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlPaintBackground4 [

	| background |
	background := BlPaintBackground new paint:
		              (BlRadialGradientPaint new
			               stops: {
					               (0 -> Color blue).
					               (1 -> Color red) };
			               innerCenter: 100 @ 100;
			               innerRadius: 0;
			               outerCenter: 100 @ 100;
			               outerRadius: 200).
	self assert: background equals: background.

	self
		assert: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200)).

	"stops"
	self
		deny: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color green).
							  (1 -> Color yellow) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200)).
				
					"innerCenter"
	self
		deny: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 150 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200)).
					
									"innerRadius"
	self
		deny: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 50;
					  outerCenter: 100 @ 100;
					  outerRadius: 200)).
					
								"outerCenter"
	self
		deny: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 200 @ 100;
					  outerRadius: 200)).
					
									"outerRadius"
	self
		deny: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 200))
		equals: (BlPaintBackground new paint: (BlRadialGradientPaint new
					  stops: {
							  (0 -> Color blue).
							  (1 -> Color red) };
					  innerCenter: 100 @ 100;
					  innerRadius: 0;
					  outerCenter: 100 @ 100;
					  outerRadius: 300))
]

{ #category : #'background - builder' }
BlBackgroundTest >> testEqualityBlTransparentBackground [

	| background |
	background := BlTransparentBackground new.
	self assert: background equals: background.

	self
		assert: BlTransparentBackground new
		equals: BlTransparentBackground new.
	self
		assert: (BlTransparentBackground new opacity: 0.5; yourself)
		equals: (BlTransparentBackground new opacity: 1.0; yourself)
]

{ #category : #'background - transparent' }
BlBackgroundTest >> testTransparentBackground [

	| aBackground |
	aBackground := BlTransparentBackground new.
	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 1.0.

	^ aBackground
]
