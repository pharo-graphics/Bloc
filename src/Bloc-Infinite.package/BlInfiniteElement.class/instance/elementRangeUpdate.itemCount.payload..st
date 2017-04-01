private - commands
elementRangeUpdate: aPositionStart itemCount: anItemCount payload: anObject
	"Rebind existing elements for the given range, or create new as needed"
	| aPositionEnd |

	aPositionEnd := aPositionStart + anItemCount.
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				(anElementHolder position >= aPositionStart and: [ anElementHolder position < aPositionEnd ])
					ifTrue: [ 
						"We re-bind these elements holders after pre-processing is complete so that
						ElementHolders have their final positions assigned."
						anElementHolder flags addUpdate.
						anElementHolder addPayload: anObject.
						anElement constraints infinite insetsDirty: true ] ] ].
	
	recycler elementRangeUpdate: aPositionStart itemCount: anItemCount