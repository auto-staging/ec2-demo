package main

import (
	"html/template"
	"io/ioutil"
	"log"
	"net/http"
)

type templateData struct {
	InstanceID string
}

var instanceID string

func indexHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/index.html"))
	data := templateData{
		InstanceID: instanceID,
	}

	err := tmpl.Execute(w, data)
	if err != nil {
		log.Println(err)
	}
}

func main() {
	getInstanceID()
	http.Handle("/css/", http.FileServer(http.Dir("static")))
	http.HandleFunc("/", indexHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func getInstanceID() {
	resp, err := http.Get("http://169.254.169.254/latest/meta-data/instance-id")
	if err != nil {
		log.Println(err)
		instanceID = "null"
		return
	}
	defer resp.Body.Close()

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Println(err)
		instanceID = "null"
		return
	}

	log.Println("Received: " + string(respBody))

	instanceID = string(respBody)
}
