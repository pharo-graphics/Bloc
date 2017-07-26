I represent a key combination that consists of one distinct key.

I am play a role of a leaf in ===BlKeyCombination=== composition tree.

Public API and Key Messages

- key: initialize me with a given Key
- key return an instance of Key that I represent as combination

 Examples:

	BlSingleKeyCombination key: Key arrowUp
	
	BlSingleKeyCombination new
		key: Key arrowUp
 
Internal Representation and Key Implementation Points.

    Instance Variables
	key:		<Key>


    Implementation Points

	#matches: returns true if key is pressed, which does not enforce the fact that there should be only one pressed key at a time
	
	#match: return 1 if I match any pressed key and 0 otherwise