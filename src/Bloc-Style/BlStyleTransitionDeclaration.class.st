Class {
	#name : #BlStyleTransitionDeclaration,
	#superclass : #BlStyleDeclaration,
	#instVars : [
		'duration',
		'timingFunction',
		'delay'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'adding/removing' }
BlStyleTransitionDeclaration >> addTo: aRule [
	aRule transitions add: self
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> delay [
	^ delay
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> delay: anObject [
	delay := anObject
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> duration [
	^ duration
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> duration: anObject [
	duration := anObject
]

{ #category : #'initialize-release' }
BlStyleTransitionDeclaration >> initialize [
	super initialize.
	duration := 0.
	timingFunction := #linear.
	delay := 0.
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> timingFunction [
	^ timingFunction
]

{ #category : #accessing }
BlStyleTransitionDeclaration >> timingFunction: anObject [
	timingFunction := anObject
]

{ #category : #importing }
BlStyleTransitionDeclaration >> valuesFromArray: anArray [
	self duration: (anArray at: 1 ifAbsent: [ ^ self duration ]) value.
	self timingFunction: (anArray at: 2 ifAbsent: [ ^ self timingFunction ]) value.
	self delay: (anArray at: 3 ifAbsent: [ ^ self delay ]) value
]
