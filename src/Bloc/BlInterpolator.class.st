"
I am an abstract Interpolator and define an abstract interpolate: method which is used to calculate interpolated values.

Concrete interpolators or easing function implementations must subclass me and implement #interpolate: method that takes a Number within interval [0.0 - 1.0] and returnes an interpolated value. Note, that returned value is not necessarily positive or lies within the same interval as input value.

- interpolate: returns interpolated value according to implemented interpolation function.

Example

   BlEasingElastic interpolate: 0.5

"
Class {
	#name : 'BlInterpolator',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'default'
	],
	#category : 'Bloc-Basic-Interpolators'
}

{ #category : 'cleanup' }
BlInterpolator class >> cleanUp [
	super cleanUp.
	
	default := nil
]

{ #category : 'unique instance' }
BlInterpolator class >> default [
	"I return a unique instance of an interpolator with default configuration"
	^ default ifNil: [ default := self new ]
]

{ #category : 'interpolation' }
BlInterpolator >> interpolate: aNumber [
	^ self subclassResponsibility
]
