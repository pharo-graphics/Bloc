Class {
	#name : #BlGeometryElementExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Geometry'
}

{ #category : #'instance creation' }
BlGeometryElementExamples >> attachPoint [
	<gtExample>	

	^ BlElement new
		geometry: BlEllipse new;
		size: 30@30;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'instance creation' }
BlGeometryElementExamples >> container [
	<gtExample>
	
	^ BlElement new
		background: Color white;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]
