host - api
createHostSpaceFor: aSpace
	| aHostSpace |

	aHostSpace := BlMockedHostSpace new.
	aHostSpace host: self.
	aHostSpace space: aSpace.

	aSpace hostSpace: aHostSpace