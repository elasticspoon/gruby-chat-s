#!/usr/bin/env bash

set -e

grpc_tools_ruby_protoc -I protos --ruby_out=chat-server/app/lib/protos --grpc_out=chat-server/app/lib/protos chat.proto
