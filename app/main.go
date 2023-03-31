package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

type RdsConfig struct {
	Name     string `json:"name"`
	Password string `json:"password"`
	Username string `json:"username"`
	DBName   string `json:"dbname"`
	Host     string `json:"host"`
	Port     string `json:"port"`
}

func main() {
	r := gin.Default()

	env := os.Getenv("USERS_APP")

	var rdsConfig RdsConfig

	err := json.Unmarshal([]byte(env), &rdsConfig)
	if err != nil {
		fmt.Println(err) // panic
	}

	dbConenct(rdsConfig.Host, rdsConfig.Username, rdsConfig.Password, rdsConfig.DBName, rdsConfig.Port)

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"env":     env,
			"message": "pong",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080
}

func dbConenct(host, username, password, dbname, port string) {
	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable", host, port, username, password, dbname)
	result, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(result)
}
