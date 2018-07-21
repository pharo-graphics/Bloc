example - attributes
clearAttributesFromEmpty
	<gtExample>
	| anEmptyRope aRopeWithoutAttributes |

	anEmptyRope := self emptyRopeWithAttributes.
	aRopeWithoutAttributes := anEmptyRope clearAttributes: 0 to: 0.

	self assert: (aRopeWithoutAttributes == BlCollectionRope empty).

	^ aRopeWithoutAttributes