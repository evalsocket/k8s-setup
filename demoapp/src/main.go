package main

import (
	"encoding/json"
	"net/http"
	"os"
)

func printEnv(w http.ResponseWriter, r *http.Request) {
	message := os.Environ()
	js, err := json.Marshal(message)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(js)
}

func main() {
	http.HandleFunc("/", printEnv)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
