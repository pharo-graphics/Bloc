I represent rectangular bounds of the element.

I consist of position and extent.
I know an owner element to which I belong and provide an ability of converting bounds between coordinate systems, for example from local to parent coordinates,  local to space coordinates and the other way around.

Extent is given in local coordinates of the owner element.
Position is given in coordinates of the parent of the owner element without taking transformation matrix into account.

