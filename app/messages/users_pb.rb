# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: users.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "CreateSubscriptionRequest" do
    optional :email, :string, 1
    optional :token_id, :string, 2
  end
  add_message "CreateSubscriptionResponse" do
    optional :user, :message, 1, "UserMessage"
  end
  add_message "CancelSubscriptionRequest" do
  end
  add_message "CancelSubscriptionResponse" do
    optional :user, :message, 1, "UserMessage"
  end
  add_message "ReactivateSubscriptionRequest" do
  end
  add_message "ReactivateSubscriptionResponse" do
    optional :user, :message, 1, "UserMessage"
  end
  add_message "UserMessage" do
    optional :username, :string, 1
    optional :name, :string, 2
    optional :subscribed, :bool, 3
    optional :subscription_expires_at, :string, 4
    optional :subscription_renews_at, :string, 5
    optional :card, :message, 6, "CardMessage"
  end
  add_message "CardMessage" do
    optional :brand, :string, 1
    optional :last_four, :string, 2
    optional :exp_month, :int32, 3
    optional :exp_year, :int32, 4
  end
end

CreateSubscriptionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("CreateSubscriptionRequest").msgclass
CreateSubscriptionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("CreateSubscriptionResponse").msgclass
CancelSubscriptionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("CancelSubscriptionRequest").msgclass
CancelSubscriptionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("CancelSubscriptionResponse").msgclass
ReactivateSubscriptionRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("ReactivateSubscriptionRequest").msgclass
ReactivateSubscriptionResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("ReactivateSubscriptionResponse").msgclass
UserMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("UserMessage").msgclass
CardMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("CardMessage").msgclass
