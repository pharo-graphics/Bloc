measurement
measureChildWithMargins: anElement widthUsed: aWidthUsed heightUsed: aHeightUsed
	"Measure a child element using standard measurement policy, taking the padding
	of the parent InfiniteElement, any added item decorations and the child margins
	into account.
	If the InfiniteElement can be scrolled in either dimension the sender may 
	pass 0 as the widthUsed or heightUsed parameters as they will be irrelevant"

	| widthUsed heightUsed aWidthSpec aHeightSpec anExtentSpec anInsets aConstraints |
	
	aConstraints := anElement constraints.
	anInsets := infiniteElement decorationInsets: anElement.
	widthUsed := aWidthUsed + anInsets width.
	heightUsed := aHeightUsed + anInsets height.
	
	aWidthSpec := self
		calculateChildMeasureSpec: self width
		parentSpec: self widthSpec
		padding: self paddingLeft + self paddingRight + aConstraints margin width + widthUsed
		childResizer: aConstraints horizontal resizer
		canScroll: self canScrollHorizontally.
	
	aHeightSpec := self
		calculateChildMeasureSpec: self height
		parentSpec: self heightSpec
		padding: self paddingTop + self paddingBottom + aConstraints margin height + heightUsed
		childResizer: aConstraints vertical resizer
		canScroll: self canScrollVertically.
		
	anExtentSpec := aWidthSpec @ aHeightSpec.
	
	(self shouldMeasureChild: anElement spec: anExtentSpec)
		ifTrue: [ anElement measure: anExtentSpec ]