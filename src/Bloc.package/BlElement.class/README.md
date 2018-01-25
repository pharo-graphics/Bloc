I manage children using a layout strategy and can be resizeable.
By default  I am drawn as a rectangle but I can be made to use any geometry by specifying the geometry property. The geometry is only used to define the geometry to be drawn and the interaction area.

I am the superclass to create widgets.

Elements can be composed:
[[[
parent := BlElement new.
child := BlElement new.
parent addChild: child			
]]]

Change background:
[[[
element := BlElement new.
element background: Color blue.			
]]]

Change border:
[[[
element := BlElement new.
element border: (BlBorder paint: Color red width: 2).
]]]

Add on click handler:
[[[
element := BlElement new.
element when: BlClickEvent do: [ self inform: 'Clicked!' ].
]]]

I have the following propeties:

 - opacity - defines transparency degree of an element and takes a value in range [ 0...1 ]. Opacity influences children too, meaning that the whole element including its children will become transparent