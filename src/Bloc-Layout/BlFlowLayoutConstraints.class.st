Class {
	#name : #BlFlowLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'newLine',
		'weight',
		'display'
	],
	#category : #'Bloc-Layout-Flow'
}

{ #category : #accessing }
BlFlowLayoutConstraints >> alignment [
	^ self horizontal alignment + self vertical alignment
]

{ #category : #initialization }
BlFlowLayoutConstraints >> defaultDisplay [
	^ BlFlowLayoutDisplay inline
]

{ #category : #initialization }
BlFlowLayoutConstraints >> defaultHorizontal [
	^ BlFlowLayoutConstraintsHorizontal new
]

{ #category : #initialization }
BlFlowLayoutConstraints >> defaultVertical [
	^ BlFlowLayoutConstraintsVertical new
]

{ #category : #accessing }
BlFlowLayoutConstraints >> display [
	^ display
]

{ #category : #accessing }
BlFlowLayoutConstraints >> float [
	display := BlFlowLayoutDisplay float
]

{ #category : #initialization }
BlFlowLayoutConstraints >> initialize [
	super initialize.
	
	newLine := false.
	weight := 0.
	display := self defaultDisplay
]

{ #category : #accessing }
BlFlowLayoutConstraints >> inline [
	display := BlFlowLayoutDisplay inline
]

{ #category : #testing }
BlFlowLayoutConstraints >> isNewLine [
	^ newLine
]

{ #category : #accessing }
BlFlowLayoutConstraints >> newLine: aBoolean [
	newLine := aBoolean
]

{ #category : #accessing }
BlFlowLayoutConstraints >> weight [
	^ weight
]

{ #category : #accessing }
BlFlowLayoutConstraints >> weight: aNumber [
	weight := aNumber
]
