module Page.Feeds.View exposing (view)

import Data.Feed exposing (Feed, DraftFeed)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Events.Extra exposing (onClickPreventDefault)
import Page.Feeds.Model exposing (Model)
import Page.Feeds.Update exposing (Message(..))
import Views.Error as Error
import Views.Icon exposing (..)
import Views.Page as Page
import Util.Loadable exposing (Loadable(..))


view : Model -> Html Message
view model =
    [ Page.navbar model.user
    , Error.errors DismissError model.errors
    , pageContent model
    , Page.footer
    ]
        |> div []


pageContent : Model -> Html Message
pageContent model =
    section [ class "section" ]
        [ div [ class "container" ]
            [ h1 [ class "title has-text-centered" ] [ text "Your Feeds" ]
            , p [ class "has-text-centered" ] [ text "Your Courier will periodically check these feeds for new posts to send to Twitter." ]
            , hr [] []
            , div [ class "columns" ]
                [ div [ class "column is-8 is-offset-2" ]
                    [ feeds model.feeds
                    , addFeedView model
                    ]
                ]
            ]
        ]


feeds : Loadable (List Feed) -> Html Message
feeds fs =
    case fs of
        Loading ->
            p [ class "has-text-centered is-size-5" ]
                [ span [ class "rotating icon is-medium" ] [ i [ class "fas fa-spinner" ] [] ]
                , span [] [ text "Loading feeds..." ]
                , p [] [ text " " ]
                ]

        Loaded [] ->
            p [ class "has-text-centered" ]
                [ text "You don't have any feeds registered." ]

        Loaded fs ->
            table [ class "table is-fullwidth" ]
                [ List.map feedRow fs |> tbody [] ]


feedRow : Feed -> Html Message
feedRow feed =
    tr []
        [ td []
            [ span [ class "icon is-medium has-text-link" ]
                [ i [ class "fas fa-rss fa-lg" ] [] ]
            , span [ class "is-size-5" ] [ text feed.url ]
            ]
        , td [] [ feedDropdown feed ]
        ]


feedDropdown : Feed -> Html Message
feedDropdown feed =
    div [ class "dropdown is-hoverable" ]
        [ div [ class "dropdown-trigger" ]
            [ button [ class "button is-white" ]
                [ icon Solid "bars" ]
            ]
        , div [ class "dropdown-menu" ]
            [ div [ class "dropdown-content" ]
                [ a
                    [ class "dropdown-item"
                    , onClick (RefreshFeed feed)
                    ]
                    [ icon Solid "sync-alt"
                    , span [] [ text "Refresh Posts" ]
                    ]
                , a [ class "dropdown-item has-text-danger" ]
                    [ icon Solid "trash"
                    , span [] [ text "Delete Feed" ]
                    ]
                ]
            ]
        ]


addFeedView : Model -> Html Message
addFeedView model =
    case model.draftFeed of
        Just feed ->
            addFeedForm feed

        Nothing ->
            addFeedButton


addFeedButton : Html Message
addFeedButton =
    p [ class "has-text-centered" ]
        [ button
            [ class "button is-rounded is-primary is-large"
            , onClick (SetAddingFeed True)
            ]
            [ icon Solid "plus-circle"
            , span [] [ text "Add Feed" ]
            ]
        ]


addFeedForm : DraftFeed -> Html Message
addFeedForm feed =
    Html.form
        [ action "javascript:void(0);"
        , onSubmit AddFeed
        ]
        [ div [ class "field" ]
            [ div [ class "control" ]
                [ input
                    [ id "add-feed-url"
                    , type_ "text"
                    , class "input is-medium"
                    , placeholder "Feed URL"
                    , onInput SetDraftFeedUrl
                    , value feed.url
                    ]
                    []
                ]
            ]
        , div [ class "field is-grouped is-grouped-right" ]
            [ p [ class "control" ]
                [ button
                    [ class "button is-light"
                    , onClickPreventDefault (SetAddingFeed False)
                    ]
                    [ text "Cancel" ]
                ]
            , p [ class "control" ]
                [ button [ class "button is-primary" ]
                    [ text "Add Feed" ]
                ]
            ]
        ]