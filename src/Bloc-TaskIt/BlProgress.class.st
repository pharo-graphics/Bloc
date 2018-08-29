Class {
	#name : #BlProgress,
	#superclass : #BlTaskNotification,
	#instVars : [
		'amount',
		'total'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #accessing }
BlProgress >> amount [
	^ amount
]

{ #category : #accessing }
BlProgress >> amount: anObject [
	amount := anObject
]

{ #category : #accessing }
BlProgress >> total [
	^ total
]

{ #category : #accessing }
BlProgress >> total: anObject [
	total := anObject
]
