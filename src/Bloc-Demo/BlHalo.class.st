Class {
	#name : #BlHalo,
	#superclass : #BlElement,
	#instVars : [
		'paint',
		'name',
		'description',
		'actionBlock',
		'container'
	],
	#category : #'Bloc-Demo-Halos'
}

{ #category : #inspecting }
BlHalo class >> delete [

	| deleteHalo |
	deleteHalo := self new
		  paint: Color red;
		  actionBlock: [ :evt |
			  evt consume.
			  deleteHalo decorated removeFromParent ];
		  name: 'Delete';
		  description: 'Click to delete the element';
		  constraintsDo: [ :c |
			  c frame vertical alignTop.
			  c frame horizontal alignRight ];
		  yourself.
		
	^ deleteHalo
]

{ #category : #inspecting }
BlHalo class >> inspect [

	| inspectHalo |
	inspectHalo := self new
		  paint: Color blue;
		  actionBlock: [ :evt |
			  evt consume.
			  inspectHalo decorated inspect ];
		  name: 'Inspect';
		  description: 'Click to inspect the element';
		  constraintsDo: [ :c |
			  c frame vertical alignTop.
			  c frame horizontal alignLeft ];
		  yourself.
		
	^ inspectHalo 
]

{ #category : #inspecting }
BlHalo class >> resize [

	| resizeHalo initialPosition initialSize |
	
	resizeHalo := self new
		  paint: Color yellow;
		  actionBlock: [ :evt :halo |
			  evt consume ];
		  name: 'Resize';
		  description: 'Drag to resize the element';
		  constraintsDo: [ :c |
			  c frame vertical alignBottom.
			  c frame horizontal alignRight ];
		  yourself.


	resizeHalo addEventHandler: (BlEventHandler
			 on: BlDragStartEvent
			 do: [ :evt |
				 initialPosition := evt position.
				 initialSize := resizeHalo decorated extent.
				 evt consume ]).
	resizeHalo addEventHandler: (BlEventHandler
			 on: BlDragEndEvent
			 do: [ :evt | evt consume ]).
	resizeHalo addEventHandler: (BlEventHandler
			 on: BlDragEvent
			 do: [ :evt |
				 evt consume.
				 resizeHalo decorated size: initialSize + evt position - initialPosition ]).

	^ resizeHalo 
]

{ #category : #accessing }
BlHalo >> actionBlock [

	^ actionBlock
]

{ #category : #accessing }
BlHalo >> actionBlock: aBlockClosure [

	actionBlock := aBlockClosure
]

{ #category : #accessing }
BlHalo >> container [ 

	^ container
]

{ #category : #accessing }
BlHalo >> container: aBlHaloContainer [

	container := aBlHaloContainer 
]

{ #category : #accessing }
BlHalo >> decorated [ 

	^ self container decorated
]

{ #category : #accessing }
BlHalo >> description [ 

	^ description 
]

{ #category : #accessing }
BlHalo >> description: aRopedText [

	description := aRopedText 
]

{ #category : #initialization }
BlHalo >> initialize [

	super initialize.
	self
		geometry: BlEllipseGeometry new;
		size: 20 asPoint;
		background: Color white;
		opacity: 0.8.
	self name: 'Unnamed'.
	self description: 'No description yet'.

	self
		addEventHandlerOn: BlClickEvent
		do: [ :evt | self actionBlock value: evt].

	self constraintsDo: [ :c | c margin: (BlInsets all: -22) ]
]

{ #category : #accessing }
BlHalo >> name [ 

	^ name
]

{ #category : #accessing }
BlHalo >> name: aRopedText [ 

	name := aRopedText 
]

{ #category : #accessing }
BlHalo >> paint [ 
	
	^ paint
]

{ #category : #accessing }
BlHalo >> paint: aBlPaint [

	paint := aBlPaint.
	self background: paint
]
