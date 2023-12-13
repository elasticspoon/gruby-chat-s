#!/usr/bin/env bash

set -e

grpc_tools_ruby_protoc -I rpc --ruby_out=chat-server/app/lib/protos --grpc_out=chat-server/app/lib/protos --go-grpc_out=go-backend/ --go_out=go-backend/ chat.proto
