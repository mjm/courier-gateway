module Data.Tweet exposing (Tweet, PostInfo, Status(..), compare, decoder, listDecoder, update)

import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder, string, int)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Util.Date


type Status
    = Draft
    | Canceled
    | Posted


type alias Tweet =
    { id : Int
    , body : String
    , post : PostInfo
    , status : Status
    , postedAt : Maybe Date
    , tweetId : Maybe String
    }


type alias PostInfo =
    { id : Int
    , url : String
    , publishedAt : Maybe Date
    , modifiedAt : Maybe Date
    }


decoder : Decoder Tweet
decoder =
    decode Tweet
        |> required "id" int
        |> required "body" string
        |> required "post" postDecoder
        |> optional "status" (Decode.map statusFromString string) Draft
        |> optional "postedAt" Util.Date.decoder Nothing
        |> optional "postedTweetId" (Decode.maybe string) Nothing


postDecoder : Decoder PostInfo
postDecoder =
    decode PostInfo
        |> required "id" int
        |> required "url" string
        |> optional "publishedAt" Util.Date.decoder Nothing
        |> optional "modifiedAt" Util.Date.decoder Nothing


listDecoder : Decoder (List Tweet)
listDecoder =
    Decode.list decoder


statusFromString : String -> Status
statusFromString str =
    case str of
        "CANCELED" ->
            Canceled

        "POSTED" ->
            Posted

        _ ->
            Draft


update : Tweet -> Tweet -> Tweet
update existing new =
    if existing.id == new.id then
        new
    else
        existing


compare : Tweet -> Tweet -> Order
compare a b =
    case ( a.post.publishedAt, b.post.publishedAt ) of
        ( Just a, Just b ) ->
            Basics.compare (Date.toTime b) (Date.toTime a)

        ( Just _, Nothing ) ->
            LT

        ( Nothing, Just _ ) ->
            GT

        ( Nothing, Nothing ) ->
            EQ
