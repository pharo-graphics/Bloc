private
positionedScrapFor: aPosition dryRun: dryRun controller: aRecyclerController

	^ aRecyclerController changedScrap
		detect: [ :holder |
			holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ] ]
		ifFound: [ :holder |
			holder flagReturnedFromScrap: true.
			holder ]
		ifNone: [ nil ]