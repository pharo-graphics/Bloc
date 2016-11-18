element fetching
elementFor: aPosition dryRun: dryRun controller: aRecyclerController
	| holder |

	holder := aRecyclerController createElementHolderOfType: (aRecyclerController itemTypeAt: aPosition).
	holder ifNil: [ Error signal: 'Data source must not return nil holder!' ].

	^ holder -> false