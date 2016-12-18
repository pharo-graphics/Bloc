hooks
onElementAttached: anElementHolder
	"Sent when an element created by this datasource has been attached to InfiniteElement.
	This can be used as a reasonable signal that the element is about to be seen by the user.
	If the datasource previously freed any resources in #onElementDetached: those resources should be restored here"