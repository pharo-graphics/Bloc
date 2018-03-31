I encapsulate a concept of time and play a role of a time provider for Animations or other parts of the system that compute durations or how much time passed since some action.

Bloc components must not directly rely on system time or hardcode it in any place because it prevents us from simulating spaces. The use of me makes system exemplifiable