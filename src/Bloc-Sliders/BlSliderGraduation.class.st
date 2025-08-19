Class {
	#name : #BlSliderGraduation,
	#superclass : #BlElement,
	#instVars : [
		'minValue',
		'maxValue',
		'slider',
		'stepValue'
	],
	#category : #'Bloc-Sliders'
}

{ #category : #'as yet unclassified' }
BlSliderGraduation >> connectToSlider: aSlider [

	slider := aSlider.
	minValue := aSlider minValue.
	maxValue := aSlider maxValue.
	stepValue := maxValue - minValue / 4.
	aSlider initializeGraduationsFor: self.
	aSlider addChild: self
]

{ #category : #initialization }
BlSliderGraduation >> initialize [

	super initialize.
	self clipChildren: false.
	self constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	"self hMatchParent.
	self vMatchParent."
	self layout: BlFrameLayout new.
	self zIndex: 3.
	self preventMeAndChildrenMouseEvents
]

{ #category : #'as yet unclassified' }
BlSliderGraduation >> reinitializeStepGraduations [

	self removeChildren.
	slider initializeGraduationsFor: self.
]

{ #category : #accessing }
BlSliderGraduation >> slider [ 

	^ slider
]

{ #category : #accessing }
BlSliderGraduation >> stepValue [ 

	^ stepValue
]

{ #category : #accessing }
BlSliderGraduation >> stepValue: aNumber [

	stepValue := aNumber.
	self reinitializeStepGraduations
]
