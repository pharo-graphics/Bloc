Class {
	#name : 'BlOSWindowDestroyedSignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'window'
	],
	#category : 'BlocHost-OSWindow-Signal',
	#package : 'BlocHost-OSWindow',
	#tag : 'Signal'
}

{ #category : 'accessing' }
BlOSWindowDestroyedSignal >> window [
	^ window
]

{ #category : 'accessing' }
BlOSWindowDestroyedSignal >> window: anObject [
	window := anObject
]
