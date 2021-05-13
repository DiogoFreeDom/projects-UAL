const express = require('express');
const fetch = require("node-fetch");
const app = express();
const hostname = '127.0.0.1';
const port = 13370;


app.use(express.static("public"));
app.use(express.json({limit: "1mb"}));
app.get("/Items", function(req, resp) {
    fetch("http://APIRest:8080/Items")
    .then(resposta => resposta.json()
    .then(json => resp.json(json))).catch(err => console.log(err));
});
app.get("/Stock", (req, resp) => {
    fetch("http://APIRest:8080/Items/Stock")
    .then(resposta => resposta.json()
    .then(json => resp.json(json))).catch(err => console.log(err));
});
app.get("/Entregas", (req, resp) => {
    fetch("http://APIRest:8080/Entregas")
    .then(resposta => resposta.json()
    .then(json => resp.json(json))).catch(err => console.log(err));
});
app.listen(port, () => console.log("listening at " + port));

console.log("Servidor Iniciado");
