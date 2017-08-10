package main

import (
	"fmt"
	"time"

	"gopkg.in/mgo.v2"
)

//const MongoDb details
const (
	hosts      = "10.207.139.24"
	database   = "admin"
	username   = "admin"
	password   = "kohls#321"
	//collection = "system.users"
)

func main() {

	info := &mgo.DialInfo{
		Addrs:    []string{hosts},
		Timeout:  60 * time.Second,
		Database: database,
		Username: username,
		Password: password,
	}

	session, err1 := mgo.DialWithInfo(info)
	if err1 != nil {
		panic(err1)
	}

	col := session.DB("automata").C("users")

	count, err2 := col.Count()
	if err2 != nil {
		panic(err2)
	}
	fmt.Println(fmt.Sprintf("Messages count: %d", count))
}
