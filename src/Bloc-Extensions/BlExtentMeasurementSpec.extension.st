Extension { #name : #BlExtentMeasurementSpec }

{ #category : #'*Bloc-Extensions' }
BlExtentMeasurementSpec >> gtInspectorSpecIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ composite fastTable
		title: 'Spec' translated;
		display: [ { 'width' -> self widthSpec . 'height' -> self heightSpec } ];
		selectionTransformation: #value;
		column: 'Dimension' 
			evaluated: [ :each | each key ];
		column: 'Size' 
			evaluated: [ :each | each value asString ]
]
