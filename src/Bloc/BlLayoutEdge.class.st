Class {
	#name : #BlLayoutEdge,
	#superclass : #Object,
	#instVars : [
		'fromNode',
		'toNode'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutEdge >> fromNode [
	^ fromNode
]

{ #category : #accessing }
BlLayoutEdge >> fromNode: anObject [
	fromNode := anObject
]

{ #category : #accessing }
BlLayoutEdge >> toNode [
	^ toNode
]

{ #category : #accessing }
BlLayoutEdge >> toNode: anObject [
	toNode := anObject
]
