I represent a compulsory "AND" combination of multiple distinct keys. (conjunction)
I am useful when there is a need to create a key combination that should be matched when all subcombinations are matching.

Example of a key combination that matches then and only then when both "arrowLeft" and "W" are pressed:

BlCompulsoryCombination new
	key: Key arrowLeft;
	key: Key w;
	yourself

Unified meta (cmd):

BlCompulsoryCombination new
	with: (BlSingleKeyCombination key: Key arrowLeft);
	with: (BlSingleKeyCombination key: Key w);
	yourself