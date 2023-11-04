Class {
	#name : 'BlFocusFinderCandidates',
	#superclass : 'Object',
	#instVars : [
		'candidates'
	],
	#category : 'Bloc-FocusFinder-Core',
	#package : 'Bloc-FocusFinder',
	#tag : 'Core'
}

{ #category : 'adding' }
BlFocusFinderCandidates >> add: anElement [

	candidates add: anElement
]

{ #category : 'accessing' }
BlFocusFinderCandidates >> candidates [

	^ candidates
]

{ #category : 'enumerating' }
BlFocusFinderCandidates >> do: aBlock [

	candidates do: aBlock
]

{ #category : 'initialization' }
BlFocusFinderCandidates >> initialize [

	super initialize.

	candidates := OrderedCollection new
]

{ #category : 'testing' }
BlFocusFinderCandidates >> isEmpty [

	^ self size isZero
]

{ #category : 'accessing' }
BlFocusFinderCandidates >> size [
	
	^ candidates size
]
