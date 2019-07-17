Class {
	#name : #BlTktNotificationCallback,
	#superclass : #Object,
	#instVars : [
		'element',
		'action'
	],
	#category : #'Bloc-TaskIt-Tasks'
}

{ #category : #accessing }
BlTktNotificationCallback >> action [
	^ action
]

{ #category : #accessing }
BlTktNotificationCallback >> action: anObject [
	action := anObject
]

{ #category : #accessing }
BlTktNotificationCallback >> element [
	^ element
]

{ #category : #accessing }
BlTktNotificationCallback >> element: anObject [
	element := anObject
]
