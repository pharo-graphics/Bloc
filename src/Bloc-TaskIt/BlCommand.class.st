Class {
	#name : #BlCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-TaskIt'
}

{ #category : #testing }
BlCommand class >> isAbstract [
	^ self name = #BlCommand 
]

{ #category : #converting }
BlCommand >> asCommand [
	^ self
]

{ #category : #'api - taskit' }
BlCommand >> asTask [
	^ TKTTask valuable: self
]

{ #category : #'api - execution' }
BlCommand >> cancelRequest [
	"Every command is responsible to terminate nicely"
	self subclassResponsibility
]

{ #category : #'api - execution' }
BlCommand >> execute [
	self subclassResponsibility
]

{ #category : #'api - taskit' }
BlCommand >> future [
	^ self asTask future
]

{ #category : #'api - execution' }
BlCommand >> result [
	"Return a command execution result"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #'api - taskit' }
BlCommand >> schedule [
	^ self asTask schedule
]

{ #category : #'api - taskit' }
BlCommand >> value [
	^ self execute; result
]

{ #category : #'api - testing' }
BlCommand >> wasCanceled [
	"Answer whether an execution was canceled"
	<return: #Boolean>
	^ self subclassResponsibility
]
