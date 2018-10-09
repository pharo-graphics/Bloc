"
!Backgrounds

The class ${class:BlBackground}$ defines the background of a Bloc element. As this is an abstract class, the actual concrete types of backgrounds are defined by its subclasses. 

There are four main types of backgrounds:
- ${class:BlPaintBackground}$: color background defined using a ${class:BlPaint}$ object;
- ${class:BlImageBackground}$: image background defined using a ${class:Form}$ object;
- ${class:BlTransparentBackground}$: a special case of a transparent background;
- ${class:BlCompositeBackground}$: a background that provided the ability to compose multiple other ${class:BlBackground}$ objects.

!! Paint Backgrounds
The simplest of the available backgrounds is the paint background. A paint can be either a simple color or a type of gradient.

Easiest way to create a paint background that just displays a color is by sending the message ${method:Color>>#asBlBackground}$ to the actual color.
${example:BlBackgroundExamples>>#grayColorBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

Alternatively, there is also the possibility to call the factory method ${method:BlPaintBackground class>>#paint:}$ and pass it the desired paint.
${example:BlBackgroundExamples>>#grayColorBackgroundExplicitInstantiationWithPaint|previewHeight=200|show=#gtViewBackgroundFor:}$

Instead of creating a paint object, we can also pass only the color as a parameter to the factory method: 
${example:BlBackgroundExamples>>#grayColorBackgroundExplicitInstantiationWithColor|previewHeight=200|show=#gtViewBackgroundFor:}$

Paints do not have to be only be simple colors. We can also use gradients to specify a background. For example, below we create a background that displayes a gradient from red to blue.
${example:BlBackgroundExamples>>#linearGradientBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

We can also use a different kind of gradient, like a radial one.
${example:BlBackgroundExamples>>#radiusGradientBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

One other property suported by the paint background is opacity. This can be used to change transparency of the background. Next, we can make a blue border and change its opacity to 0.2. 
${example:BlBackgroundExamples>>#grayColorWithLowOpacityBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

Opacity also works when gradients are used in the background.
${example:BlBackgroundExamples>>#linearGradientBackgroundWithOpacity|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

Setting then the opacity to 0 makes the element transparent.
${example:BlBackgroundExamples>>#grayColorWithZeroOpacityBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$

We can also get a transparent element by setting the color ==Color transparent== as a background.
${example:BlBackgroundExamples>>#transparentColorBackground|expandedPreview|previewHeight=200|show=#gtViewBackgroundFor:}$


"
Class {
	#name : #BlBackgroundExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'background - builder' }
BlBackgroundExamples >> buildBackgroundWithImagesAndColor [
	<gtExample>
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

{ #category : #'background - image' }
BlBackgroundExamples >> emptyImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 0@0) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Form extent: 0@0) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> emptyImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 1@1) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Form extent: 1@1) bits.

	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> grayColorBackground [
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
BlBackgroundExamples >> grayColorBackgroundExplicitInstantiationWithColor [
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
BlBackgroundExamples >> grayColorBackgroundExplicitInstantiationWithPaint [
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
BlBackgroundExamples >> grayColorWithLowOpacityBackground [
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
BlBackgroundExamples >> grayColorWithZeroOpacityBackground [
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

{ #category : #'background - image' }
BlBackgroundExamples >> imageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlBackgroundExamples >> imageWithZeroOpacityBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.
	aBackground opacity: 0.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.
	self assert: aBackground isTransparent.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> linearGradientBackground [
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

{ #category : #'background - color' }
BlBackgroundExamples >> linearGradientBackgroundWithOpacity [
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

{ #category : #'background - color' }
BlBackgroundExamples >> linearPaintBackground [
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

{ #category : #'background - color' }
BlBackgroundExamples >> radiusGradientBackground [
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

{ #category : #'background - transparent' }
BlBackgroundExamples >> transparentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := BlTransparentBackground new.

	self assert: aBackground isTransparent.
	self assert: aBackground opacity equals: 1.0.

	^ aBackground
]

{ #category : #'background - color' }
BlBackgroundExamples >> transparentColorBackground [
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
