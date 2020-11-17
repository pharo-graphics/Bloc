Class {
	#name : #BlDevScripterWaitStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'waitingBlock'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterWaitStep >> defaultLabel [
	^ 'Wait'
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEmptySpaceTaskQueue [
	self label: 'Wait For Empty Task Queue'.
	self onSpace.
	self waitingBlock: [ :aSpace |
		aSpace time 
			every: 20 milliSeconds 
			while: [ aSpace taskQueue tasks isNotEmpty ] 
			do: [ aSpace pulse ] ]
]

{ #category : #initialization }
BlDevScripterWaitStep >> forEmptySpaceTaskQueueTimeout: aDuration [
	self label: ('Wait For Empty Task Queue with {1} timeout' format: { aDuration }).
	self onSpace.
	self waitingBlock: [ :aSpace |
		| aStartTime |
		aStartTime := aSpace time now.		
		aSpace time 
			every: 100 milliSeconds 
			while: [ (aSpace time now < (aStartTime + aDuration)) and: [ aSpace taskQueue tasks isNotEmpty ] ] 
			do: [ aSpace pulse ] ]
]

{ #category : #actions }
BlDevScripterWaitStep >> playOn: aScripter [
	self waitingBlock value: (self target findTargetStartingInScripter: aScripter)
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock [
	^ waitingBlock
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock: anObject [
	waitingBlock := anObject
]
