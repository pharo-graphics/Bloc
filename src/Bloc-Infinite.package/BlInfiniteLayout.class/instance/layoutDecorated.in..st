layout
layoutDecorated: anElement in: aRectangle
	"Lay out the given child view within the infinite element using coordinates that
	include any current ItemDecoration.
	InfiniteLayouts should prefer working in sizes and coordinates that include
	item decoration insets whenever possible. This allows the InfiniteLayouts to effectively
	ignore decoration insets within measurement and layout code.
	Note: I don't take margins into account!"
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	anElement applyLayoutIn: (anInsets inset: aRectangle)