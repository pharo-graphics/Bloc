Sent when an element is attached to InfiniteElement.

Sent by:
  - BlInfiniteElement

Example:

infiniteElement
	addEventHandlerOn: BlInfiniteElementAttachedEvent
	do: [ :event | self inform: 'Atatched:  ', event element asString ]