scrolling
computeOffsetFling

	(scrollerX isFinished or: [
		scrollerX update or: [ 
			scrollerX continueWhenFinished ] ])
		ifFalse: [ scrollerX finish ].

	(scrollerY isFinished or: [
		scrollerY update or: [ 
			scrollerY continueWhenFinished ] ])
		ifFalse: [ scrollerX finish ]