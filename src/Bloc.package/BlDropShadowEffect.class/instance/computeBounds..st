effect
computeBounds: aSpartaRectangle
	| aLeft aTop aRight aBottom |

	aLeft := (self width - self offset x) max: 0.
	aTop := (self width - self offset y) max: 0.
	aRight := (self width + self offset x) max: 0.
	aBottom := (self width + self offset y) max: 0.

	^ aSpartaRectangle
		expandByLeft: aLeft
		top: aTop
		right: aRight
		bottom: aBottom