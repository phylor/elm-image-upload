port module Ports exposing (ImagePortData, fileContentRead, fileSelected)


type alias ImagePortData =
    { contents : String
    , filename : String
    }


port fileSelected : String -> Cmd msg


port fileContentRead : (ImagePortData -> msg) -> Sub msg
