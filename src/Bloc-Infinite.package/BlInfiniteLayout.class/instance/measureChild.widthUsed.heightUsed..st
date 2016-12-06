measurement
measureChild: anElement widthUsed: aWidthUsed heightUsed: aHeightUsed
	"Measure a child element using standard measurement policy, taking the padding
	of the parent InfiniteElement and any added item decorations into account.
	Note: I don't take child margin into account!"
	| widthUsed heightUsed aWidthSpec aHeightSpec anExtentSpec anInsets aConstraints |
	
	aConstraints := anElement constraints.
	anInsets := infiniteElement decorationInsets: anElement.
	widthUsed := aWidthUsed + anInsets width.
	heightUsed := aHeightUsed + anInsets height.
	
	aWidthSpec := self
		calculateChildMeasureSpec: self width
		parentSpec: self widthSpec
		padding: self paddingLeft + self paddingRight + widthUsed
		childResizer: aConstraints horizontal resizer
		canScroll: self canScrollHorizontally.
	
	aHeightSpec := self
		calculateChildMeasureSpec: self height
		parentSpec: self heightSpec
		padding: self paddingTop + self paddingBottom + heightUsed
		childResizer: aConstraints vertical resizer
		canScroll: self canScrollVertically.
		
	anExtentSpec := aWidthSpec @ aHeightSpec.
	
	(self shouldMeasureChild: anElement spec: anExtentSpec)
		ifTrue: [ anElement measure: anExtentSpec ]