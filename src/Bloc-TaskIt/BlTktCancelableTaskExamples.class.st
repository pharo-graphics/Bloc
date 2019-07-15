Class {
	#name : #BlTktCancelableTaskExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> pauseElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlGridLayout new cellSpacing: 5);
		geometry: (BlCircle new);
		addChild: self pauseRectangleElement;
		addChild: self pauseRectangleElement;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 3).
			c vertical fitContent.
			c horizontal fitContent ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryLightGray ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | self inform: 'click' ].
	^ anElement 
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> pauseRectangleElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		geometry: BlRectangle new;
		background: Color darkGray;
		size: 5@15.
	^ anElement 
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> playElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlLinearLayout new);
		geometry: (BlCircle new);
		addChild: self playTriangleElement;
		border: (BlBorder paint: Color veryLightGray width: 1);
		constraintsDo: [ :c | 
			c padding: (BlInsets all: 5).
			c vertical fitContent.
			c horizontal fitContent ];
		addEventHandlerOn: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryLightGray ];
		addEventHandlerOn: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		addEventHandlerOn: BlClickEvent do: [ :anEvent | self inform: 'click' ].
	^ anElement 
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> playPolygon [
	<gtExample>
	^ BlPolygon vertices: {
		0@0.
		15@7.
		0@15.
		0@0.
	}
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> playTriangleElement [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		geometry: self playPolygon;
		background: Color darkGray;
		size: 15@15.
	^ anElement 
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> progressBar [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: BlFrameLayout new;
		background: Color white;
		border: (BlBorder paint: Color lightGray muchLighter width: 1);
		padding: (BlInsets all: 1);
		size: 200@7;
		addChild: self progressLine.
	^ anElement 
]

{ #category : #'example - ui elements' }
BlTktCancelableTaskExamples >> progressLine [
	<gtExample>
	| anElement |
	anElement := BlElement new.
	anElement 
		layout: (BlLinearLayout new);
		background: Color veryLightGray;
		size: 50@5.
	^ anElement 
]
