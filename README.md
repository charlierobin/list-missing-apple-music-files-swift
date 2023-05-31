# Swift command line app to list missing Apple Music files
 
This app tries to access the user’s Music library, and goes over all the found tracks, checking that they have a non-null `location` value.

Tracks with a null `location` value are output to `stdout`.

Non-null values are assumed to be a valid path and are checked using the default file manager.

If no file is found, the track’s details are output to `stdout`.

[This is basically similar to this app here, except it works on the “live” Apple iTunes Library framework.](https://github.com/charlierobin/list-missing-apple-music-files)

[More information on the iTunes Library framework …](https://developer.apple.com/documentation/ituneslibrary)

[More information on the FileManager class …](https://developer.apple.com/documentation/foundation/filemanager)

