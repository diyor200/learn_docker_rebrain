package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jackc/pgx/v5"
	"github.com/redis/go-redis/v9"
)

func main() {
	serverPort := os.Getenv("SERVER_PORT")

	dbUser := os.Getenv("POSTGRES_USER")
	dbHost := os.Getenv("POSTGRES_HOST")
	dbPort := os.Getenv("POSTGRES_PORT")
	dbName := os.Getenv("POSTGRES_DATABASE")
	dbPass := os.Getenv("POSTGRES_PASSWORD")

	redisHost := os.Getenv("REDIS_HOST")
	redisPort := os.Getenv("REDIS_PORT")

	// connect db
	connString := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable", dbUser, dbPass, dbHost, dbPort, dbName)

	var (
		conn *pgx.Conn
		err  error
	)
	for i := 0; i < 5; i++ {
		log.Println("Connecting to db...")
		conn, err = pgx.Connect(context.Background(), connString)
		if err != nil {
			log.Println("Can't connect, sleeping 2s", err)

			time.Sleep(time.Second * 2)
		} else {
			break
		}
	}

	if err != nil {
		panic(err)
	}
	log.Println("Connected to db")

	log.Println("pinging to db...")
	err = conn.Ping(context.Background())
	if err != nil {
		panic(err)
	}
	log.Println("OK")

	// connect redis
	redisConn := redis.NewClient(&redis.Options{
		Addr:     fmt.Sprintf("%s:%s", redisHost, redisPort),
		Password: "",
		DB:       0,
	})

	log.Println("Connecting to redis ...")
	res := redisConn.Ping(context.Background())
	if res.Err() != nil {
		panic(res.Err())
	}
	log.Println("Connected!")

	log.Println("Configuring router ...")
	router := gin.Default()

	log.Println("Configuring handler ...")
	router.GET("/users", func(ctx *gin.Context) {
		log.Println("request received. IP", ctx.Request.RemoteAddr)
		var users = []struct {
			Name   string `json:"name"`
			Age    int    `json:"age"`
			Status string `jsong:"active"`
		}{
			{
				Name:   "Alex",
				Age:    12,
				Status: "active",
			},
			{
				Name:   "John",
				Age:    12,
				Status: "active",
			},
		}

		ctx.JSON(http.StatusOK, gin.H{"users": users})
	})

	log.Println("Running server on", serverPort)
	router.Run(serverPort)
}
