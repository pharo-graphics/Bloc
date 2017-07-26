private
toNormalForm: aKeyCombination
	"Converts a given key combination to a normal form (CNF or DNF)
	(https://en.wikipedia.org/wiki/Conjunctive_normal_form)
	(https://en.wikipedia.org/wiki/Disjunctive_normal_form)"
	<return: #BlKeyCombination>

	^ aKeyCombination accept: converter