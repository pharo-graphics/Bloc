copying
copy
	"Visual elements can not be copied.
	The reason for that is unpredictable amount of conflicting copying behaviours.
	For example, what should happen if a copied element is added to the parent?
	Should we create a new element without the parent or add a copied one to the parent of
	the original element? What should we do with View Models? How to deal with event handlers? ...
	
	Thus, we decided that the most consistent behaviour is to forbid all kind of copying
	and let users instantiate elements by themselves in the way they want it"

	self shouldNotImplement