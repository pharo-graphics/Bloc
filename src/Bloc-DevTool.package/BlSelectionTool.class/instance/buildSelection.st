as yet unclassified
buildSelection
|area selectedNodes|
area := Rectangle origin: startPosition corner: endPosition.

selectedNodes := client children select:[:each| area containsRect: each boundsInParent].
selectedNodes do:[:each| currentSelections add: (BlElementSelection on: each)].