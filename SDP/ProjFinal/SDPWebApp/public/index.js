fetch("/Items").then(resp => resp.json()
.then(json => printTabela(json, document.getElementById("tabelaItems")))
.catch(err => console.log(err)));

fetch("/Stock").then(resp => resp.json()
.then(json => printTabela(json, document.getElementById("tabelaStock")))
.catch(err => console.log(err)));

fetch("/Entregas").then(resp => resp.json())
.then(json => {
        console.log(json);
        let table = document.getElementById("tabelaEntregas");
        for(i in json){
            let row = document.createElement("tr");
            let numEntrega = document.createElement("td");
            numEntrega.setAttribute("rowspan", json[i].items.length);
            numEntrega.appendChild(document.createTextNode(i));
            row.appendChild(numEntrega);
            let local = document.createElement("td");
            local.setAttribute("rowspan", json[i].items.length);
            local.appendChild(document.createTextNode(json[i].local));
            row.appendChild(local);
            for(j = 0; j < json[i].items.length; j++){
                let shortRow = document.createElement("tr");
                let nome = document.createElement("td");
                nome.appendChild(document.createTextNode(json[i].items[j].nome));
                let quantidade = document.createElement("td");
                quantidade.appendChild(document.createTextNode(json[i].items[j].quantidade));
                if (j == 0){
                    row.appendChild(nome);
                    row.appendChild(quantidade);
                    table.appendChild(row);
                } else {
                    shortRow.appendChild(nome);
                    shortRow.appendChild(quantidade);
                    table.append(shortRow);
                }
            }
        }
}).catch(err => console.log(err));

function printTabela(json, table){
    for(i in json) {
        let row = document.createElement("tr");
        row.appendChild(document.createElement("td")).appendChild(document.createTextNode(i));
        for(j in json[i]){
            var cell = document.createElement("td");
            var text = document.createTextNode(json[i][j]);
            cell.appendChild(text);
            row.appendChild(cell);
        }
        table.appendChild(row);
    }
}