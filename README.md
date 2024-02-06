# ASW-PROJECT-23-24
Porgetto per il corso di [ASW](http://cabibbo.inf.uniroma3.it/asw/) (Architetture dei sistemi sotware).

Corso erogato nell'anno 2023-2024 dal professore [Luca Cabibbo](https://github.com/lucacabibbo) all'Università Roma Tre.

---

### Linguaggi e Tecnologie utilizzate
<img src="https://skillicons.dev/icons?i=java,gradle,spring,postgres,bash,docker,kafka">

---
## Descrizione

Questo progetto contiene il codice per l'applicazione *OrderManager*, una semplice applicazione a microservizi per gestire ordini di prodotti.

L'applicazione *OrderManager* prevede di:
* creare prodotti e modificare la quantità disponibile (stack level);
* creare ordini relativi a uno o più prodotti;
* richiedere la validazione di un ordine.

Un ordine è considerato valido se innanzitutto esiste, se tutti i prodotti ordinati esistono e se le quantità ordinate di ognuno non superano la quantità disponibile.

--- 

L'applicazione *OrderManager* consiste dei seguenti microservizi:

* *product-service*: gestisce i prodotti.
Ogni prodotto ha un nome (con il quale viene identificato), una categoria, un valore di quantità disponibile e un prezzo. 
 
* Operazioni:
  * `POST /products` crea un nuovo prodotto (nome, categoria, quantità disponibile e prezzo, passati nel corpo della richiesta)
  * `GET /products/{name}` trova un prodotto, dato il nome
  * `GET /products` trova tutti i prodotti
  * `POST /findproducts/bynames` trova tutti i prodotti che hanno il nome incluso in una lista di nomi (la lista di nomi è passata nel corpo della richiesta)
  * `PATCH /products` aggiorna la quantità disponibile di un prodotto. 


* *order-service*: gestisce gli ordini.
Ogni ordine ha un id (con il quale viene identificato), un cliente, un indirizzo, un insieme di linee d'ordine (ognuna con nome e quantità del prodotto) e un totale.

* Operazioni:
  * `POST /orders` crea un nuovo ordine (dati del cliente, indirizzo, elementi ordinati e totale, passati nel corpo della richiesta)
  * `GET /orders/{id}` trova un ordine (dato l'id).
  * `GET /orders` trova tutti gli ordini
  * `GET /findorders/customer/{customer}` trova gli ordini di un certo cliente (dato il cliente)
  * `GET /findorders/product/{product}` trova gli ordini contenenti un certo prodotto (dato il prodotto).


* *order-validation-service* permette a un ordine di essere convalidato.
Una validazione dell'ordine consiste di un order-id, alcuni dati dell'ordine (cliente, prodotti ordinati), un indicatore di validità e una motivazione.
* Operazioni:
  * `GET /ordervalidations/{id}` calcola e ritorna la validazione dell'ordine (dato l'id).


* Il servizio *api-gateway* (esposto sulla porta *8080*) è l'application gateway API che:
  * espone *product-service* sul percorso`/product-service` - per esempio, `GET /product-service/products`.
  * espone *order-service* sul percorso `/order-service` - per esempio, `GET /order-service/orders/{id}`
  * espone *order-validation-service* sul percorso `/order-validation-service` - per esempio, `GET /order-validation-service/order-validations/{id}`

---

La cartella shell contiene gli scripts per lanciare e testare l'applicazione.

## Build 

Per fare il build dell'applicazione bisogna eseguire il seguente comando:

*  `gradle build`

## Execution

Per lanciare l'applicazione bisogna eseguire il seguente comando:

* start *Docker* - `docker-compose up`