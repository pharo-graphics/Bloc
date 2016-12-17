scrolling
runIfNecessaryOn: anInfiniteElement

	self hasJumpTarget
		ifTrue: [ 
			| aPosition |
			aPosition := jumpPosition.
			jumpPosition := NoPosition.
			anInfiniteElement jumpToPositionForSmoothScroller: aPosition.
			isChanged := false.
			^ self ].
	
	isChanged
		ifFalse: [ 
			consecutiveUpdates := 0.
			^ self	 ].
			
	
"
                    validate();
                    if (mInterpolator == null) {
                        if (mDuration == UNDEFINED_DURATION) {
                            recyclerView.mViewFlinger.smoothScrollBy(mDx, mDy);
                        } else {
                            recyclerView.mViewFlinger.smoothScrollBy(mDx, mDy, mDuration);
                        }
                    } else {
                        recyclerView.mViewFlinger.smoothScrollBy(mDx, mDy, mDuration, mInterpolator);
                    }
                    consecutiveUpdates ++;
                    if (consecutiveUpdates > 10) {
                        // A new action is being set in every animation step. This looks like a bad
                        // implementation. Inform developer.
                        Log.e(TAG, Smooth Scroll action is being updated too frequently. Make sure
                                +  you are not changing it unless necessary);
                    }
                    changed = false;"