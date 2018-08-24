Class {
	#name : #BlStyleRelation,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #'as yet unclassified' }
BlStyleRelation class >> CHILD [
	^ BlStyleChildRelation
]

{ #category : #'as yet unclassified' }
BlStyleRelation class >> DESCENDANT [
	^ BlStyleDescendantRelation
]

{ #category : #'as yet unclassified' }
BlStyleRelation class >> isChild [
	^ false
]

{ #category : #'as yet unclassified' }
BlStyleRelation class >> isDescendant [
	^ false
]
