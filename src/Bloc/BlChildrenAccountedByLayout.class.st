"
I represent a subset of children that are accounted (not ignored) by layout.

{{gtExample:BlChildrenSubsetExamples>>#accountedByLayoutChildrenFromElement}}


"
Class {
	#name : 'BlChildrenAccountedByLayout',
	#superclass : 'BlChildrenSubset',
	#category : 'Bloc-Basic-Children',
	#package : 'Bloc',
	#tag : 'Basic-Children'
}

{ #category : 'children - subsets' }
BlChildrenAccountedByLayout >> accountedByLayout [
	^ self
]

{ #category : 'accessing' }
BlChildrenAccountedByLayout >> name [
	^ 'Accounted by layout'
]

{ #category : 'initialization' }
BlChildrenAccountedByLayout >> subsetFrom: aBlChildren [
	^ aBlChildren select: [ :anElement |
		anElement constraints ignoredByLayout not
			and: [ anElement visibility isGone not ] ]
]
