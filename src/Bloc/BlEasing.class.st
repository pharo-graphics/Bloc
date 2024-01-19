Class {
	#name : 'BlEasing',
	#superclass : 'BlInterpolator',
	#category : 'Bloc-Basic-Interpolators',
	#package : 'Bloc',
	#tag : 'Basic-Interpolators'
}

{ #category : 'factory' }
BlEasing class >> bounceIn [
	^ BlEasingBounceIn default
]

{ #category : 'factory' }
BlEasing class >> bounceInOut [
	^ BlEasingBounceInOut default
]

{ #category : 'factory' }
BlEasing class >> bounceOut [
	^ BlEasingBounceOut default
]

{ #category : 'factory' }
BlEasing class >> linear [
	^ BlLinearInterpolator default
]

{ #category : 'interpolation' }
BlEasing >> deltaByProgress: aProgress [
	^ self interpolate: aProgress
]
