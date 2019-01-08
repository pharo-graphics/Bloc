Class {
	#name : #BlParallelAnimation,
	#superclass : #BlCompositeAnimation,
	#category : 'Bloc-Animation-Basic'
}

{ #category : #'api - running' }
BlParallelAnimation >> doStep [
	self animations do: [ :anAnimation | anAnimation run ]
]

{ #category : #'api - accessing' }
BlParallelAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"
	<return: #Duration>

	^ self animations
		ifEmpty: [ 0 seconds ]
		ifNotEmpty: [ :theAnimations | theAnimations max: [ :anAnimation | (anAnimation duration + anAnimation delay) * anAnimation loops ] ]
]
