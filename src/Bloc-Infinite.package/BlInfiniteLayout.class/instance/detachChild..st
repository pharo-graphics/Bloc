children add/remove
detachChild: anElement
	"Temporarily detach a child element"

	self detachChildAt: (childManager childIndexOf: anElement)