Class {
	#name : #BlLogarithmicSlider,
	#superclass : #BlDesignSlider,
	#category : #'Bloc-Sliders'
}

{ #category : #'api - transformations' }
BlLogarithmicSlider >> valueAtX: aPoint [

	| value minP maxP minV maxV scale position |
	minP := 0.
	maxP := self barLength.
	minV := self minValue ln.
	maxV := self maxValue ln.

	scale := maxV - minV / (maxP - minP).
	position := (aPoint - bar position) x.
	value := (position - minP * scale + minV) exp.
	value := self nearestValue: value.

	^ value asFloat rounded
]
