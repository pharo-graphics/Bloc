Class {
	#name : #BlFlowLayoutPriorityQueueNode,
	#superclass : #Object,
	#instVars : [
		'value',
		'priority',
		'queueIndex',
		'insertionIndex'
	],
	#category : #'Bloc-Layout-Flow-Utilities'
}

{ #category : #converting }
BlFlowLayoutPriorityQueueNode >> asAssociation [
	^ self priority -> self value
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> insertionIndex [
	^ insertionIndex
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> insertionIndex: anObject [
	insertionIndex := anObject
]

{ #category : #printing }
BlFlowLayoutPriorityQueueNode >> printOn: aStream [
	self asAssociation printOn: aStream
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> priority [
	^ priority
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> priority: anObject [
	priority := anObject
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> queueIndex [
	^ queueIndex
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> queueIndex: anObject [
	queueIndex := anObject
]

{ #category : #evaluating }
BlFlowLayoutPriorityQueueNode >> value [
	^ value
]

{ #category : #accessing }
BlFlowLayoutPriorityQueueNode >> value: anObject [
	value := anObject
]
