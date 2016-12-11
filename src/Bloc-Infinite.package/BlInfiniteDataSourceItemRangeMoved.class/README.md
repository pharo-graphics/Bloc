Sent when an item reflected at ===from=== position has been moved to ===to=== position.
This is a structural change event. Representations of other existing items in the data set are still considered up to date and will not be rebound, though their positions may be altered.

Sent by:
	- BlInfiniteDataSource
	
Example:

infiniteElement dataSource
	addEventHandlerOn: BlInfiniteDataSourceItemRangeMoved
	do: [ :event | self inform: 'Item was moved from: ', event from asString, ' to: ', event to asString ]