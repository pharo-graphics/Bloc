children add/remove
removeAndRecycleScrap
	"Recycle the scrapped elements. 
    When an element is detached and removed, it does not trigger a BlElement>>#changed.
	This is the expected behavior if scrapped elements are used for animations.
	Otherwise, we need to send remove and invalidate infinite element to ensure UI update"
	| scrapCount |

	scrapCount := self recycler scrapCount.
	scrapCount to: 1 do: [ :anIndex |
		| scrappedElement scrappedElementHolder |
		scrappedElement := self recycler scrappedElementAt: anIndex.
		scrappedElementHolder := self childHolderOf: scrappedElement.
		scrappedElementHolder shouldIgnore
			ifFalse: [ 
				scrappedElementHolder recyclable: false.
				scrappedElementHolder isTmpDetached
					ifTrue: [ infiniteElement removeDetachedChild: scrappedElement animate: false ].
				self endAnimation: scrappedElementHolder.
				scrappedElementHolder recyclable: true.
				self recycler quickRecycleScrap: scrappedElement ] ].
	self recycler clearScrap.
	
	scrapCount > 0
		ifTrue: [ infiniteElement changed ]