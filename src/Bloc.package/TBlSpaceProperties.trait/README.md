I define interface for accessing space properties such as title, extent, borderless, fullscreen, position.
I must be implemented by all host spaces for window specific implementation.

By using this Trait in both Space and HostSpace we make sure that they have the same uniform API