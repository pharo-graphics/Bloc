Class {
	#name : #BlInfiniteExamplePagerPanesDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'panes'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteExamplePagerPanesDataSource >> addPane: aPagerPane [

	panes add: aPagerPane.
	self notifyItemsInserted: (panes size to: panes size)
]

{ #category : #initialization }
BlInfiniteExamplePagerPanesDataSource >> initialize [
	super initialize.
	
	panes := OrderedCollection new
]

{ #category : #accessing }
BlInfiniteExamplePagerPanesDataSource >> itemCount [
	^ panes size
]

{ #category : #'instance creation' }
BlInfiniteExamplePagerPanesDataSource >> onBindHolder: anElementHolder at: aPosition [
	| pane |

	pane := panes at: aPosition.
	anElementHolder pane: pane
]

{ #category : #accessing }
BlInfiniteExamplePagerPanesDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlInfiniteExamplePagerPaneElementHolder new
]

{ #category : #accessing }
BlInfiniteExamplePagerPanesDataSource >> removePane: aPagerPane [
	| paneIndex |
	
	paneIndex := panes
		indexOf: aPagerPane
		ifAbsent: [ ^ self ].
	
	panes removeAt: paneIndex.
	self notifyItemsRemoved: (paneIndex to: paneIndex)
]
