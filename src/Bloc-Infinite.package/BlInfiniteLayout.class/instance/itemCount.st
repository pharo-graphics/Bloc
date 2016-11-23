items
itemCount
	"Returns the number of items in the datasource bound to the parent infinite element.
	Note that this number is not necessarily equal to BlInfiniteState>>#itemCount.
	In methods where State is available, you should use BlInfiniteState>>#itemCount instead"
	<return: #Number>
	
	^ self dataSource itemCount