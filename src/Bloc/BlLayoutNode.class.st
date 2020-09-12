"
!Layout node
Is a node that is laied out by ${class:BlLayout}$
"
Class {
	#name : #BlLayoutNode,
	#superclass : #Object,
	#instVars : [
		'constraints'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #accessing }
BlLayoutNode >> constraints [
	^ constraints
]

{ #category : #accessing }
BlLayoutNode >> constraints: aBlLayoutConstraints [
	constraints := aBlLayoutConstraints
]

{ #category : #accessing }
BlLayoutNode >> margin [
	^ self constraints margin
]

{ #category : #accessing }
BlLayoutNode >> maxExtent [
	^ self maxWidth @ self maxHeight
]

{ #category : #accessing }
BlLayoutNode >> maxHeight [
	^ self constraints maxHeight
]

{ #category : #accessing }
BlLayoutNode >> maxWidth [
	^ self constraints maxWidth
]

{ #category : #accessing }
BlLayoutNode >> minExtent [
	^ self minWidth @ self minHeight
]

{ #category : #accessing }
BlLayoutNode >> minHeight [
	^ self constraints minHeight
]

{ #category : #accessing }
BlLayoutNode >> minWidth [
	^ self constraints minWidth
]

{ #category : #accessing }
BlLayoutNode >> padding [
	^ self constraints padding
]
