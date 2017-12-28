as yet unclassified
buildSelection
|area selectedNodes|
area := Rectangle origin: startPosition corner: endPosition.

selectedNodes := client children select:[:each| area containsRect: each bounds inParent asRectangle].
selectedNodes do:[:each| currentSelections add: (BlElementSelection on: each)].