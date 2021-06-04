"
Easiest way to create a image background is by sending the message {{gtMethod:Form>>#asBlBackground}} to a {{gtClass:Form}} object.
{{gtExample:BlImageBackgroundExamples>>#blueImageWithPositiveExtentBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Alternatively, one can call the factory method {{gtMethod:BlImageBackground class>>#image:}} and pass it the desired form object
{{gtExample:BlImageBackgroundExamples>>#blueImageBackgroundExplicitInstantiation|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

We can also instantiate a {{gtClass:BlImageBackground}} object and configure it.
{{gtExample:BlImageBackgroundExamples>>#blueImageBackgroundExplicitInitialization|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Icons can be used as a background as they are forms.
{{gtExample:BlImageBackgroundExamples>>#iconImageBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Apart from icons, any other form can be used as a background.
{{gtExample:BlImageBackgroundExamples>>#pharoLogoImageBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}


One property suported by the image background is opacity. This changes the transparency of the background.
{{gtExample:BlImageBackgroundExamples>>#imageWithOpacityBackground|previewExpanded|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

Setting then the opacity to 0 makes the background transparent.
{{gtExample:BlImageBackgroundExamples>>#imageWithZeroOpacityBackground|previewHeight=200|previewShow=#gtViewBackgroundFor:}}

We can also get a transparent background by using an empty form as a background.
{{gtExample:BlImageBackgroundExamples>>#emptyImageBackground|previewHeight=200|previewShow=#gtViewBackgroundFor:}}


"
Class {
	#name : #BlImageBackgroundExamples,
	#superclass : #BlBackgroundExamples,
	#category : #'Bloc-Examples-! Documentation examples'
}

{ #category : #'background - image' }
BlImageBackgroundExamples >> blueImageBackgroundExplicitInitialization [
	<gtExample>
	| aBackground |
	
	aBackground := BlImageBackground new
		image: ((Form extent: 50@50 depth: 32) fillColor: Color blue).

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundExamples >> blueImageBackgroundExplicitInstantiation [
	<gtExample>
	| aBackground |
	
	aBackground := BlImageBackground image: ((Form extent: 50@50 depth: 32) fillColor: Color blue).

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundExamples >> blueImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := ((Form extent: 50@50 depth: 32) fillColor: Color blue) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self 
		assert: aBackground image bits 
		equals: ((Form extent: 50@50 depth: 32) fillColor: Color blue) bits.

	^ aBackground
]

{ #category : #'background - image' }
BlImageBackgroundExamples >> emptyImageBackground [
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
BlImageBackgroundExamples >> emptyImageWithPositiveExtentBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Form extent: 50@50) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Form extent: 50@50) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundExamples >> iconImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundExamples >> imageWithOpacityBackground [
	<gtExample>
	| aBackground |
	
	aBackground := (Smalltalk ui icons iconNamed: #pharoIcon) asBlBackground.
	aBackground opacity: 0.2.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 0.2.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: (Smalltalk ui icons iconNamed: #pharoIcon) bits.

	^ aBackground
]

{ #category : #'background - icon' }
BlImageBackgroundExamples >> imageWithZeroOpacityBackground [
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

{ #category : #'background - icon' }
BlImageBackgroundExamples >> pharoLogoImageBackground [
	<gtExample>
	| aBackground |
	
	aBackground := PolymorphSystemSettings pharoLogoForm asBlBackground.

	self assert: (aBackground isKindOf: BlImageBackground).	
	self assert: aBackground opacity equals: 1.0.
	self assert: aBackground isTransparent not.
	self assert: aBackground image bits equals: PolymorphSystemSettings pharoLogoForm bits.

	^ aBackground
]
