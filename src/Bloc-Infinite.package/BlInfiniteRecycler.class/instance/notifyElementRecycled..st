event firing
notifyElementRecycled: anElementHolder
	"BlInfiniteElementRecycledEvent is sent whenever the view in the ViewHolder is recycled.
   Recycler sends me right before clearing ElementHolder's internal data and sending it to RecyclerPool.
	This way, if ElementHolder was holding valid information before being recycled,
	you can use ===#dataSourcePosition=== to get its datasource position"

	self fireEvent: (BlInfiniteElementRecycledEvent holder: anElementHolder)