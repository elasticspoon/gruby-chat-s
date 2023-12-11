package server

import (
	"context"
	"sync"

	"google.golang.org/grpc"

	pb "github.com/elasticspoon/gruby-chat-s/protos"
)

type chatClient struct {
	pb.UnimplementedRouteGuideServer
	savedFeatures []*pb.Feature // read-only after initialized

	mu         sync.Mutex // protects routeNotes
	routeNotes map[string][]*pb.RouteNote
}

func (c *chatClient) SaveMessage(ctx context.Context, in *ChatMessage, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, Chat_SaveMessage_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *chatClient) SendMessage(ctx context.Context, in *ChatMessage, opts ...grpc.CallOption) (*MessageResponse, error) {
	out := new(MessageResponse)
	err := c.cc.Invoke(ctx, Chat_SendMessage_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *chatClient) GetLocation(ctx context.Context, in *LocationRequest, opts ...grpc.CallOption) (Chat_GetLocationClient, error) {
	stream, err := c.cc.NewStream(ctx, &Chat_ServiceDesc.Streams[0], Chat_GetLocation_FullMethodName, opts...)
	if err != nil {
		return nil, err
	}
	x := &chatGetLocationClient{stream}
	if err := x.ClientStream.SendMsg(in); err != nil {
		return nil, err
	}
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	return x, nil
}
