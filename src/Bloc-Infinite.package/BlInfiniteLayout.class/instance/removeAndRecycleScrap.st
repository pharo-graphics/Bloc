private - recycling
removeAndRecycleScrap
	| aScrapCount |
	
	"Store amount of scrapped element in order to decide if we need to invalidate
	infinite element later"
	aScrapCount := self recycler scrapCount.
	self recycler reverseScrapDo: [ :aScrappedElement :anIndex |
		| anElementHolder |
		anElementHolder := self elementHolderOf: aScrappedElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				"If the scrap element is animating, we need to cancel them first. If we cancel it
				here, ItemAnimator may recycle it which will cause double recycling.
				To avoid this, we mark it as not recycleable before using the item animator.
				Since removeDetachedChild: may use a user API, a common mistake (ending animations on
				the element) may recycle it too, so we guard it before we use user APIs."
				anElementHolder isRecyclable: false.
				anElementHolder isTmpDetached
					ifTrue: [ infiniteElement removeDetachedChild: aScrappedElement animate: false ].
				self endAnimation: anElementHolder.
				anElementHolder isRecyclable: true.
				self recycler quickRecycleScrap: aScrappedElement	] ].
	"we used quick recycling mechanism in the loop and have to clear scrap manually"
	self recycler clearScrap.
	
	"invalidate infinite element if needed"
	aScrapCount isZero
		ifFalse: [
			self flag: 'Do we need to request layout here?'.
			infiniteElement invalidate ]