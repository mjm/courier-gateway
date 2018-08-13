# Code generated by protoc-gen-twirp_ruby 1.0.0, DO NOT EDIT.
require 'twirp'
require_relative 'courier_gateway_pb.rb'

module Courier
  class ApiService < Twirp::Service
    package 'courier'
    service 'Api'
    rpc :GetUserInfo, UserInfoRequest, UserInfo, :ruby_method => :get_user_info
    rpc :GetPosts, PostsRequest, PostList, :ruby_method => :get_posts
    rpc :CancelTweet, CancelTweetRequest, PostTweet, :ruby_method => :cancel_tweet
    rpc :UpdateTweet, UpdateTweetRequest, PostTweet, :ruby_method => :update_tweet
    rpc :GetFeeds, FeedsRequest, FeedList, :ruby_method => :get_feeds
    rpc :RegisterFeed, RegisterFeedRequest, Feed, :ruby_method => :register_feed
    rpc :RefreshFeed, RefreshFeedRequest, JobStatus, :ruby_method => :refresh_feed
  end

  class ApiClient < Twirp::Client
    client_for ApiService
  end
end
