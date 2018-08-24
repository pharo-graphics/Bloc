Class {
	#name : #BlParallelAnimation,
	#superclass : #BlCompositeAnimation,
	#category : 'Bloc-Animation-Basic'
}

{ #category : #pulse }
BlParallelAnimation >> doStep [
	self animations do: [ :each | each run ]
]

{ #category : #'api - accessing' }
BlParallelAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"
	<return: #Duration>

	^ self childrenMaxValue: [ :anAnimation | (anAnimation duration + anAnimation delay) * anAnimation loops ] default: 0 seconds
]
