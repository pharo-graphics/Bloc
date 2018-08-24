"
I am an interpolator where the rate of change starts out quickly and and then decelerates.

I am configurable using ""factor"" - a degree to which the animation should be eased. Setting factor to 1.0f produces an upside-down y=x^2 parabola. Increasing factor above 1.0f makes exaggerates the ease-out effect (i.e., it starts even faster and ends evens slower).

My formula is:
	f(x) = 1 - (1 - x)^n, where n = 2* factor

I meant to be immutable, therefore factor can be only set using factory method #factor: on my class side
"
Class {
	#name : #BlDecelerateInterpolator,
	#superclass : #BlInterpolator,
	#instVars : [
		'factor'
	],
	#category : 'Bloc-Animation-Interpolators'
}

{ #category : #'instance creation' }
BlDecelerateInterpolator class >> factor: aNumber [
	"Creates an instance of decelerate interpolator with custom factor number"
	<return: #BlDecelerateInterpolator>

	^ self basicNew
		initializeWith: aNumber;
		yourself
]

{ #category : #initialization }
BlDecelerateInterpolator >> defaultFactor [
	^ 1
]

{ #category : #accessing }
BlDecelerateInterpolator >> factor [
	<return: #Number>

	^ factor
]

{ #category : #initialization }
BlDecelerateInterpolator >> initialize [
	super initialize.
	
	factor := self defaultFactor
]

{ #category : #initialization }
BlDecelerateInterpolator >> initializeWith: aFactor [

	self
		assert: [ factor isNil ]
		description: [ 'I am immutable - factor can only be set once!' ].
		
	factor := aFactor
]

{ #category : #interpolation }
BlDecelerateInterpolator >> interpolate: aNumber [
	"f(x) = 1 - (1 - x)^n, where n = 2 * factor"
	
	^ self factor = 1
		"Special case, can be computed faster"
		ifTrue: [ 1.0 - ((1.0 - aNumber) * (1.0 - aNumber)) ]
		ifFalse: [ 1.0 - ((1.0 - aNumber) raisedTo: 2 * factor) ]
]
