running
run
	| aScroller aSmoothScroller |

	self disableRunOnAnimationRequests.
	infiniteElement consumePendingDataSourceCommands.

	"keep a local reference so that if it is changed during onScrollBy: method,
	it won't cause unexpected behaviors"
	
	aScroller := scroller.
	aSmoothScroller := infiniteElement layout smoothScroller.
	
	aScroller computeOffset
		ifTrue: [ 
			| aState |
			aState := self runInitOn: aScroller.
			
			infiniteElement eatRequestLayout.
			infiniteElement onEnterLayoutOrScroll.
			
			self runLayoutScrollWith: aState.

			infiniteElement repositionShadowingElements.
			infiniteElement onExitLayoutOrScroll.
			infiniteElement resumeRequestLayout: false.
			
			self runSmoothOn: aSmoothScroller with: aState.
			
			infiniteElement hasItemDecorations
				ifTrue: [
					self flag: 'Do we need to request layout here?'.
					infiniteElement invalidate ].

			self runOverscrollOn: aScroller with: aState.
			
			aState didScroll
				ifTrue: [ infiniteElement dispatchOnScrolled: aState hResult @ aState vResult ].
			
			infiniteElement awakenScrollBars
				ifFalse: [ infiniteElement invalidate ].
				
			self runFinalizeOn: aScroller with: aState ].
	
	aSmoothScroller ifNotNil: [ 
		aSmoothScroller isPendingInitialRun
			ifTrue: [ aSmoothScroller onScrollBy: 0@0 ].
		"stop if it does not trigger any scroll"
		reSchedulePostAnimationCallback
			ifFalse: [ aSmoothScroller stop ] ].
		
	self enableRunOnAnimationRequests