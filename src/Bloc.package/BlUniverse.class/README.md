I am the lowest level in Bloc.
My responsibility is to manage the low-level services such as managing windows, event queue and the drawing synchronization. 

My main responsibility is to manage and to keep in sync the opened Spaces.

I am the interface used to create/delete window.
To achieve that, i use the notion of Host (see: BlHost).

Users can choose a preferable host. In order to do that a universe must be stopped first.
Example:

universe stop.
universe preferableHost: MyHost new.
universe start.