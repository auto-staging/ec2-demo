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

func indexHandler(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("templates/index.html"))
	data := templateData{
		InstanceID: getInstanceID(),
	}

	err := tmpl.Execute(w, data)
	if err != nil {
		log.Println(err)
	}
}

func main() {
	http.Handle("/css/", http.FileServer(http.Dir("static")))
	http.HandleFunc("/", indexHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func getInstanceID() string {
	resp, err := http.Get("http://169.254.169.254/latest/dynamic/instance-id")
	if err != nil {
		log.Println(err)
		return "null"
	}
	defer resp.Body.Close()

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Println(err)
		return "null"
	}

	log.Println("Received: " + string(respBody))

	return string(respBody)
}
