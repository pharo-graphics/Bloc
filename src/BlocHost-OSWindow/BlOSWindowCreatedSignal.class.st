Class {
	#name : #BlOSWindowCreatedSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'window'
	],
	#category : #'BlocHost-OSWindow-Signal'
}

{ #category : #accessing }
BlOSWindowCreatedSignal >> window [
	^ window
]

{ #category : #accessing }
BlOSWindowCreatedSignal >> window: anObject [
	window := anObject
]
