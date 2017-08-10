package main

import (
	"fmt"
	"net/http"
	"net/url"
	"log"
)

	//hit a url and get the status code from the response
	func getCart()  int {

		var URL = "http://10.207.139.38:8080/"
		fmt.Println("url string:",URL)

		client := &http.Client{}

			v := url.Values{}
		fmt.Println("v is :",v)
		req, err := http.NewRequest("POST", URL, nil)
			req.SetBasicAuth("abc", "pass@321")
			resp, err := client.Do(req)
			//fmt.Println("status code:",resp.StatusCode)

			if err != nil {
			log.Fatal(err)
			}
			return (resp.StatusCode)
		}

func main() {


code := getCart()
	fmt.Println("status code:",code)


}
