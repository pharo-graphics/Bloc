visiting
visitAlternative: aBlAlternativeCombination
	| alternative |

	alternative := BlAlternativeCombination new.

	aBlAlternativeCombination combinations do: [ :aCombination |
		alternative withAll: (aCombination accept: self) combinations ].
	
	^ alternative