examples - fling vertically
flingTwiceWithFlywheel
	<gtExample>
	| aScroller |

	aScroller := self overshootingScroller.
	aScroller
		fling: 0@0
		velocity: 0@100.

	aScroller
		fling: 0@0
		velocity: 0@100.

	self assert: aScroller velocity equals: (0 @ 200) asBlocVector.

	^ aScroller