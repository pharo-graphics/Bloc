Class {
	#name : #BlStyleLocalSelector,
	#superclass : #BlStyleSimpleSelector,
	#instVars : [
		'target'
	],
	#category : 'Bloc-Style-Util'
}

{ #category : #'as yet unclassified' }
BlStyleLocalSelector class >> target: aNode [
	^ self new
		target: aNode;
		yourself
]

{ #category : #'as yet unclassified' }
BlStyleLocalSelector >> matchesPseudoClasseState: aPseudoClassStates [
	^ aPseudoClassStates includesAll: pseudoClasses
]

{ #category : #'as yet unclassified' }
BlStyleLocalSelector >> matchesStyleable: aStyleable [
	^ true
]

{ #category : #'as yet unclassified' }
BlStyleLocalSelector >> origin [
	^ BlStyleOrigin INLINE
]

{ #category : #accessing }
BlStyleLocalSelector >> target [
	^ target
]

{ #category : #accessing }
BlStyleLocalSelector >> target: anObject [
	target := anObject
]

{ #category : #'as yet unclassified' }
BlStyleLocalSelector >> updateSpecificity [
	idCount := 0.
	styleClassCount := self target styleClassProperty size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := 0.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
