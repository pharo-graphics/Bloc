private
positionedScrapFor: aPosition dryRun: dryRun context: aContext

	^ aContext recycler changedScrap
		detect: [ :holder |
			holder wasReturnedFromScrap not and: [ holder layoutPosition = aPosition ] ]
		ifFound: [ :holder |
			holder flagReturnedFromScrap: true.
			holder ]
		ifNone: [ nil ]