Class {
	#name : #BlHalosScriptExperiments,
	#superclass : #Object,
	#category : #'Bloc-Demo-Halos'
}

{ #category : #'as yet unclassified' }
BlHalosScriptExperiments class >> experimentHoverToSeeHalosDecription [

	<script>
	| elt haloContainer |
	elt := BlElement new
		       background: Color lightRed;
		       clipChildren: false;
		       extent: 150 asPoint;
		       position: 100 asPoint.
	haloContainer := BlElement new
		                 background: Color lightGreen;
		                 layout: BlLinearLayout horizontal;
		                 constraintsDo: [ :c |
			                 c vertical fitContent.
			                 c horizontal fitContent.
			                 c padding: (BlInsets all: 5) ];
		                 position: 0 @ -30;
		                 clipChildren: false.

	elt addEventHandlerOn: BlDragEvent do: [ :e | 'drag' traceCr].

	elt addEventHandlerOn: BlDragEvent do: [ :e | elt inspect ].

	elt addEventHandlerOn: BlDragStartEvent do: [ :e | elt inspect ].

	elt addEventHandlerOn: BlClickEvent do: [ :event |
		(event modifiers isCtrl and: event modifiers isShift) ifTrue: [
			(elt hasChild: haloContainer)
				ifFalse: [
					haloContainer removeChildren.
					elt eventDispatcher handlersDo: [ :handler |
						| handlerElt textElt |
						handlerElt := BlElement new
							              extent: 20 asPoint;
							              background: Color random;
							              clipChildren: false;
							              constraintsDo: [ :c |
								              c margin: (BlInsets all: 2) ].
						handlerElt
							addEventHandlerOn: BlClickEvent
							do: [ :e | handlerElt inspect ].
						textElt := BlTextElement new
							           text: handler action asText asRopedText;
							           background: Color lightYellow;
							           position: 0 @ 20.
						textElt text fontSize: 15.
						handlerElt
							addEventHandlerOn: BlMouseEnterEvent
							do: [ :e | handlerElt addChild: textElt ].
						handlerElt
							addEventHandlerOn: BlMouseLeaveEvent
							do: [ :e | handlerElt removeChild: textElt ].

						haloContainer addChild: handlerElt ].
					elt addChild: haloContainer ]
				ifTrue: [ elt removeChild: haloContainer ] ] ].



	elt openInSpace
]

{ #category : #'as yet unclassified' }
BlHalosScriptExperiments class >> experimentInspectOnCtrlShift [

	<script>
	| elt |
	elt := BlElement new background: Color lightRed.

	elt addEventHandlerOn: BlClickEvent do: [ :event |
		(event modifiers isCtrl and: event modifiers isShift) ifTrue: [
			event inspect ] ].

	elt openInSpace
]

{ #category : #'as yet unclassified' }
BlHalosScriptExperiments class >> experimentNewHalosOnShiftAltClick [

	<script>

	| aContainer aSpace aPosition anEvent child |
	"shift+alt+click on the element shows the halo"
	aContainer := BlElement new
		              background: Color lightRed;
		              extent: 300 asPoint;
		              position: 50 asPoint.
	child := BlElement new
		         background: Color lightBlue;
		         extent: 100 asPoint;
		         position: 10 asPoint.

	aContainer addChild: child.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.
	aSpace addHalosListenerNewPrototype.


	aSpace show
]
