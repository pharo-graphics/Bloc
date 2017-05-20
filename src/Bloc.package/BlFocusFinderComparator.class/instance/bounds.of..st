private
bounds: aBlBounds of: anElement
	"Store and return visual bounds of a given element in root's coordinates
	that will be used for comparison.
	Note: I return mutable BlBounds instance that is shared between all comparison
	operations. By convention focus search can only be happen from UI thread, so it
	is safe to share bounds instance"
	<return: #BlBounds>
	
	anElement boundsInLocal: aBlBounds.
	^ rootElement childBounds: aBlBounds toLocal: anElement