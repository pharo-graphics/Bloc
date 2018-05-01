examples - time
spaceWithSlownDownTimeAndAnimatedElement
	<gtExample>
	| aSpace |

	aSpace := self spaceWithSlownDownTime.
	aSpace root addChild: self animatedElement.

	^ aSpace