"
I compose a non-empty collection of animations that run in parallel.

My loops are as long as my longest children's loop.
"
Class {
	#name : 'BlParallelAnimation',
	#superclass : 'BlCompositeAnimation',
	#category : 'Bloc-Animation-Basic',
	#package : 'Bloc-Animation',
	#tag : 'Basic'
}

{ #category : 'api - running' }
BlParallelAnimation >> doStep [

	animations do: [ :anAnimation | anAnimation run ]
]

{ #category : 'api - accessing' }
BlParallelAnimation >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"

	^ animations
		  ifEmpty: [ 0 seconds ]
		  ifNotEmpty: [ :theAnimations | 
			  theAnimations max: [ :anAnimation | 
				  anAnimation duration + anAnimation delay * anAnimation loops ] ]
]
