I am a host that allows users to embed Bloc spaces inside of arbitrary morphs.
It is required to provide set a ==containerMorph== where bloc space will be embedded.

The main difference between me and BlMorphicWindowHost is the fact that I don't support window-specific properties like #borderless, #minimized, #maximized etc.

Because of Morphic limitations it is not possible to send an event when space is opened in the World.

Example:

[[[
morph := Morph new.
"container morph could also have #spaceFill resizing"
morph extent: 700@700.
"set layout policy to container morph in order for bloc space to fill space"
morph layoutPolicy: TableLayout new.

host := BlMorphicHost new.
host containerMorph: morph.

space := BlSpace new.
space host: host.
space show
]]]