"
Easiest way to create a paint background that just displays a color is by sending the message {{gtMethod:Color>>#asBlBackground}} to the actual color.
{{gtExample:BlPaintBackgroundExamples>>#grayColorBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Alternatively, one can call the factory method {{gtMethod:BlPaintBackground class>>#paint:}} and pass it the desired paint.
{{gtExample:BlPaintBackgroundExamples>>#grayColorBackgroundExplicitInstantiationWithPaint|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

We can also instantiate a {{gtClass:BlPaintBackground}} object and configure it.
{{gtExample:BlPaintBackgroundExamples>>#grayColorBackgroundExplicitInitializationWithPaint|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Instead of creating a paint object, we can also pass only the color as a parameter to the factory method: 
{{gtExample:BlPaintBackgroundExamples>>#grayColorBackgroundExplicitInstantiationWithColor|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Paints do not have to be only be simple colors. We can also use gradients to specify a background. For example, below we create a background that displayes a gradient from red to blue.
{{gtExample:BlPaintBackgroundExamples>>#linearGradientBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

We can also use a different kind of gradient, like a radial one.
{{gtExample:BlPaintBackgroundExamples>>#radiusGradientBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

One property suported by the paint background is opacity. This changes the transparency of the background.
{{gtExample:BlPaintBackgroundExamples>>#grayColorWithLowOpacityBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Opacity also works when gradients are used in the background.
{{gtExample:BlPaintBackgroundExamples>>#linearGradientBackgroundWithOpacity|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Setting then the opacity to 0 makes the background transparent.
{{gtExample:BlPaintBackgroundExamples>>#grayColorWithZeroOpacityBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

We can also get a transparent background by setting the a transparent color as a background.
{{gtExample:BlPaintBackgroundExamples>>#transparentColorBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

"
Class {
	#name : #BlPaintBackgroundExamples,
	#superclass : #BlBackgroundExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorBackground [
	<gtExample>
	| aBackground |

	aBackground := Color gray asBlBackground.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorBackgroundExplicitInitializationWithPaint [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground new
		paint: (BlColorPaint color: Color gray).

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorBackgroundExplicitInstantiationWithColor [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground paint: Color gray.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorBackgroundExplicitInstantiationWithPaint [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground paint: (BlColorPaint color: Color gray).

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color gray.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorWithLowOpacityBackground [
	<gtExample>
	| aBackground |

	aBackground := Color blue asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.2.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color blue.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> grayColorWithZeroOpacityBackground [
	<gtExample>
	| aBackground |

	aBackground := Color blue asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color blue.
	
	^ aBackground
]

{ #category : #'background - gradient' }
BlPaintBackgroundExamples >> linearGradientBackground [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground new
		paint: (BlLinearGradientPaint new
			stops: { 0 -> Color red . 1 -> Color blue};
			start: 0@0;
			end: 100@100).

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlLinearGradientPaint).
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2.
	
	^ aBackground
]

{ #category : #'background - gradient' }
BlPaintBackgroundExamples >> linearGradientBackgroundWithOpacity [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground new
		paint: (BlLinearGradientPaint new
			stops: { 0 -> Color red . 1 -> Color blue};
			start: 0@0;
			end: 100@100).
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 0.2.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlLinearGradientPaint).
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2.
	
	^ aBackground
]

{ #category : #'background - gradient' }
BlPaintBackgroundExamples >> linearPaintBackground [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground new
		paint: (BlLinearGradientPaint new
			stops: { 0 -> Color red . 1 -> Color blue};
			start: 0@0;
			end: 100@100).

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlLinearGradientPaint).
	self assert: aBackground paint start equals: 0@0.
	self assert: aBackground paint end equals: 100@100.
	self assert: aBackground paint stops size equals: 2.
	
	^ aBackground
]

{ #category : #'background - gradient' }
BlPaintBackgroundExamples >> radiusGradientBackground [
	<gtExample>
	| aBackground |

	aBackground := BlPaintBackground new
		paint: (BlRadialGradientPaint new
			stops: { 0 -> Color blue . 1 -> Color red};
			center: 100@100;
			radius: 200).

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: (aBackground paint isKindOf: BlRadialGradientPaint).
	self assert: aBackground paint center equals: 100@100.
	self assert: aBackground paint radius equals: 200.
	self assert: aBackground paint stops size equals: 2.
	
	^ aBackground
]

{ #category : #'background - color' }
BlPaintBackgroundExamples >> transparentColorBackground [
	<gtExample>
	| aBackground |

	aBackground := Color transparent asBlBackground.

	self assert: (aBackground isKindOf: BlPaintBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: (aBackground paint isKindOf: BlColorPaint).
	self assert: aBackground paint color equals: Color transparent.

	^ aBackground
]
