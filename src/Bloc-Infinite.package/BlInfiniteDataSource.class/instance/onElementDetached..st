hooks
onElementDetached: anElementHolder
	"Sent when an element created by this datasource has been detached from infinite element.
	Becoming detached is not necessarily a permanent condition;
	the consumer of the DataSource's elements may choose to cache elements offscreen while they
	are not visible, attaching and detaching them as appropriate"