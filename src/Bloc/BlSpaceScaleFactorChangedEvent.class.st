"
I am sent by a windowing system when a scaling factor of the window changes

"
Class {
	#name : 'BlSpaceScaleFactorChangedEvent',
	#superclass : 'BlSpaceEvent',
	#instVars : [
		'scaleFactor'
	],
	#package : 'Bloc',
	#tag : 'Events-Type-Space'
}

{ #category : 'accessing' }
BlSpaceScaleFactorChangedEvent >> scaleFactor [
	^ scaleFactor
]

{ #category : 'accessing' }
BlSpaceScaleFactorChangedEvent >> scaleFactor: anObject [
	scaleFactor := anObject
]

{ #category : 'sending' }
BlSpaceScaleFactorChangedEvent >> sendTo: anObject [
	anObject spaceScaleFactorChangedEvent: self
]
