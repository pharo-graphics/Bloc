Class {
	#name : #BlFlowLayoutDisplay,
	#superclass : #Object,
	#classInstVars : [
		'float',
		'inline'
	],
	#category : #'Bloc-Layout-Flow-Utilities'
}

{ #category : #factory }
BlFlowLayoutDisplay class >> float [
	^ float
]

{ #category : #'class initialization' }
BlFlowLayoutDisplay class >> initialize [
	
	inline := BlFlowLayoutInline new.
	float := BlFlowLayoutFloat new
]

{ #category : #factory }
BlFlowLayoutDisplay class >> inline [
	^ inline
]

{ #category : #testing }
BlFlowLayoutDisplay >> isFloating [
	^ self subclassResponsibility
]
