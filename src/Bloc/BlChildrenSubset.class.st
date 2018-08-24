"
I represent a subset of children chosen according to some rule, for example whether they are ignored by layout or not.
See my subclasses
"
Class {
	#name : #BlChildrenSubset,
	#superclass : #BlChildren,
	#instVars : [
		'subsetArray',
		'supersetChildren'
	],
	#category : 'Bloc-Basic-Children'
}

{ #category : #'instance creation' }
BlChildrenSubset class >> on: aBlChildren [
	^ self new initializeFrom: aBlChildren
]

{ #category : #'children - accessing' }
BlChildrenSubset >> at: anIndex [
	<return: #BlElement>

	^ subsetArray at: anIndex
]

{ #category : #'children - enumerating' }
BlChildrenSubset >> do: aBlock [
	subsetArray do: aBlock
]

{ #category : #testing }
BlChildrenSubset >> hasSuperset [
	<return: #Boolean>

	 ^ true
]

{ #category : #initialization }
BlChildrenSubset >> initializeFrom: aBlChildren [
	subsetArray := self subsetFrom: aBlChildren.
	supersetChildren := aBlChildren
]

{ #category : #accessing }
BlChildrenSubset >> name [
	^ 'Subset'
]

{ #category : #'children - accessing' }
BlChildrenSubset >> size [
	<return: #Number>

	^ subsetArray size
]

{ #category : #initialization }
BlChildrenSubset >> subsetFrom: aBlChildren [
	<return: #Array of: #BlElement>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
BlChildrenSubset >> superset [
	"Return a superset of this children subset"
	<return: #BlChildren>
	
	^ supersetChildren
]
