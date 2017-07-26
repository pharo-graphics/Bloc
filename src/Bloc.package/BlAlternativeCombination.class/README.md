I represent an alternative "OR" combination of multiple distinct keys. (disjunction)

I am very useful to support shortcuts that treat different keyboard keys as identical.
For example there might be two SHIFT keys: SHIFT_L (left shift) and SHIFT_R (right shift). In most cases for the end user there should be no difference between those two.

Here is an example of how to unify two shifts:

BlAlternativeCombination new
	key: Key leftShift;
	key: Key rightShift;
	yourself

Unified meta (cmd):

BlAlternativeCombination new
	with: (BlSingleKeyCombination key: Key leftMeta);
	with: (BlSingleKeyCombination key: Key rightMeta);
	yourself