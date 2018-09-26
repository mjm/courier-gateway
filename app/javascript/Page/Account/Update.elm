module Page.Account.Update exposing (update)

import Http
import Page
import Page.Account.Model exposing (Message(..), Model)
import Page.Helper exposing (addError, dismissModal, modalInProgress, showModal)
import Request.User


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        PageMsg msg ->
            handlePageMessage msg model

        EventOccurred event ->
            ( model, Cmd.none )

        CancelSubscription ->
            ( showModal model cancelSubscriptionModal, Cmd.none )

        ConfirmCancelSubscription ->
            ( modalInProgress model
            , Http.send SubscriptionCanceled Request.User.cancelSubscription
            )

        SubscriptionCanceled (Ok user) ->
            ( dismissModal { model | page = Page.updateUser model.page user }, Cmd.none )

        SubscriptionCanceled (Err _) ->
            ( dismissModal model, Cmd.none )

        ReactivateSubscription ->
            ( showModal model reactivateSubscriptionModal, Cmd.none )

        ConfirmReactivateSubscription ->
            ( modalInProgress model
            , Http.send SubscriptionReactivated Request.User.reactivateSubscription
            )

        SubscriptionReactivated (Ok user) ->
            ( dismissModal { model | page = Page.updateUser model.page user }, Cmd.none )

        SubscriptionReactivated (Err _) ->
            ( dismissModal model, Cmd.none )


handlePageMessage : Page.Message -> Model -> ( Model, Cmd Message )
handlePageMessage msg model =
    let
        ( page, cmd ) =
            Page.update msg model.page
    in
    ( { model | page = page }, cmd )


cancelSubscriptionModal : Page.Modal Message
cancelSubscriptionModal =
    { title = "Are you sure?"
    , body = "Are you sure you want to cancel your subscription? You can resubscribe at any time. Courier will remain usable until your subscription expires."
    , confirmText = "Cancel Subscription"
    , confirmMsg = ConfirmCancelSubscription
    }


reactivateSubscriptionModal : Page.Modal Message
reactivateSubscriptionModal =
    { title = "Are you sure?"
    , body = "Are you sure you want to reactivate your subscription? Your subscription will renew at the end of your current billing period."
    , confirmText = "Reactivate Subscription"
    , confirmMsg = ConfirmReactivateSubscription
    }
