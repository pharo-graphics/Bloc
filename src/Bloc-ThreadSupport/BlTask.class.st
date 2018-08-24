Class {
	#name : #BlTask,
	#superclass : #TKTTask,
	#instVars : [
		'valuable',
		'progress',
		'message'
	],
	#category : 'Bloc-ThreadSupport'
}

{ #category : #'as yet unclassified' }
BlTask class >> new: aValuable [
	^ self new
		valuable: aValuable;
		yourself
]

{ #category : #'accessing properties' }
BlTask >> messageProperty [
	^ message ifNil: [ message := BlObjectProperty on: self named: #message default: '' ]
]

{ #category : #'private accessing' }
BlTask >> privateMessage [
	^ self messageProperty value
]

{ #category : #'private accessing' }
BlTask >> privateMessage: aString [
	self messageProperty value: aString
]

{ #category : #'private accessing' }
BlTask >> privateProgress [
	^ self progressProperty value
]

{ #category : #'private accessing' }
BlTask >> privateProgress: aNumber [
	self progressProperty value: aNumber
]

{ #category : #'accessing properties' }
BlTask >> progressProperty [
	^ progress ifNil: [ progress := BlObjectProperty on: self named: #progress default: 0 ]
]

{ #category : #'as yet unclassified' }
BlTask >> start [
	self schedule
]

{ #category : #updating }
BlTask >> updateMessage: aString [
	BlUniverse defer: [ self privateMessage: aString ]
]

{ #category : #updating }
BlTask >> updateProgress: aNumber max: aMaxNumber [
	BlUniverse defer: [ self privateProgress: (aNumber / aMaxNumber) asFloat ]
]

{ #category : #accessing }
BlTask >> valuable: anObject [
	valuable := anObject
]

{ #category : #'as yet unclassified' }
BlTask >> value [
	^ valuable cull: self
]
