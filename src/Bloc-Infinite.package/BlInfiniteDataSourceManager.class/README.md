I manage data source update commands.

I control their order and optimize commands queue.
For example if there are two sequential commands: add and remove at the same position, I annihilate them and do nothing.

My onItemRange* methods are triggered directly or indirectly by data source when it is changed.

Public API and Key Messages

- onItemRangeChanged: itemCount: payload: - is sent by data source when content or value of items was changed
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commandsPool:		<Object>
	commandsReorderer:		<Object>
	controller:		<Object>
	pendingCommands:		<Object>
	postponedCommands:		<Object>
	shouldRecycle:		<Object>


    Implementation Points