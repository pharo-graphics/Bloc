"
I represent a subset of children that are ignored by layout.

{{gtExample:BlChildrenSubsetExamples>>#ignoredByLayoutFromElement}}

"
Class {
	#name : 'BlChildrenIgnoredByLayout',
	#superclass : 'BlChildrenSubset',
	#category : 'Bloc-Basic-Children'
}

{ #category : 'children - subsets' }
BlChildrenIgnoredByLayout >> ignoredByLayout [
	^ self
]

{ #category : 'accessing' }
BlChildrenIgnoredByLayout >> name [
	^ 'Ignored by layout'
]

{ #category : 'initialization' }
BlChildrenIgnoredByLayout >> subsetFrom: aBlChildren [
	^ aBlChildren select: [ :anElement |
		anElement constraints ignoredByLayout
			and: [ anElement visibility isGone not ] ]
]
