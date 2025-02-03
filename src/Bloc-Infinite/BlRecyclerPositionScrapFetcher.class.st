Class {
	#name : #BlRecyclerPositionScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
BlRecyclerPositionScrapFetcher >> elementFor: aPosition in: anInfiniteElement [

	| scrapped |
	scrapped := self exactScrapFor: aPosition in: anInfiniteElement.
	^ scrapped ifNotNil: [ :found |
		  (self validateHolder: found in: anInfiniteElement)
			  ifTrue: [ found ]
			  ifFalse: [
				  found flags addInvalid.
				  found wasReturnedFromScrap ifTrue: [
					  found clearReturnedFromScrap ] ] ]
]

{ #category : #private }
BlRecyclerPositionScrapFetcher >> exactScrapFor: aPosition in: anInfiniteElement [

	^ anInfiniteElement recycler attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder position = aPosition 
				and: [ holder isInvalid not
					and: [ holder isRemoved not ] ] ] ) ]
		ifFound: [ :holder |
			holder flags addReturnedFromScrap.
			holder ]
		ifNone: [ nil ]
]

{ #category : #private }
BlRecyclerPositionScrapFetcher >> validateHolder: aHolder in: anInfiniteElement [

	aHolder isRemoved ifTrue: [ 
		Error signal: 'Should not get a removed holder!'.
		^ false ].

	(aHolder position <= 0 or: [ aHolder position > anInfiniteElement dataSource itemCount ])
		ifTrue: [ Error signal: ('Holder has completely wrong position! position = {1}, count = {2}'
			format: { aHolder position. anInfiniteElement dataSource itemCount. }) ].

	anInfiniteElement dataSource hasStableIds
		ifTrue: [ ^ aHolder itemId = (anInfiniteElement dataSource itemIdAt: aHolder position) ].
		
	^ true
]
