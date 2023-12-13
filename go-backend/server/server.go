package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"

	"google.golang.org/grpc"

	pb "github.com/elasticspoon/gruby-chat-s/rpc"
)

var (
	tls        = flag.Bool("tls", false, "Connection uses TLS if true, else plain TCP")
	certFile   = flag.String("cert_file", "", "The TLS cert file")
	keyFile    = flag.String("key_file", "", "The TLS key file")
	jsonDBFile = flag.String("json_db_file", "", "A json file containing a list of features")
	port       = flag.Int("port", 50051, "The server port")
)

type chatServer struct {
	pb.UnimplementedChatServer
}

func (c *chatServer) SaveMessage(ctx context.Context, in *pb.ChatMessage) (*pb.MessageResponse, error) {
	return nil, nil
}

func (c *chatServer) SendMessage(ctx context.Context, in *pb.ChatMessage) (*pb.MessageResponse, error) {
	return nil, nil
}

func (c *chatServer) GetLocation(in *pb.LocationRequest, ls pb.Chat_GetLocationServer) error {
	return nil
}

func newServer() *chatServer {
	s := &chatServer{}
	return s
}

func main() {
	flag.Parse()
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", *port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	pb.RegisterChatServer(grpcServer, newServer())
	grpcServer.Serve(lis)
}
