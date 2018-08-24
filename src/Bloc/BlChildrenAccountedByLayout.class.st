"
I represent a subset of children that are accounted (not ignored) by layout.

Example:
[[[
| element |
element := BlElement new.
element children accountedByLayout
]]]
"
Class {
	#name : #BlChildrenAccountedByLayout,
	#superclass : #BlChildrenSubset,
	#category : 'Bloc-Basic-Children'
}

{ #category : #'children - subsets' }
BlChildrenAccountedByLayout >> accountedByLayout [
	^ self
]

{ #category : #accessing }
BlChildrenAccountedByLayout >> name [
	^ 'Accounted by layout'
]

{ #category : #initialization }
BlChildrenAccountedByLayout >> subsetFrom: aBlChildren [
	^ aBlChildren select: [ :anElement | anElement constraints ignoredByLayout not ]
]
