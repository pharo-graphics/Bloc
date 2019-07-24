Class {
	#name : #BlRollingLinearGradientPaintCommand,
	#superclass : #BlCommand,
	#instVars : [
		'step',
		'stop',
		'paint'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'api - execution' }
BlRollingLinearGradientPaintCommand >> execute [
	stop > 0.9 ifTrue: [ step := step negated ].
	stop < 0.1 ifTrue: [ step := step negated ].
	stop := stop + step.
	paint := self newGradientBackgroundAt: stop.
]

{ #category : #initialization }
BlRollingLinearGradientPaintCommand >> initialize [
	super initialize.
	stop := 0.1.
	step := 0.01.
]

{ #category : #'instance creation' }
BlRollingLinearGradientPaintCommand >> newGradientBackgroundAt: aStop [
	^ BlLinearGradientPaint new
						stops:
							{(0.0 -> Color white ).
							(aStop -> Color white darker).
							(1.0 -> Color white)};
						start: 0@0;
						end: 1@1
]

{ #category : #'api - execution' }
BlRollingLinearGradientPaintCommand >> result [
	"Return a command execution result"
	<return: #Object>
	^ paint
]

{ #category : #'api - execution' }
BlRollingLinearGradientPaintCommand >> terminationRequested [
	"I am a fast command"
]

{ #category : #'api - testing' }
BlRollingLinearGradientPaintCommand >> wasCanceled [
	"Answer whether an execution was canceled"
	<return: #Boolean>
	^ false
]
