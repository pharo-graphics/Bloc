layout
layoutDecoratedWithMargins: anElement in: aRectangle
	"Lay out the given child view within the infinite element using coordinates that
	include any current ItemDecoration and take child margins into account.
	InfiniteLayouts should prefer working in sizes and coordinates that include
	item decoration insets whenever possible. This allows the InfiniteLayouts to effectively
	ignore decoration insets within measurement and layout code."
	| anInsets aMargin |

	anInsets := anElement constraints infinite decorationInsets.
	aMargin := anElement constraints margin.
	anElement applyLayoutIn: (aMargin inset: (anInsets inset: aRectangle))