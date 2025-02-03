Class {
	#name : #BlInfiniteCustomRecycler,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'Bloc-Infinite-Recycler'
}

{ #category : #'element fetching' }
BlInfiniteCustomRecycler >> elementFor: aPosition in: anInfiniteElement [

	" no recycling by default "
	^ nil
]

{ #category : #recycling }
BlInfiniteCustomRecycler >> recycleElement: anElement in: anInfiniteElement [

	" no recycling by default - a subclass may implement specific element recycling "
]
