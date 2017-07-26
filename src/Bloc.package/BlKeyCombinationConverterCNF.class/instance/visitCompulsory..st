visiting
visitCompulsory: aBlCompulsoryCombination
	| compulsory |

	compulsory := BlCompulsoryCombination new.

	aBlCompulsoryCombination combinations do: [ :aCombination |
		compulsory withAll: (aCombination accept: self) combinations ].
	
	^ compulsory