Class {
	#name : #BlRecyclerPositionScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #initialization }
BlRecyclerPositionScrapFetcher >> defaultNext [
	^ BlRecyclerDataSourceFetcher uniqueInstance
]

{ #category : #'element fetching' }
BlRecyclerPositionScrapFetcher >> elementFor: aPosition in: anInfiniteElement [

	(self exactScrapFor: aPosition in: anInfiniteElement)
		ifNotNil: [ :found |
			(self validateHolder: found in: anInfiniteElement)
				ifTrue: [ ^ found ]
				ifFalse: [ 
					found flags addInvalid.
					found wasReturnedFromScrap ifTrue: [ found clearReturnedFromScrap ] ] ].

	^ self nextFetcher elementFor: aPosition in: anInfiniteElement
]

{ #category : #private }
BlRecyclerPositionScrapFetcher >> exactScrapFor: aPosition in: anInfiniteElement [

	^ anInfiniteElement recycler attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder layoutPosition = aPosition 
				and: [ holder isInvalid not
					and: [ anInfiniteElement state isPreLayout
						or: [ holder isRemoved not ] ] ] ]) ]
		ifFound: [ :holder |
			holder flags addReturnedFromScrap.
			holder ]
		ifNone: [ nil ]
]

{ #category : #private }
BlRecyclerPositionScrapFetcher >> validateHolder: aHolder in: anInfiniteElement [

	aHolder isRemoved ifTrue: [ 
		anInfiniteElement state isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder!' ].
		^ anInfiniteElement state isPreLayout ].

	(aHolder position <= 0 or: [ aHolder position > anInfiniteElement dataSource itemCount ])
		ifTrue: [ Error signal: ('Holder has completely wrong position! position = {1}, count = {2}'
			format: { aHolder position. anInfiniteElement dataSource itemCount. }) ].

	anInfiniteElement dataSource hasStableIds
		ifTrue: [ ^ aHolder itemId = (anInfiniteElement dataSource itemIdAt: aHolder position) ].
		
	^ true
]
