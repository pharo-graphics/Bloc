Class {
	#name : 'BlOSWindowCreatedSignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'window'
	],
	#category : 'BlocHost-OSWindow-Signal',
	#package : 'BlocHost-OSWindow',
	#tag : 'Signal'
}

{ #category : 'accessing' }
BlOSWindowCreatedSignal >> window [
	^ window
]

{ #category : 'accessing' }
BlOSWindowCreatedSignal >> window: anObject [
	window := anObject
]
