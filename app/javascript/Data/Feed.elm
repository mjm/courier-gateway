module Data.Feed exposing (Feed, DraftFeed, decoder, listDecoder, encode)

import Json.Decode as Decode exposing (Decoder, int, string, list)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode exposing (Value)


type alias Feed =
    { id : Int
    , url : String
    }


type alias DraftFeed =
    { url : String }


decoder : Decoder Feed
decoder =
    decode Feed
        |> required "id" int
        |> required "url" string


listDecoder : Decoder (List Feed)
listDecoder =
    Decode.list decoder


encode : DraftFeed -> Value
encode feed =
    Encode.object
        [ ( "url", Encode.string feed.url ) ]
