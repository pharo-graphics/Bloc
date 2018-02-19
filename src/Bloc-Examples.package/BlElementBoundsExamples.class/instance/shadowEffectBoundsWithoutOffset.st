examples - special
shadowEffectBoundsWithoutOffset
	<gtExample>
	| parent child shadowWidth |

	shadowWidth := 20.

	parent := self parentWithChild.
	child := parent children first.
	child effect: (BlDropShadowEffect new width: shadowWidth; offset: 0@0).

	self assert: child effectBounds equals: (shadowWidth asPoint negated corner: self childExtent + shadowWidth asPoint).

	child size: self childExtent * 2.
	child forceLayout.

	self assert: child effectBounds equals: (shadowWidth asPoint negated corner: (self childExtent * 2) + shadowWidth asPoint).

	^ parent