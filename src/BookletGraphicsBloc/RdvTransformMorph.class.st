Class {
	#name : #RdvTransformMorph,
	#superclass : #Object,
	#instVars : [
		'window',
		'pane',
		'board',
		'background',
		'scaler'
	],
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #'instance creation' }
RdvTransformMorph >> open [
	<script: 'self new transformMorph'>
]

{ #category : #'instance creation' }
RdvTransformMorph >> transformMorph [

background := AlphaImageMorph withForm: (ZnEasy getJpeg: 'http://i.imgur.com/K1QR9vA.jpg').
background lock.

board := PasteUpMorph new.
board color: Color gray;
borderWidth: 3;
borderColor: Color black;
extent: background extent;
backgroundMorph: background;
addMorph: (CircleMorph new color: Color cyan; position: 41@23; yourself);
addMorph: (Morph new color: Color orange; position: 1200@1200; yourself). 

scaler := TransformMorph new.
scaler extent: background extent * 0.1.
scaler scale: 0.1@0.1.
scaler addMorph: board.

pane := ScrollPane new.
pane scroller addMorph: scaler.

window := pane openInWindow.
window position: 20@20; extent: 420@420.
]
