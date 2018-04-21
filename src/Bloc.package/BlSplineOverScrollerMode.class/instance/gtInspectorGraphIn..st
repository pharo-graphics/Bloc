as yet unclassified
gtInspectorGraphIn: aComposite
	<gtInspectorPresentationOrder: 10>

	^ aComposite bloc
		title: 'Graph';
		when: [ Smalltalk globals hasClassNamed: #GtPlotter ];
		display: [
			| aScroller theData theColors aPlotter |
			
			aScroller := BlSplineBasedOvershootingScroller new.
			aScroller bePrecise.
			aScroller time: (BlTime simulated).
			aScroller mode: self.

			theData := OrderedCollection new.
			aScroller time
				every: 10 milliSeconds
				while: [ aScroller run ]
				do: [ theData add: {
					#time -> aScroller time now.
					#position -> aScroller currentPosition.
					#step -> aScroller currentStep
				} asDictionary ].

			theColors := {
				BlSplineOverScrollerStep spline -> Color red.
				BlSplineOverScrollerStep ballistic -> Color blue.
				BlSplineOverScrollerStep cubic -> Color green muchDarker.
			} asDictionary.

			aPlotter := #GtPlotter asClass new.
			aPlotter line
				y: [ :each | each at: #position ];
				x: [ :each | each at: #time ];
				shape: [ :from :to :line | line border: (BlBorder paint: (theColors at: (to at: #step)) width: 1) ];
				with: theData.

			aPlotter root ]