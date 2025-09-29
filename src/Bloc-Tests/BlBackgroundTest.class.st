Class {
	#name : #BlBackgroundTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Basic-Background'
}

{ #category : #asserting }
BlBackgroundTest >> assert: anObject equalsAndHasSameHash: anotherObject [
	
	self assert: anObject equals: anotherObject.
	self assert: anObject hash equals: anotherObject hash
]

{ #category : #running }
BlBackgroundTest >> newOpaqueSquaredForm [

	| form |
	form := self newTransparentSquaredForm.
	form fillGray.
	form getCanvas
		fillRectangle: (10 @ 10 corner: 40 @ 40)
		color: Color blue.

	^ form
]

{ #category : #running }
BlBackgroundTest >> newTransparentSquaredForm [

	^ Form extent: 50 @ 50 depth: 32
]

{ #category : #testing }
BlBackgroundTest >> testBuildBackgroundWithImagesAndColor [

	| aBackground aBuilder |	
	aBuilder := BlBackground builder.
	aBuilder image
		form: self newOpaqueSquaredForm;
		opacity: 0.6.
	aBuilder image
		form: self newTransparentSquaredForm.
	aBuilder paint
		paint: Color gray;
		opacity: 0.2.

	aBackground := aBuilder build.

	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground backgrounds size equals: 3.

	self assert: aBackground backgrounds first opacity equals: 0.6.
	self assert: aBackground backgrounds first image bits equals: self newOpaqueSquaredForm bits.

	self assert: aBackground backgrounds second opacity equals: 1.0.
	self assert: aBackground backgrounds second image bits equals: self newTransparentSquaredForm bits.

	self assert: aBackground backgrounds third opacity equals: 0.2.
	self assert: aBackground backgrounds third paint color equals: Color gray.

	^ aBackground
]

{ #category : #testing }
BlBackgroundTest >> testCompositeBackgroundAsFormSmokeTest [

	| background blElement backgroundList |
	backgroundList := OrderedCollection with: (BlBackground paint: Color blue).
	background := BlCompositeBackground withAll: backgroundList.
	blElement := BlElement new background: background; yourself.

	blElement asForm "smoke test"
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfColorPaintBackground [

	| background |
	background := BlPaintBackground paint: (BlColorPaint color: Color blue).
	self assert: background equalsAndHasSameHash: background.

	self
		assert: (BlPaintBackground paint: (BlColorPaint color: Color blue))
		equalsAndHasSameHash: (BlPaintBackground paint: (BlColorPaint color: Color blue)).
	self
		deny: (BlPaintBackground paint: (BlColorPaint color: Color blue))
		equals: (BlPaintBackground paint: (BlColorPaint color: Color red)).
	self
		assert:
			(BlPaintBackground new
				 paint: (BlColorPaint color: Color blue);
				 opacity: 0.5;
				 yourself)
		equalsAndHasSameHash:
			(BlPaintBackground new
				 paint: (BlColorPaint color: Color blue);
				 opacity: 0.5;
				 yourself).
	self
		deny:
			(BlPaintBackground new
				 paint: (BlColorPaint color: Color blue);
				 opacity: 1.0;
				 yourself)
		equals:
			(BlPaintBackground new
				 paint: (BlColorPaint color: Color blue);
				 opacity: 0.5;
				 yourself)
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfCompositeBackground [

	| form background |
	form := self newOpaqueSquaredForm.

	background :=
		BlCompositeBackground withAll: {
			(BlColorPaint color: Color blue) asBlBackground.
			form asBlBackground }.
	self assert: background equalsAndHasSameHash: background.

	self
		assert:
			(BlCompositeBackground withAll: {
				(BlPaintBackground paint:
					(BlColorPaint color: Color blue)).
				(BlImageBackground image: form) })
		equalsAndHasSameHash:
			(BlCompositeBackground withAll: {
				(BlPaintBackground paint:
					 (BlColorPaint color: Color blue)).
				(BlImageBackground image: form) }).
	"Not the same size"
	self
		deny: (BlCompositeBackground withAll: {
				(BlPaintBackground paint:
					 (BlColorPaint color: Color blue)).
				(BlImageBackground image: form) })
		equals: (BlCompositeBackground withAll:
			{ (BlPaintBackground paint:
				 (BlColorPaint color: Color blue)) }).
	"Not the same backgrounds"
	self
		deny: (BlCompositeBackground withAll: {
				(BlPaintBackground paint:
					 (BlColorPaint color: Color blue)).
				(BlImageBackground image: form) })
		equals: (BlCompositeBackground withAll: {
				(BlPaintBackground paint:
					 (BlColorPaint color: Color red)).
				(BlImageBackground image: form) }).

	self
		assert: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
							 (BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 0.5)
		equalsAndHasSameHash: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
							 (BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 0.5).
	"Test opacity"
	self
		assert: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
						(BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 0.5)
		equalsAndHasSameHash: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
						(BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 0.5).

	self
		deny: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
						(BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 1.0)
		equals: (BlCompositeBackground new
			withAll: {
					(BlPaintBackground paint:
						(BlColorPaint color: Color blue)).
					(BlImageBackground image: form) };
			opacity: 0.5)
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfImageBackground [

	| background form |
	form := self newOpaqueSquaredForm.

	background := BlImageBackground image: form.
	self assert: background equalsAndHasSameHash: background.

	"Note: Form inherits identity equals from Object."
	self
		assert: (BlImageBackground image: form)
		equalsAndHasSameHash: (BlImageBackground image: form).
	self
		deny: (BlImageBackground image: form)
		equals: (BlImageBackground image: self newOpaqueSquaredForm).

	"Test opacity"
	self
		assert:
			(BlImageBackground new
				image: form;
				opacity: 1.0;
				yourself)
		equalsAndHasSameHash:
			(BlImageBackground new
				image: form;
				opacity: 1.0;
				yourself).
	self
		deny:
			(BlImageBackground new
				image: form;
				opacity: 0.5;
				yourself)
		equals:
			(BlImageBackground new
				image: form;
				opacity: 1.0;
				yourself)
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfLinearPaintBackground [

	| background |
	background :=
		BlPaintBackground paint:
			(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself).
	self assert: background equalsAndHasSameHash: background.

	self
		assert:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself))
		equalsAndHasSameHash:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself)).

	self
		deny:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color yellow. 1 -> Color green };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself)).

	self
		deny:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 1 @ 1;
					end: 1 @ 0;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself)).

	self
		deny:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 0;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlLinearGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					start: 0 @ 1;
					end: 1 @ 1;
					yourself))
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfRadialPaintBackground [

	| background |
	background :=
		BlPaintBackground paint:
			(BlRadialGradientPaint new
				stops: { 0 -> Color blue. 1 -> Color red };
				innerCenter: 100 @ 100;
				innerRadius: 0;
				outerCenter: 100 @ 100;
				outerRadius: 200;
				yourself).
	self assert: background equalsAndHasSameHash: background.

	self
		assert:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself))
		equalsAndHasSameHash:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself)).

	"stops"
	self
		deny:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color green. 1 -> Color yellow };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself)).

	"innerCenter"
	self
		deny:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 150 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself)).

	"innerRadius"
	self
		deny:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 50;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself)).

	"outerCenter"
	self
		deny:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200;
					yourself))
		equals:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 200 @ 100;
					outerRadius: 200;
					yourself)).

	"outerRadius"
	self
		deny:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 200))
		equals:
			(BlPaintBackground paint:
				(BlRadialGradientPaint new
					stops: { 0 -> Color blue. 1 -> Color red };
					innerCenter: 100 @ 100;
					innerRadius: 0;
					outerCenter: 100 @ 100;
					outerRadius: 300);
					yourself)
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfTransparentBackground [

	| background |
	background := BlTransparentBackground new.
	self assert: background equalsAndHasSameHash: background.

	self
		assert: BlTransparentBackground new
		equalsAndHasSameHash: BlTransparentBackground new.
	self
		assert: (BlTransparentBackground new opacity: 0.5; yourself)
		equalsAndHasSameHash: (BlTransparentBackground new opacity: 1.0; yourself)
]

{ #category : #testing }
BlBackgroundTest >> testEqualityOfTransparentPaintBackground [
	"This test can be considered as redundant as the paint implements Singleton (but #new available)."

	| background |
	background := BlPaintBackground paint: BlTransparentPaint new.
	self assert: background equalsAndHasSameHash: background.
	
	self
		assert: (BlPaintBackground paint: BlTransparentPaint new)
		equalsAndHasSameHash: (BlPaintBackground paint: BlTransparentPaint new).

	self
		deny:
			(BlPaintBackground new
				paint: BlTransparentPaint new;
				opacity: 1.0;
				yourself)
		equals:
			(BlPaintBackground new
				paint: BlTransparentPaint new;
				opacity: 0.5;
				yourself)
]

{ #category : #testing }
BlBackgroundTest >> testTransparentBackground [

	| aBackground |
	aBackground := BlTransparentBackground new.
	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 0.0
]
