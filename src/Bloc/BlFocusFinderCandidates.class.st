Class {
	#name : #BlFocusFinderCandidates,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'candidates'
	],
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #adding }
BlFocusFinderCandidates >> add: anElement [
	candidates add: anElement
]

{ #category : #enumerating }
BlFocusFinderCandidates >> do: aBlock [
	candidates do: aBlock
]

{ #category : #initialization }
BlFocusFinderCandidates >> initialize [
	super initialize.
	
	candidates := OrderedCollection new
]

{ #category : #testing }
BlFocusFinderCandidates >> isEmpty [
	<return: #Boolean>

	^ self size isZero
]

{ #category : #accessing }
BlFocusFinderCandidates >> size [
	<return: #Number>
	
	^ candidates size
]
