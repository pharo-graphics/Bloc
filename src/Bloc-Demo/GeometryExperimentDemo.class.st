Class {
	#name : #GeometryExperimentDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-Classes'
}

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> annulus [

	<bookExample>
	^ BlElement new
		  geometry: (BlAnnulusSectorGeometry new
				   startAngle: 225;
				   endAngle: 360;
				   innerRadius: 0.3;
				   outerRadius: 0.9);
		  size: 100 @ 100;
		  background: self background;
		  border: self border
]

{ #category : #accessing }
GeometryExperimentDemo >> background [

	^ Color yellow
]

{ #category : #'border - demo' }
GeometryExperimentDemo >> basicBorder [

	<bookExample>
	^BlElement new
		geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		background: self background;
		border: (BlBorder paint: Color red width: 5);
		size: 100 @ 100
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> bezier [

	<bookExample>
	^BlElement new
		geometry: (BlBezierCurveGeometry controlPoints: { 5@0. 25@80. 75@30. 95@100 });
		size: 100 @ 100;
		background: self background;
		outskirts: (BlOutskirts centered);
		border: self border
]

{ #category : #accessing }
GeometryExperimentDemo >> border [

	^ BlBorder paint: Color red width: 5
]

{ #category : #'border - demo' }
GeometryExperimentDemo >> builderBorder [

	<bookExample>
	^BlElement new
		geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		background: self background;
		border: (BlBorder builder paint: Color red; width: 5; build);
		size: 100 @ 100
]

{ #category : #'border - demo' }
GeometryExperimentDemo >> builderCapButtBorder [

	<bookExample>
	^ BlElement new
		  geometry: (BlTriangleGeometry new
				 matchExtent: 100 @ 200;
				 beLeft);
		  background: self background;
		  border: (BlBorder builder
				   paint: Color red;
				   width: 5;
				   lineCap: BlStrokeLineCap butt;
				   lineJoin: BlStrokeLineJoin bevel;
				miterLimit: 2.0;
				dashArray: #(10 5);
				dashOffset: 0;
				   build);
		  size: 200 @ 200
]

{ #category : #'border - demo' }
GeometryExperimentDemo >> builderOpacityBorder [

	<bookExample>
	^BlElement new
		geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		background: self background;
		border: (BlBorder builder paint: Color red; width: 5; opacity: 0.1; build);
		size: 100 @ 100  
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> circle [

	<bookExample>
	^BlElement new
		geometry: (BlCircleGeometry new matchExtent: 100 @ 50);
		size: 100 @ 100;
		background: self background;
		border: self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> ellipse [

	<bookExample>
	^BlElement new
		geometry: (BlEllipseGeometry new matchExtent: 100 @ 50);
		size: 100 @ 50;
		background: self background;
		border: self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> line [

	<bookExample>
	^BlElement new
		geometry: (BlLineGeometry from: 0@0 to: 50@50);
		size: 100 @ 100;
		background: self background;
		outskirts: (BlOutskirts centered );
		border: self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> polygon [

	<bookExample>
	^BlElement new
		geometry: (BlPolygonGeometry vertices: {
						 (10 @ 10).
						 (10 @ 90).
						 (50 @ 50).
						 (90 @ 90).
						 (90 @ 10) });
		size: 100 @ 100;
		background: self background;
		border:self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> polyline [

	<bookExample>
	^BlElement new
		geometry: (BlPolylineGeometry vertices: {
						 (10 @ 10).
						 (10 @ 90).
						 (50 @ 50).
						 (90 @ 90).
						 (90 @ 10) });
		size: 100 @ 100;
		background: self background;
		border: self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> rectangle [

	<bookExample>
	^BlElement new
		geometry: (BlRectangleGeometry  new);
		background: self background;
		border: self border;
		size: 100 @ 70
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> roundedRectangle [

	<bookExample>
	^BlElement new
		geometry: (BlRoundedRectangleGeometry cornerRadius: 20);
		background: self background;
		border: self border;
		size: 100 @ 70
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> square [

	<bookExample>
	^BlElement new
		geometry: (BlSquareGeometry new matchExtent: 70 @ 70);
		size: 100 @ 100;
		background: self background;
		border: self border
]

{ #category : #'geometry - demo' }
GeometryExperimentDemo >> triangle [

	<bookExample>
	^BlElement new
		geometry: (BlTriangleGeometry new
				 matchExtent: 50 @ 100;
				 beLeft);
		background: self background;
		border: self border;
		size: 100 @ 100
]
