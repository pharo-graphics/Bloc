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
	self waitingBlock: [ :aSpace | aSpace time 
			every: 100 milliSeconds 
			while: [ aSpace taskQueue tasks isNotEmpty ] 
			do: [ aSpace pulse ] ]
]

{ #category : #actions }
BlDevScripterWaitStep >> playOn: aScripter [
	self waitingBlock value: aScripter element space
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock [
	^ waitingBlock
]

{ #category : #accessing }
BlDevScripterWaitStep >> waitingBlock: anObject [
	waitingBlock := anObject
]
