# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: users.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "UserMessage" do
    optional :username, :string, 1
    optional :name, :string, 2
    optional :subscribed, :bool, 3
    optional :subscription_expires_at, :string, 4
  end
end

UserMessage = Google::Protobuf::DescriptorPool.generated_pool.lookup("UserMessage").msgclass