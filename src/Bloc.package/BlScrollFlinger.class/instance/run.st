running
run
	| aScroller aSmoothScroller |

	self disableRunOnAnimationRequests.

	"keep a local reference so that if it is changed during onScrollBy: method,
	it won't cause unexpected behaviors"
	aScroller := scroller.
	aSmoothScroller := self scrollable smoothScroller.

	aScroller computeOffset
		ifTrue: [ 
			| aState |
			aState := self runInitOn: aScroller.
			self onInitialized.			

			self runLayoutScrollWith: aState.
			self onLayoutScrolled.
			
			self runSmoothOn: aSmoothScroller with: aState.
			self onSmoothScrolled.

			self runOverscrollOn: aScroller with: aState.
			
			aState didScroll
				ifTrue: [ scrollable dispatchOnScrolled: aState hResult @ aState vResult ].
			
			scrollable awakenScrollBars
				ifFalse: [ scrollable invalidate ].
				
			self runFinalizeOn: aScroller with: aState ].
	
	aSmoothScroller ifNotNil: [ 
		aSmoothScroller isPendingInitialRun
			ifTrue: [ aSmoothScroller onScrollBy: 0@0 ].
		"stop if it does not trigger any scroll"
		reSchedulePostAnimationCallback
			ifFalse: [ aSmoothScroller stop ] ].
		
	self enableRunOnAnimationRequests