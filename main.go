package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	ginprometheus "github.com/zsais/go-gin-prometheus"
)

func main() {
	log.Println("Configuring router ...")
	router := gin.Default()

	// Prometheus middleware
	log.Println("Configuring Prometheus metrics ...")
	p := ginprometheus.NewPrometheus("gin")
	p.Use(router)

	log.Println("Configuring handler ...")
	router.GET("/users", func(ctx *gin.Context) {
		log.Println("request received. IP", ctx.Request.RemoteAddr)
		var users = []struct {
			Name   string `json:"name"`
			Age    int    `json:"age"`
			Status string `json:"status"`
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

	log.Println("Running server on: 8080")
	router.Run(":8080")
}
